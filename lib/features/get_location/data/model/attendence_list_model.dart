import 'package:demo_login_ui/core/utils/typedef.dart';
import 'package:demo_login_ui/features/get_location/domain/entities/attendence_list_entity.dart';

class AttendenceListModel extends AttendenceListEntity {
  const AttendenceListModel({required super.data});

  factory AttendenceListModel.fromJson(DataMap json) => AttendenceListModel(
        data: (json['data'] as List)
            .map(
              (e) => AttendenceModel.fromJson(
                e as Map<String, dynamic>,
              ),
            )
            .toList(),
      );
  factory AttendenceListModel.fromEntity(AttendenceListEntity entity) =>
      AttendenceListModel(data: entity.data);
  AttendenceListEntity toEntity() => AttendenceListEntity(data: data);
}

class AttendenceModel extends AttendenceEntity {
  const AttendenceModel({
    required super.status,
    required super.createdAt,
  });

  factory AttendenceModel.fromJson(DataMap json) => AttendenceModel(
        status: json['status'],
        createdAt: DateTime.tryParse(json['created_at']) ?? DateTime.now(),
      );

  AttendenceModel toEntity() =>
      AttendenceModel(status: status, createdAt: createdAt);
}
