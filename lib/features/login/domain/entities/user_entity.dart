import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
  const UserEntity({
    this.id,
    required this.name,
    required this.phone,
    required this.leaveBalance,
    required this.userCode,
    required this.joinDate,
    required this.officeStartTime,
    required this.officeEndTime,
    required this.employeeRole,
    required this.shop,
    this.image,
    this.token,
  });

  const UserEntity.empty()
      : this(
          id: 1,
          name: '_empty.username',
          phone: '_empty.email',
          image: '',
          leaveBalance: 0,
          userCode: '',
          joinDate: '',
          officeEndTime: '',
          officeStartTime: '',
          employeeRole: '',
          shop: '',
        );

  final int? id;
  final String name;
  final String phone;
  final String? token;
  final String? image;
  final int leaveBalance;
  final String userCode;
  final String joinDate;
  final String officeStartTime;
  final String officeEndTime;
  final String employeeRole;
  final String shop;

  @override
  List<Object?> get props => [
        id,
        name,
        phone,
        token,
        image,
        leaveBalance,
        userCode,
        joinDate,
        officeStartTime,
        officeEndTime,
        employeeRole,
        shop,
      ];
}
