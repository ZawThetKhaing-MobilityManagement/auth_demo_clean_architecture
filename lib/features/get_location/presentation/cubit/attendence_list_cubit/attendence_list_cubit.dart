import 'package:demo_login_ui/features/get_location/data/model/attendence_list_model.dart';
import 'package:demo_login_ui/features/get_location/domain/usecases/get_attendence_activity_usecase.dart';
import 'package:demo_login_ui/features/get_location/presentation/cubit/attendence_list_cubit/attendence_list_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AttendenceListCubit extends Cubit<AttendenceListState> {
  final GetAttendenceActivityUsecase getAttendenceActivityUsecase;
  AttendenceListCubit({required this.getAttendenceActivityUsecase})
      : super(AttendenceListInitial());

  void getAttendenceList(String token) async {
    final result = await getAttendenceActivityUsecase(token);

    return result.fold(
      (l) => emit(UnLoadedAttendenceList()),
      (attendenceList) {
        emit(
          LoadedAttendenceList(
            model: AttendenceListModel.fromEntity(attendenceList),
          ),
        );
      },
    );
  }
}
