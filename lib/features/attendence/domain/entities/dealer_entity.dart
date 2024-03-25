import 'package:equatable/equatable.dart';

class DealerListEntity extends Equatable {
  const DealerListEntity({required this.dealerList});

  final List<DealerEntity> dealerList;

  @override
  List<Object?> get props => [dealerList];
}

class DealerEntity extends Equatable {
  const DealerEntity(
      {required this.id, required this.regionId, required this.name});

  final int id;
  final int regionId;
  final String name;

  @override
  List<Object?> get props => [id, regionId, name];
}
