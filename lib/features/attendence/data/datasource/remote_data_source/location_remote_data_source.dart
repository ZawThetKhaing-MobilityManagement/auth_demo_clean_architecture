import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:demo_login_ui/core/const/const.dart';
import 'package:demo_login_ui/core/error/failure.dart';
import 'package:demo_login_ui/core/utils/typedef.dart';
import 'package:demo_login_ui/features/attendence/data/model/attendence_list_model.dart';
import 'package:demo_login_ui/features/attendence/data/model/location_model.dart';
import 'package:demo_login_ui/features/attendence/domain/entities/attendence_list_entity.dart';
import 'package:demo_login_ui/features/attendence/domain/entities/location_entity.dart';
import 'package:demo_login_ui/features/attendence/domain/usecases/get_current_location_usecase.dart';
import 'package:http/http.dart' as http;

abstract class LocationRemoteDataSource {
  ResultFuture<LocationEntity> getCurrentLocation(LocationParams params);

  ResultFuture<AttendenceListEntity> getAttendenceActivity(String token);
}

class LocationRemoteDataSourceImpl extends LocationRemoteDataSource {
  LocationRemoteDataSourceImpl({required this.client});
  final http.Client client;

  @override
  ResultFuture<LocationEntity> getCurrentLocation(LocationParams params) async {
    Map json;

    Uri uri;
    if (params.status == CHECK_OUT) {
      uri = Uri.parse(Urls.attendenceCheckOut(params.id));

      json = {
        '_method': 'PUT',
        'lat': params.lat.toString(),
        'lon': params.lon.toString(),
        if (params.dealerId != null) 'dealer_id': params.dealerId.toString(),
      };
    } else {
      uri = Uri.parse(Urls.attendenceCheckIn);
      json = {
        'lat': params.lat.toString(),
        'lon': params.lon.toString(),
        if (params.dealerId != null) 'dealer_id': params.dealerId.toString(),
      };
    }

    try {
      final response = await client.post(
        uri,
        body: json,
        headers: {
          "Accept": "application/json",
          "Authorization": "Bearer ${params.token}",
        },
      );
      if (response.statusCode == 200) {
        final model = LocationModel.fromJson(jsonDecode(response.body));

        return Right(model
            .copyWith(
              status: params.status,
            )
            .toEntity());
      } else {
        return const Left(
          ServerFaliure(messages: "Please click me in specified place."),
        );
      }
    } catch (e) {
      throw Left(Exception());
    }
  }

  @override
  ResultFuture<AttendenceListEntity> getAttendenceActivity(String token) async {
    Uri uri = Uri.parse(Urls.attendenceList);

    try {
      final response = await client.get(
        uri,
        headers: {
          "Accept": "application/json",
          "Authorization": "Bearer $token",
        },
      );

      if (response.statusCode == 200) {
        AttendenceListModel model = AttendenceListModel.fromJson(
          jsonDecode(response.body),
        );
        return Right(
          model.toEntity(),
        );
      } else {
        return Left(ServerFaliure(messages: response.body));
      }
    } catch (e) {
      return const Left(
        ApiFaliure(messages: "Something went wrong"),
      );
    }
  }
}
