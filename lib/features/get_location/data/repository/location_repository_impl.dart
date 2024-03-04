import 'package:dartz/dartz.dart';
import 'package:demo_login_ui/core/error/failure.dart';
import 'package:demo_login_ui/core/utils/typedef.dart';
import 'package:demo_login_ui/features/get_location/data/datasource/remote_data_source/location_remote_data_source.dart';
import 'package:demo_login_ui/features/get_location/domain/entities/location_entity.dart';
import 'package:demo_login_ui/features/get_location/domain/repository/location_repository.dart';
import 'package:demo_login_ui/features/get_location/domain/usecases/get_current_location_usecase.dart';

class LocationRepositoryImpl implements LocationRepository {
  LocationRepositoryImpl({required this.locationRemoteDataSource});
  final LocationRemoteDataSource locationRemoteDataSource;

  @override
  ResultFuture<LocationEntity> getCurrentLocation(
      {required LocationParams params}) async {
    final result = await locationRemoteDataSource.getCurrentLocation(params);

    return result.fold(
      (faliure) {
        return Left(ServerFaliure(messages: faliure.messages));
      },
      (location) {
        return Right(location);
      },
    );
  }
}
