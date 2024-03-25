import 'package:demo_login_ui/core/utils/typedef.dart';
import 'package:demo_login_ui/features/attendence/domain/entities/attendence_list_entity.dart';

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

  factory AttendenceListModel.fromEntity(AttendenceListEntity entity) {
    final model = AttendenceListModel(data: entity.data);

    return model;
  }

  AttendenceListEntity toEntity() => AttendenceListEntity(data: data);

  DataMap toJson() => {
        'data': data
            .map(
              (e) => (e as AttendenceModel).toJson(),
            )
            .toList(),
      };
}

class AttendenceModel extends AttendenceEntity {
  const AttendenceModel({
    required super.dealerName,
    required super.createdAt,
    required super.checkIn,
    required super.checkOut,
    required super.isLate,
    super.remark,
  });

  factory AttendenceModel.fromJson(DataMap json) {
    return AttendenceModel(
      remark: json['remark'],
      createdAt: DateTime.tryParse(json['created_at']) ?? DateTime.now(),
      checkIn: DateTime.tryParse(json['check_in']) ?? DateTime.now(),
      checkOut: DateTime.tryParse(json['check_out'] ?? ''),
      isLate: json['is_late'] == 0 ? false : true,
      dealerName: json['dealer_name'],
    );
  }

  AttendenceModel toEntity() => AttendenceModel(
        remark: remark,
        createdAt: createdAt,
        checkIn: checkIn,
        checkOut: checkOut,
        isLate: isLate,
        dealerName: dealerName,
      );

  DataMap toJson() => {
        'remark': remark.toString(),
        'created_at': createdAt.toString(),
        'check_in': checkIn.toString(),
        'check_out': checkOut.toString(),
        'is_late': isLate.toString(),
        'dealer_name': dealerName
      };
}
