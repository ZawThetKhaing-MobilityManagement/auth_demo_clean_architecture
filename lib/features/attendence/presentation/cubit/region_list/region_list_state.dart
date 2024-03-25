part of 'region_list_cubit.dart';

abstract class ShopListState extends Equatable {
  const ShopListState({
    this.regionModel,
    this.dealerListModel,
    this.selectedDealerId,
    this.city,
    this.region,
  });

  final RegionListModel? regionModel;
  final DealerListModel? dealerListModel;
  final int? selectedDealerId;
  final String? city;
  final String? region;

  @override
  List<Object?> get props => [
        regionModel,
        city,
        selectedDealerId,
        region,
        dealerListModel,
      ];
}

class ShopListInitial extends ShopListState {}

class RegionListLoaded extends ShopListState {
  const RegionListLoaded({
    super.dealerListModel,
    super.regionModel,
  });
}

class RegionListEmpty extends ShopListState {}

class Loading extends ShopListState {}

class DealerListLoaded extends ShopListState {
  const DealerListLoaded({
    super.dealerListModel,
    super.regionModel,
    super.city,
    super.region,
  });
}

class DealerListEmpty extends ShopListState {}

class DropDownChangeState extends ShopListState {
  const DropDownChangeState({
    super.city,
    super.region,
    super.regionModel,
    super.dealerListModel,
    super.selectedDealerId,
  });
}
