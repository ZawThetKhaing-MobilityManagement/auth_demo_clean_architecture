import 'package:demo_login_ui/core/utils/typedef.dart';

class AttendenceListEntity {
  const AttendenceListEntity({required this.data});
  final List<AttendenceEntity> data;
}

class AttendenceEntity {
  const AttendenceEntity({
    required this.status,
    required this.createdAt,
  });
  final String status;
  final DateTime createdAt;
}
