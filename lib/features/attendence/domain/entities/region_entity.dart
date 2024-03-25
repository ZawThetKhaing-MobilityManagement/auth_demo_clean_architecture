import 'package:equatable/equatable.dart';

class RegionListEntity extends Equatable {
  const RegionListEntity({required this.regionList});

  final List<RegionEntity> regionList;

  @override
  List<Object?> get props => [];
}

class RegionEntity extends Equatable {
  const RegionEntity({required this.id, required this.name});

  final int id;
  final String name;

  @override
  List<Object?> get props => [id, name];
}
