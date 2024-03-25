import 'package:demo_login_ui/features/attendence/data/model/attendence_list_model.dart';

class AttendenceListState {
  const AttendenceListState({this.model});
  final AttendenceListModel? model;
}

class LoadedAttendenceList extends AttendenceListState {
  const LoadedAttendenceList({super.model});
}

class AttendenceListInitial extends AttendenceListState {}

class UnLoadedAttendenceList extends AttendenceListState {}
