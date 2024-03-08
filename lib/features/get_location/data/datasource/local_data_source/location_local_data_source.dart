import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:demo_login_ui/core/const/const.dart';
import 'package:demo_login_ui/core/error/failure.dart';
import 'package:demo_login_ui/core/utils/typedef.dart';
import 'package:demo_login_ui/features/get_location/data/model/location_model.dart';
import 'package:demo_login_ui/features/get_location/domain/usecases/get_current_location_usecase.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class LocationLocalDataSoure {
  Future<bool> setLocationCached(LocationParams params);

  ResultFuture<LocationModel> getCached();
  ResultFuture<void> removeCached();
}

class LocationLocalDataSoureImpl implements LocationLocalDataSoure {
  const LocationLocalDataSoureImpl({required this.sharedPreferences});

  final SharedPreferences sharedPreferences;

  @override
  Future<bool> setLocationCached(LocationParams params) async {
    LocationModel model = LocationModel(
      lat: params.lat,
      lon: params.lon,
      clockIn: params.clockIn,
      clockOut: params.clockOut,
      status: params.status,
    );
    return sharedPreferences.setString(
        LOCATION_CACHED, jsonEncode(model.toJson()));
  }

  @override
  ResultFuture<LocationModel> getCached() async {
    final locationCache = sharedPreferences.getString(LOCATION_CACHED);
    if (locationCache != null) {
      LocationModel location =
          LocationModel.fromJson(jsonDecode(locationCache));
      return Right(location);
    } else {
      return const Left(CacheFaliure(messages: "No Data"));
    }
  }

  @override
  ResultFuture<void> removeCached() async {
    try {
      sharedPreferences.remove(LOCATION_CACHED);
      return const Right(null);
    } catch (e) {
      return const Left(CacheFaliure(messages: "Remove Cache Failed"));
    }
  }
}
