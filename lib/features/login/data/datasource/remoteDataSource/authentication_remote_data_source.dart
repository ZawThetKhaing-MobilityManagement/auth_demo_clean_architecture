import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:demo_login_ui/core/const/const.dart';
import 'package:demo_login_ui/core/error/exception.dart';
import 'package:demo_login_ui/core/usecase/usecase.dart';
import 'package:demo_login_ui/core/utils/typedef.dart';
import 'package:demo_login_ui/features/login/data/model/user_model.dart';
import 'package:http/http.dart' as http;

abstract class UserRemoteDataSource {
  ResultFuture<UserModel> signUpwithEmailandPassword(SignInParams params);
}

class UserRemoteDataSourceImpl implements UserRemoteDataSource {
  final http.Client client;

  UserRemoteDataSourceImpl({required this.client});

  @override
  ResultFuture<UserModel> signUpwithEmailandPassword(
      SignInParams params) async {
    Uri url = Uri.parse(baseUrl);
    UserModel model = UserModel(username: params.name, email: params.email);

    try {
      //Just store userName and email for testing.
      final response = await client.post(
        url,
        body: model.toJson(),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        return Right(UserModel.fromJson(jsonDecode(response.body)));
      } else {
        throw Left(ServerException(statusCode: response.statusCode));
      }
    } on ServerException catch (e) {
      throw Left(ServerException(statusCode: e.statusCode));
    }
  }
}
