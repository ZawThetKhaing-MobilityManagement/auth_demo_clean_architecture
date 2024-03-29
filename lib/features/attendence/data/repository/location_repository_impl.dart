import 'package:dartz/dartz.dart';
import 'package:demo_login_ui/core/error/failure.dart';
import 'package:demo_login_ui/core/utils/typedef.dart';
import 'package:demo_login_ui/features/attendence/data/datasource/local_data_source/location_local_data_source.dart';
import 'package:demo_login_ui/features/attendence/data/datasource/remote_data_source/location_remote_data_source.dart';
import 'package:demo_login_ui/features/attendence/domain/entities/attendence_list_entity.dart';
import 'package:demo_login_ui/features/attendence/domain/entities/location_entity.dart';
import 'package:demo_login_ui/features/attendence/domain/repository/location_repository.dart';
import 'package:demo_login_ui/features/attendence/domain/usecases/get_current_location_usecase.dart';

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
      (location) async {
        await locationLocalDataSoure.removeCached();
        locationLocalDataSoure.setLocationCached(params);
        return Right(location);
      },
    );
  }

  @override
  ResultFuture<LocationEntity> getLocationFromCache() async {
    final result = await locationLocalDataSoure.getLocationCached();

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
      (attendenceList) {
        locationLocalDataSoure.setAttendenceCached(attendenceList);

        return Right(attendenceList);
      },
    );
  }

  @override
  ResultFuture<AttendenceListEntity> getAttendenceActivityFromCache() async {
    final result = await locationLocalDataSoure.getAttendenceListCached();
    return result.fold(
      (l) => Left(ServerFaliure(messages: l.messages)),
      (attendenceList) => Right(attendenceList),
    );
  }
}
