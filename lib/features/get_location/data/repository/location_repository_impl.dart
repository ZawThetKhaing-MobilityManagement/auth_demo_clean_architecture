import 'package:dartz/dartz.dart';
import 'package:demo_login_ui/core/error/failure.dart';
import 'package:demo_login_ui/core/utils/typedef.dart';
import 'package:demo_login_ui/features/get_location/data/datasource/local_data_source/location_local_data_source.dart';
import 'package:demo_login_ui/features/get_location/data/datasource/remote_data_source/location_remote_data_source.dart';
import 'package:demo_login_ui/features/get_location/domain/entities/attendence_list_entity.dart';
import 'package:demo_login_ui/features/get_location/domain/entities/location_entity.dart';
import 'package:demo_login_ui/features/get_location/domain/repository/location_repository.dart';
import 'package:demo_login_ui/features/get_location/domain/usecases/get_current_location_usecase.dart';

class LocationRepositoryImpl implements LocationRepository {
  LocationRepositoryImpl({
    required this.locationRemoteDataSource,
    required this.locationLocalDataSoure,
  });
  final LocationRemoteDataSource locationRemoteDataSource;
  final LocationLocalDataSoure locationLocalDataSoure;

  @override
  ResultFuture<LocationEntity> getCurrentLocation(
      {required LocationParams params}) async {
    final result = await locationRemoteDataSource.getCurrentLocation(params);

    return result.fold(
      (faliure) {
        return Left(ServerFaliure(messages: faliure.messages));
      },
      (location) {
        locationLocalDataSoure.setLocationCached(params);

        return Right(location);
      },
    );
  }

  @override
  ResultFuture<LocationEntity> getLocationCache() async {
    final result = await locationLocalDataSoure.getCached();
    return result.fold(
      (l) => Left(CacheFaliure(messages: l.messages)),
      (r) => Right(r.toEntity()),
    );
  }

  @override
  ResultFuture<AttendenceListEntity> getAttendenceActivity(String token) async {
    final result = await locationRemoteDataSource.getAttendenceActivity(token);
    return result.fold(
      (l) => Left(ServerFaliure(messages: l.messages)),
      (attendenceList) => Right(attendenceList),
    );
  }
}
