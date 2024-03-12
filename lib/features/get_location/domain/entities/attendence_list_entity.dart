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
