import 'package:equatable/equatable.dart';

class LeaveResponseEntity extends Equatable {
  const LeaveResponseEntity({required this.leaveList});

  final List<LeaveEntity> leaveList;

  @override
  List<Object?> get props => [leaveList];
}

class LeaveEntity extends Equatable {
  const LeaveEntity({
    required this.reason,
    required this.startDate,
    required this.endDate,
    required this.permissionType,
    this.status,
    this.approvedBy,
    this.createdAt,
  });
  final String reason;
  final DateTime startDate;
  final DateTime endDate;
  final String permissionType;

  final String? status;
  final String? approvedBy;
  final DateTime? createdAt;
  @override
  List<Object?> get props => [
        reason,
        permissionType,
        startDate,
        endDate,
        status,
        approvedBy,
        createdAt,
      ];
}
