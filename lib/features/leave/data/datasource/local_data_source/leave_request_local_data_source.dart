import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:demo_login_ui/core/const/const.dart';
import 'package:demo_login_ui/core/error/failure.dart';
import 'package:demo_login_ui/core/utils/typedef.dart';
import 'package:demo_login_ui/features/leave/data/model/leave_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class LeaveRequestLocalDataSource {
  Future<bool> setCached(LeaveResponseModel modelToCached);
  ResultFuture<LeaveResponseModel> getCached();
  ResultFuture<void> removeCached();
}

class LeaveRequestLocalDataSourceImpl implements LeaveRequestLocalDataSource {
  const LeaveRequestLocalDataSourceImpl({required this.sharedPreferences});
  final SharedPreferences sharedPreferences;

  @override
  ResultFuture<LeaveResponseModel> getCached() async {
    final result = sharedPreferences.getString(LEAVE_CACHED);

    if (result != null) {
      return Right(LeaveResponseModel.fromJson(jsonDecode(result)));
    } else {
      return const Left(CacheFaliure(messages: "No cached data."));
    }
  }

  @override
  ResultFuture<void> removeCached() async {
    try {
      final result = await sharedPreferences.remove(LEAVE_CACHED);
      if (result) {
        return const Right(null);
      } else {
        return const Left(CacheFaliure(messages: "Cached remove failed."));
      }
    } catch (e) {
      return const Left(CacheFaliure(messages: "Cached remove failed."));
    }
  }

  @override
  Future<bool> setCached(LeaveResponseModel modelToCached) => sharedPreferences
      .setString(LEAVE_CACHED, jsonEncode(modelToCached.toJson()));
}
