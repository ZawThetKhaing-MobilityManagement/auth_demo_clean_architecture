part of 'leave_request_cubit.dart';

abstract class LeaveRequestState {
  const LeaveRequestState(
      {this.leaveList,
      this.message,
      this.startDate,
      this.endDate,
      this.dropDownValue});
  final List<LeaveModel>? leaveList;
  final String? message;
  final DateTime? startDate;
  final DateTime? endDate;
  final String? dropDownValue;
}

class LeaverequestInitial extends LeaveRequestState {}

class LeaveRequestProcessing extends LeaveRequestState {
  const LeaveRequestProcessing(
      {super.startDate, super.endDate, super.dropDownValue});
}

class DatePickerChange extends LeaveRequestState {
  const DatePickerChange(
      {super.startDate, super.endDate, super.dropDownValue, super.leaveList});
}

class DropDownChange extends LeaveRequestState {
  const DropDownChange(
      {super.dropDownValue, super.startDate, super.endDate, super.leaveList});
}

class LeaveRequestSuccessful extends LeaveRequestState {
  const LeaveRequestSuccessful({super.message});
}

class LeaveRequestFailed extends LeaveRequestState {
  const LeaveRequestFailed({super.message, super.leaveList});
}

class LoadedLeaveList extends LeaveRequestState {
  const LoadedLeaveList({super.leaveList});
}
