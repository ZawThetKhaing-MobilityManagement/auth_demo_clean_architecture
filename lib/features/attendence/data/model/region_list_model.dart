import 'package:demo_login_ui/features/attendence/domain/entities/region_entity.dart';

class RegionListModel extends RegionListEntity {
  const RegionListModel({
    required super.regionList,
  });

  factory RegionListModel.fromJson(Map<String, dynamic> json) =>
      RegionListModel(
        regionList: (json['region'] as List<dynamic>)
            .map((e) => RegionModel.fromJson(e as Map<String, dynamic>))
            .toList(),
      );

  Map<String, dynamic> toJson() => {
        "region": regionList.map(
          (e) => (e as RegionModel).toJson(),
        ),
      };
}

class RegionModel extends RegionEntity {
  const RegionModel({
    required super.id,
    required super.name,
  });

  factory RegionModel.fromJson(Map<String, dynamic> json) => RegionModel(
        id: json['id'],
        name: json['name'],
      );

  Map<String, dynamic> toJson() => {
        'region': {
          "id": id,
          "name": name,
        }
      };
}
