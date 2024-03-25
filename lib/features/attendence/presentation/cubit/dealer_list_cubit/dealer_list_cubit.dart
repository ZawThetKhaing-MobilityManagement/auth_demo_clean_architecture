import 'package:demo_login_ui/features/attendence/domain/usecases/get_dealer_list_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'dealer_list_state.dart';

class DealerListCubit extends Cubit<DealerListState> {
  DealerListCubit({required this.getDealerListUsecase})
      : super(DealerListInitial());

  final GetDealerListUsecase getDealerListUsecase;
}
