import 'package:demo_login_ui/features/get_location/data/model/attendence_list_model.dart';

class AttendenceListState {
  const AttendenceListState();
}

class LoadedAttendenceList extends AttendenceListState {
  const LoadedAttendenceList({required this.model});

  final AttendenceListModel model;
} 

class AttendenceListInitial extends AttendenceListState {}

class UnLoadedAttendenceList extends AttendenceListState {}
