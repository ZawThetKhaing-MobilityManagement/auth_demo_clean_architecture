import 'package:demo_login_ui/core/utils/typedef.dart';
import 'package:demo_login_ui/features/leave/domain/entities/leave_entity.dart';

class LeaveResponseModel extends LeaveResponseEntity {
  const LeaveResponseModel({required super.leaveList});

  factory LeaveResponseModel.fromJson(DataMap json) => LeaveResponseModel(
        leaveList: (json['data'] as List)
            .map((e) => LeaveModel.fromJson(e as DataMap))
            .toList(),
      );
  factory LeaveResponseModel.fromEntity(LeaveResponseEntity entity) =>
      LeaveResponseModel(
        leaveList: entity.leaveList,
      );

  DataMap toJson() => {
        'data': leaveList.map((e) => (e as LeaveModel).toJson()).toList(),
      };
}

class LeaveModel extends LeaveEntity {
  const LeaveModel({
    required super.reason,
    required super.startDate,
    required super.endDate,
    required super.permissionType,
    super.status,
    super.approvedBy,
    super.createdAt,
  });

  factory LeaveModel.fromJson(DataMap json) => LeaveModel(
        reason: json['reason'],
        startDate: DateTime.parse(json['start_date']),
        endDate: DateTime.parse(json['end_date']),
        permissionType: json['permission_type'],
        status: json['status'],
        approvedBy: json['approved_by'],
        createdAt: DateTime.parse(json['created_at']),
      );

  factory LeaveModel.fromEntity(LeaveEntity entity) => LeaveModel(
        reason: entity.reason,
        startDate: entity.startDate,
        endDate: entity.endDate,
        permissionType: entity.permissionType,
        status: entity.status,
        approvedBy: entity.approvedBy,
        createdAt: entity.createdAt,
      );

  DataMap toJson() => {
        'reason': reason.toString(),
        'start_date': startDate.toString().split(' ').first,
        'end_date': endDate.toString(),
        'permission_type': permissionType.toString().split(' ').first,
        'created_at': createdAt.toString(),
        'approved_by': approvedBy.toString(),
        'status': status.toString(),
      };

  LeaveEntity toEntity() => LeaveEntity(
        reason: reason,
        startDate: startDate,
        endDate: endDate,
        permissionType: permissionType,
        status: status,
        approvedBy: approvedBy,
        createdAt: createdAt,
      );
}
