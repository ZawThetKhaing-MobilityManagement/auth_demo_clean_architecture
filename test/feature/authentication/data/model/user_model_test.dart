import 'dart:convert';
import 'package:demo_login_ui/features/login/data/model/user_model.dart';
import 'package:demo_login_ui/features/login/domain/entities/user_entity.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../helper/json_reader/json_reader.dart';

void main() {
  late UserModel userModel;

  setUp(
    () {
      userModel = const UserModel(
          id: 1, email: 'email@gmail.com', name: 'userName', token: '');
    },
  );

  group('user model test', () {
    test(
      'should be pass UserModel when fromJson called',
      () {
        final user = UserModel.fromJson(
            jsonDecode(readJson('test/feature/helper/user.json')));

        expect(user.id, userModel.id);
        expect(user.name, userModel.name);

        expect(user.email, userModel.email);
      },
    );

    test('should be return map when call to json', () {
      final result = userModel.toJson();

      final expected = {
        "email": "email@gmail.com",
        "id": 1,
        "userName": "userName"
      };
      expect(result, equals(expected));
    });

    test('should be return entity when call to entity', () {
      final result = userModel.toEntity();

      const expected = UserEntity(name: 'username', email: 'email', id: 1);
      expect(result, equals(expected));
    });
  });
}
