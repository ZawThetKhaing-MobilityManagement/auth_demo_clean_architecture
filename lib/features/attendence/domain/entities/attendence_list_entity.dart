class AttendenceListEntity {
  const AttendenceListEntity({required this.data});
  final List<AttendenceEntity> data;
}

class AttendenceEntity {
  const AttendenceEntity({
    required this.checkIn,
    required this.createdAt,
    required this.isLate,
    required this.dealerName,
    this.remark,
    this.checkOut,
  });
  final String dealerName;
  final DateTime checkIn;
  final DateTime? checkOut;
  final bool isLate;
  final DateTime createdAt;
  final String? remark;
}
