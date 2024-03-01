import 'package:demo_login_ui/core/utils/typedef.dart';
import 'package:demo_login_ui/features/login/domain/entities/user_entity.dart';

class UserModel extends UserEntity {
  const UserModel({
    super.id,
    required super.username,
    required super.email,
  });

  factory UserModel.fromJson(DataMap json) => UserModel(
        username: json['userName'],
        email: json['email'],
      );

  DataMap toJson() => {
        'userName': username,
        'email': email,
      };

  UserEntity toEntity() => UserEntity(
        username: username,
        email: email,
      );

  factory UserModel.fromEntity(UserEntity userEntity) => UserModel(
        username: userEntity.username,
        email: userEntity.email,
      );
}
