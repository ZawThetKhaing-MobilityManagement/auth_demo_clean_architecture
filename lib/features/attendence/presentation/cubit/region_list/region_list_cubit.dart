import 'package:demo_login_ui/features/attendence/data/model/dealer_list_model.dart';
import 'package:demo_login_ui/features/attendence/domain/usecases/get_dealer_list_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:demo_login_ui/features/attendence/data/model/region_list_model.dart';
import 'package:demo_login_ui/features/attendence/domain/usecases/get_region_list_usecase.dart';
import 'package:equatable/equatable.dart';

part 'region_list_state.dart';

class RegionListCubit extends Cubit<ShopListState> {
  RegionListCubit({
    required this.regionListUsecase,
    required this.dealerListUsecase,
  }) : super(
          ShopListInitial(),
        ) {
    fetchRegionList();
    fetchDealerList();
  }

  final GetRegionListUsecase regionListUsecase;
  final GetDealerListUsecase dealerListUsecase;
  DealerListModel? selectDealerList;

  DealerListModel? _dealerList;

  void regionDropDownChange(String? value) {
    final list = _dealerList?.dealerList
        .where((element) => element.regionId.toString() == value)
        .toList();
    DealerListModel model = DealerListModel(dealerList: list ?? []);
    emit(
      DropDownChangeState(
        region: value,
        regionModel: state.regionModel,
        dealerListModel: model,
      ),
    );
  }

  void dealerDropDownChange(String? value) {
    final selectedDealer = state.dealerListModel?.dealerList.firstWhere(
      (element) => element.id == int.tryParse(value ?? ""),
    );
    emit(
      DropDownChangeState(
        region: state.region,
        regionModel: state.regionModel,
        city: value,
        dealerListModel: state.dealerListModel,
        selectedDealerId: selectedDealer?.id,
      ),
    );
  }

  Future<void> fetchDealerList() async {
    emit(Loading());
    final result = await dealerListUsecase();

    result.fold(
      (l) => emit(DealerListEmpty()),
      (r) {
        _dealerList = r as DealerListModel;
        emit(
          DealerListLoaded(
            dealerListModel: _dealerList,
            regionModel: state.regionModel,
          ),
        );
      },
    );
  }

  Future<void> fetchRegionList() async {
    emit(Loading());

    final result = await regionListUsecase();

    result.fold(
      (l) => emit(RegionListEmpty()),
      (region) => emit(
        RegionListLoaded(
          regionModel: region as RegionListModel,
          dealerListModel: state.dealerListModel,
        ),
      ),
    );
  }
}
