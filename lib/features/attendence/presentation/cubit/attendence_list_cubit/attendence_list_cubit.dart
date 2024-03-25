import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dartz/dartz.dart';
import 'package:demo_login_ui/core/error/failure.dart';
import 'package:demo_login_ui/features/attendence/data/model/attendence_list_model.dart';
import 'package:demo_login_ui/features/attendence/domain/entities/attendence_list_entity.dart';
import 'package:demo_login_ui/features/attendence/domain/usecases/get_attendence_activity_from_cache_usecase.dart';
import 'package:demo_login_ui/features/attendence/domain/usecases/get_attendence_activity_usecase.dart';
import 'package:demo_login_ui/features/attendence/presentation/cubit/attendence_list_cubit/attendence_list_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AttendenceListCubit extends Cubit<AttendenceListState> {
  AttendenceListCubit({
    required this.getAttendenceActivityUsecase,
    required this.getAttendenceActivityFromCacheUsecase,
  }) : super(AttendenceListInitial());

  final GetAttendenceActivityUsecase getAttendenceActivityUsecase;
  final GetAttendenceActivityFromCacheUsecase
      getAttendenceActivityFromCacheUsecase;

  void getAttendenceList(String token) async {
    Either<Faliure, AttendenceListEntity> result;
    final isConnected = await Connectivity().checkConnectivity();
    if (isConnected == ConnectivityResult.none) {
      result = await getAttendenceActivityFromCacheUsecase();
    } else {
      result = await getAttendenceActivityUsecase(token);
    }

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
