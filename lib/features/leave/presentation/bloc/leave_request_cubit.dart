import 'package:demo_login_ui/features/leave/data/model/leave_model.dart';
import 'package:demo_login_ui/features/leave/domain/usecases/get_leave_list_usecase.dart';
import 'package:demo_login_ui/features/leave/domain/usecases/request_leave_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'leave_request_state.dart';

class LeaveRequestCubit extends Cubit<LeaveRequestState> {
  LeaveRequestCubit({
    required this.leaveRequestUsecase,
    required this.getLeaveListUsecase,
  }) : super(LeaverequestInitial());
  final LeaveRequestUsecase leaveRequestUsecase;
  final GetLeaveListUsecase getLeaveListUsecase;

  Future<void> postLeaveRequest(LeaveParams params) async {
    emit(
      LeaveRequestProcessing(
        startDate: state.startDate,
        endDate: state.endDate,
        dropDownValue: state.dropDownValue,
      ),
    );

    final result = await leaveRequestUsecase(params);

    result.fold(
      (l) => emit(LeaveRequestFailed(message: l.messages)),
      (r) {
        getLeaveList(params.token);
        emit(const LeaveRequestSuccessful(message: "Request Successful"));
      },
    );
  }

  Future<void> getLeaveList(String token) async {
    emit(const LeaveRequestProcessing());

    final result = await getLeaveListUsecase(token);
    result.fold(
      (l) => emit(LeaveRequestFailed(message: l.messages)),
      (r) => emit(
        LoadedLeaveList(
            leaveList: r
                .map(
                  (e) => LeaveModel.fromEntity(e),
                )
                .toList()),
      ),
    );
  }

  void emitFailedState() =>
      emit(LeaveRequestFailed(leaveList: state.leaveList));

  void datePickerChange({
    DateTime? startDate,
    DateTime? endDate,
  }) {
    emit(
      DatePickerChange(
        startDate: startDate ?? state.startDate,
        endDate: endDate ?? state.endDate,
        dropDownValue: state.dropDownValue,
        leaveList: state.leaveList,
      ),
    );
  }

  void dropDownChange(String? value) {
    emit(
      DropDownChange(
        dropDownValue: value,
        startDate: state.startDate,
        endDate: state.endDate,
        leaveList: state.leaveList,
      ),
    );
  }
}
