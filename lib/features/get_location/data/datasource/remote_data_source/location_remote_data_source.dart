import 'package:dartz/dartz.dart';
import 'package:demo_login_ui/core/utils/typedef.dart';
import 'package:demo_login_ui/features/get_location/data/model/location_model.dart';
import 'package:demo_login_ui/features/get_location/domain/usecases/get_current_location_usecase.dart';
import 'package:http/http.dart' as http;

abstract class LocationRemoteDataSource {
  ResultFuture<LocationModel> getCurrentLocation(LocationParams params);
}

class LocationRemoteDataSourceImpl extends LocationRemoteDataSource {
  LocationRemoteDataSourceImpl({required this.client});
  final http.Client client;

  @override
  ResultFuture<LocationModel> getCurrentLocation(LocationParams params) async {
    LocationModel locationModel =
        LocationModel(lat: params.lat, lon: params.lon);

    Uri uri = Uri.parse('uri');
    try {
      final response = await client.post(
        uri,
        body: locationModel.toJson(),
        headers: {'Accept': 'application/json'},
      );

      return Right(locationModel);
    } catch (e) {
      throw Left(Exception());
    }
  }
}
