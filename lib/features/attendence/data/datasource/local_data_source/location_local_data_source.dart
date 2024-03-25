import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:demo_login_ui/core/const/const.dart';
import 'package:demo_login_ui/core/error/failure.dart';
import 'package:demo_login_ui/core/utils/typedef.dart';
import 'package:demo_login_ui/features/attendence/data/model/attendence_list_model.dart';
import 'package:demo_login_ui/features/attendence/data/model/location_model.dart';
import 'package:demo_login_ui/features/attendence/domain/entities/attendence_list_entity.dart';
import 'package:demo_login_ui/features/attendence/domain/usecases/get_current_location_usecase.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class LocationLocalDataSoure {
  Future<bool> setLocationCached(LocationParams params);
  Future<bool> setAttendenceCached(AttendenceListEntity entity);

  ResultFuture<AttendenceListModel> getAttendenceListCached();
  ResultFuture<LocationModel> getLocationCached();

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
  ResultFuture<LocationModel> getLocationCached() async {
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

  @override
  ResultFuture<AttendenceListModel> getAttendenceListCached() async {
    final attendenceCache = sharedPreferences.getString(ATTENDENCE_CACHED);

    if (attendenceCache != null) {
      AttendenceListModel location =
          AttendenceListModel.fromJson(jsonDecode(attendenceCache));
      return Right(location);
    } else {
      return const Left(CacheFaliure(messages: "No Data"));
    }
  }

  @override
  Future<bool> setAttendenceCached(AttendenceListEntity entity) {
    AttendenceListModel model = AttendenceListModel.fromEntity(entity);

    return sharedPreferences.setString(
        ATTENDENCE_CACHED, jsonEncode(model.toJson()));
  }
}
