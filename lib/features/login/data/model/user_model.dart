import 'package:demo_login_ui/core/utils/typedef.dart';
import 'package:demo_login_ui/features/login/domain/entities/user_entity.dart';

class UserModel extends UserEntity {
  const UserModel({
    required super.name,
    required super.phone,
    required super.leaveBalance,
    required super.userCode,
    required super.joinDate,
    required super.officeStartTime,
    required super.officeEndTime,
    required super.employeeRole,
    required super.shop,
    super.token,
    super.image,
    super.id,
  });

  factory UserModel.fromJson(DataMap json) {
    final Map<String, dynamic> map = json['data'];
    return UserModel(
      name: map['name'],
      phone: map['phone'],
      token: map['token'],
      image: map['image'],
      leaveBalance: map['leave_balance'],
      userCode: map['user_code'],
      joinDate: map['join_date'],
      officeStartTime: map['shop_open_time'],
      officeEndTime: map['shop_close_time'],
      employeeRole: map['employee_role'],
      shop: map['shop'],
    );
  }

  DataMap toJson() => {
        'data': {
          'name': name,
          'phone': phone,
          'token': token,
          'image': image,
          'leave_balance': leaveBalance,
          'user_code': userCode,
          'join_date': joinDate,
          'shop_open_time': officeStartTime,
          'shop_close_time': officeEndTime,
          'id': id,
          'employee_role': employeeRole,
          'shop': shop,
        }
      };

  UserEntity toEntity() => UserEntity(
        name: name,
        phone: phone,
        leaveBalance: leaveBalance,
        userCode: userCode,
        joinDate: joinDate,
        officeStartTime: officeStartTime,
        officeEndTime: officeEndTime,
        token: token,
        image: image,
        id: id,
        employeeRole: employeeRole,
        shop: shop,
      );

  factory UserModel.fromEntity(UserEntity userEntity) => UserModel(
        name: userEntity.name,
        phone: userEntity.phone,
        leaveBalance: userEntity.leaveBalance,
        userCode: userEntity.userCode,
        joinDate: userEntity.joinDate,
        officeStartTime: userEntity.officeStartTime,
        officeEndTime: userEntity.officeEndTime,
        token: userEntity.token,
        image: userEntity.image,
        id: userEntity.id,
        employeeRole: userEntity.employeeRole,
        shop: userEntity.shop,
      );
}
