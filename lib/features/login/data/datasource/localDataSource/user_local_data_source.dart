import "dart:convert";

import "package:dartz/dartz.dart";
import "package:demo_login_ui/core/const/const.dart";
import "package:demo_login_ui/core/error/failure.dart";
import "package:demo_login_ui/core/utils/typedef.dart";
import "package:demo_login_ui/features/login/data/model/user_model.dart";
import "package:shared_preferences/shared_preferences.dart";

abstract class UserLocalDataSource {
  Future<bool> setCached(UserModel modelToCached);
  ResultFuture<UserModel> getCached();
  ResultFuture<void> removeCached();
}

class UserLocalDataSourceImpl implements UserLocalDataSource {
  final SharedPreferences sharedPreferences;

  UserLocalDataSourceImpl({
    required this.sharedPreferences,
  });

  @override
  ResultFuture<UserModel> getCached() async {
    final jsonString = sharedPreferences.getString(USER_CACHED);

    if (jsonString != null) {
      return Right(
        UserModel.fromJson(
          jsonDecode(jsonString),
        ),
      );
    } else {
      return const Left(CacheFaliure(messages: "No Data"));
    }
  }

  @override
  Future<bool> setCached(UserModel modelToCached) async {
    return sharedPreferences.setString(
        USER_CACHED, json.encode(modelToCached.toJson()));
  }

  @override
  ResultFuture<void> removeCached() async {
    final result = await sharedPreferences.remove(USER_CACHED);
    if (result) {
      return const Right(null);
    } else {
      return const Left(CacheFaliure(messages: 'No data'));
    }
  }
}
