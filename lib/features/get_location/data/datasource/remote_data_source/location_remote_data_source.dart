import 'package:dartz/dartz.dart';
import 'package:demo_login_ui/core/const/const.dart';
import 'package:demo_login_ui/core/error/failure.dart';
import 'package:demo_login_ui/core/utils/typedef.dart';
import 'package:demo_login_ui/features/get_location/data/model/location_model.dart';
import 'package:demo_login_ui/features/get_location/domain/usecases/get_current_location_usecase.dart';
import 'package:http/http.dart' as http;

abstract class LocationRemoteDataSource {
  ResultFuture<String> getCurrentLocation(LocationParams params);
}

class LocationRemoteDataSourceImpl extends LocationRemoteDataSource {
  LocationRemoteDataSourceImpl({required this.client});
  final http.Client client;

  @override
  ResultFuture<String> getCurrentLocation(LocationParams params) async {
    LocationModel locationModel = LocationModel(
      lat: params.lat,
      lon: params.lon,
    );

    Uri uri = Uri.parse(Urls.attendence);

    try {
      final response = await client.post(
        uri,
        body: locationModel.toJson(),
        headers: {
          "Accept": "application/json",
          "Authorization": "Bearer ${params.token}",
        },
      );

      print(response.statusCode);
      print(response.body);

      if (response.statusCode == 200) {
        return const Right("Attendence register successfully");
      } else {
        return const Left(
          ServerFaliure(messages: "Please click me in specified place"),
        );
      }
    } catch (e) {
      print(e);
      throw Left(Exception());
    }
  }
}
