import 'package:demo_login_ui/core/utils/typedef.dart';
import 'package:demo_login_ui/features/login/domain/entities/user_entity.dart';

class UserModel extends UserEntity {
  const UserModel({
    super.id,
    required super.name,
    required super.email,
    super.token,
  });

  factory UserModel.fromJson(DataMap json) => UserModel(
        name: json['data']['name'],
        email: json['data']['email'],
        token: json['data']['token'],
      );

  DataMap toJson() => {
        'data': {
          'name': name,
          'email': email,
          'token': token,
        }
      };

  UserEntity toEntity() => UserEntity(
        name: name,
        email: email,
        token: token,
      );

  factory UserModel.fromEntity(UserEntity userEntity) => UserModel(
        name: userEntity.name,
        email: userEntity.email,
        token: userEntity.token,
      );
}
