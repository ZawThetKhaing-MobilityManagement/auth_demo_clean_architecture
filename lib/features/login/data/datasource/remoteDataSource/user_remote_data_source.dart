import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:demo_login_ui/core/const/const.dart';
import 'package:demo_login_ui/core/error/exception.dart';
import 'package:demo_login_ui/core/error/failure.dart';
import 'package:demo_login_ui/core/utils/typedef.dart';
import 'package:demo_login_ui/features/login/data/model/user_model.dart';
import 'package:demo_login_ui/features/login/domain/usecases/change_password_usecase.dart';
import 'package:demo_login_ui/features/login/domain/usecases/login_usecase.dart';
import 'package:http/http.dart' as http;

abstract class UserRemoteDataSource {
  ResultFuture<UserModel> login(LoginInParams params);
  ResultVoid logout(String token);
  ResultVoid changePassword(ChangePasswordParams params);
}

class UserRemoteDataSourceImpl implements UserRemoteDataSource {
  final http.Client client;

  UserRemoteDataSourceImpl({required this.client});

  @override
  ResultFuture<UserModel> login(LoginInParams params) async =>
      apiService(Urls.login, loginInParams: params);

  @override
  ResultVoid logout(String token) async {
    Uri uri = Uri.parse(Urls.logout);
    try {
      final response = await client.post(
        uri,
        headers: {
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        return const Right(null);
      } else {
        throw Left(
          ServerException(
              statusCode: response.statusCode, message: response.body),
        );
      }
    } on ServerException catch (e) {
      throw Left(ServerException(statusCode: e.statusCode, message: e.message));
    }
  }

  @override
  ResultVoid changePassword(ChangePasswordParams params) async {
    final Uri uri = Uri.parse(Urls.changePassword);
    Map toJson = {
      '_method': 'PUT',
      'current_password': params.currentPassword,
      'new_password': params.newPassword,
    };
    try {
      final response = await client.post(
        uri,
        body: toJson,
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer ${params.token}'
        },
      );

      print(response.statusCode);
      print(response.body);

      if (response.statusCode == 200 || response.statusCode == 201) {
        return const Right(null);
      } else {
        final errorMessage =
            (jsonDecode(response.body) as Map<String, dynamic>)['data'];

        return Left(
          ServerFaliure(
            messages: errorMessage[0],
          ),
        );
      }
    } on ServerException catch (e) {
      throw Left(
        ServerException(
          statusCode: e.statusCode,
          message: e.message,
        ),
      );
    }
  }

  ResultFuture<UserModel> apiService(
    String url, {
    required LoginInParams loginInParams,
  }) async {
    Uri uri = Uri.parse(url);
    Map toJson = {
      'phone': loginInParams.phone,
      'password': loginInParams.password,
    };

    try {
      final response = await client.post(
        uri,
        body: toJson,
        headers: {
          'Accept': 'application/json',
        },
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        UserModel model = UserModel.fromJson(jsonDecode(response.body));

        return Right(model);
      } else {
        final errorMessage =
            (jsonDecode(response.body) as Map<String, dynamic>)['data'];

        return Left(
          ServerFaliure(
            messages: errorMessage[0],
          ),
        );
      }
    } on ServerException catch (e) {
      throw Left(
        ServerException(
          statusCode: e.statusCode,
          message: e.message,
        ),
      );
    }
  }
}
