import 'package:demo_login_ui/features/attendence/domain/entities/dealer_entity.dart';

class DealerListModel extends DealerListEntity {
  const DealerListModel({required super.dealerList});

  factory DealerListModel.fromJson(Map<String, dynamic> json) =>
      DealerListModel(
        dealerList: (json['dealer'] as List<dynamic>)
            .map((e) => DealerModel.fromJson(e as Map<String, dynamic>))
            .toList(),
      );

  Map<String, dynamic> toJson() => {
        'dealer': dealerList.map(
          (e) => (e as DealerModel).toJson(),
        ),
      };
}

class DealerModel extends DealerEntity {
  const DealerModel({
    required super.id,
    required super.regionId,
    required super.name,
  });

  factory DealerModel.fromJson(Map<String, dynamic> json) => DealerModel(
        id: json['id'],
        regionId: json['region_id'],
        name: json['name'],
      );

  Map<String, dynamic> toJson() => {
        "dealer": {
          'id': id,
          'region_id': regionId,
          'name': name,
        }
      };
}
