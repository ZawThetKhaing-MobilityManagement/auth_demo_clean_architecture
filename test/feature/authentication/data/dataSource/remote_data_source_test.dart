import 'dart:convert';

import 'package:demo_login_ui/core/const/const.dart';
import 'package:demo_login_ui/core/error/exception.dart';
import 'package:demo_login_ui/core/usecase/usecase.dart';
import 'package:demo_login_ui/features/login/data/datasource/remoteDataSource/authentication_remote_data_source.dart';
import 'package:demo_login_ui/features/login/data/model/user_model.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../helper/test_helper.mocks.dart';

void main() {
  late MockClient client;
  late UserRemoteDataSourceImpl dataSourceImpl;

  setUp(() {
    client = MockClient();
    dataSourceImpl = UserRemoteDataSourceImpl(client: client);
  });
  final params = SignInParams(email: 'email@gmail.com', name: 'username');

  const tUserModel = UserModel(username: 'username', email: 'email@gmail.com');

  test(
    'should be pass remote data when sign in',
    () async {
      final response =
          await client.post(Uri.parse(baseUrl), body: tUserModel.toJson());
      final model = UserModel.fromJson(jsonDecode(response.body));
      final result = await dataSourceImpl.signUpwithEmailandPassword(params);

      result.fold(
        (l) => expect(l, ServerException),
        (r) => expect(
          r,
          model,
        ),
      );
    },
  );
}