import 'dart:async';

import 'package:demo_login_ui/core/const/const.dart';
import 'package:demo_login_ui/core/service/location_service.dart';
import 'package:demo_login_ui/features/attendence/data/model/location_model.dart';
import 'package:demo_login_ui/features/attendence/domain/usecases/get_current_location_usecase.dart';
import 'package:demo_login_ui/features/attendence/domain/usecases/get_location_cache_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:permission_handler/permission_handler.dart' as ph;

part 'location_event.dart';
part 'location_state.dart';

class LocationBloc extends Bloc<LocationEvent, LocationState> {
  final GetCurrentLocationUsecase locationUsecase;
  final GetLocationCacheUseCase locationCacheUseCase;

  LocationBloc({
    required this.locationUsecase,
    required this.locationCacheUseCase,
  }) : super(LocationInitial()) {
    startSystemTimer();
    getLocationCache();
    on<GetLocationEvent>(getLocation);

    on<GetLocationFailedEvent>(
      (event, emit) => emit(GetLocationFailedState(
        message: event.message,
        model: state.model,
      )),
    );

    on<DropDownChangeEvent>(
      (event, emit) => emit(
        DropDownChangeState(
            dropDownChange: event.dropDownValue, model: state.model),
      ),
    );

    on<TimerEvent>(
      (event, emit) {
        emit(TimerState(model: event.model));
      },
    );

    on<LocationCacheEvent>((event, emit) {
      emit(
        TimerState(
          model: event.model,
        ),
      );
      return startWorkingTimer(event.model!);
    });
  }

  Timer? workingTimer;
  Timer? systemTimer;
  Duration? workingHrs;
  late String hour;
  late String minute;

  String twoDigits(int n) => n.toString().padLeft(2, "0");

  void getLocation(
    GetLocationEvent event,
    Emitter<LocationState> emit,
  ) async {
    emit(LoactionGetProcessingState(model: state.model));

    final location = LocationService();
    try {
      final permission = await requestLocationPermission();

      if (permission) {
        final position = await location.getCurrentLocation();

        LocationParams params;

        if (event.status == Status.clockIn) {
          params = LocationParams(
            lat: position.latitude,
            lon: position.longitude,
            token: event.token ?? '',
            status: 'check-in',
            clockIn: DateTime.now(),
            id: 0,
            dealerId: event.dealerId,
          );
        } else {
          params = LocationParams(
            lat: position.latitude,
            lon: position.longitude,
            token: event.token ?? '',
            status: 'check-out',
            clockIn: event.clockIn,
            clockOut: DateTime.now(),
            id: state.model?.id ?? 0,
            dealerId: event.dealerId,
          );
        }
        final result = await locationUsecase(params);

        return result.fold(
          (l) {
            emit(GetLocationFailedState(
              message: l.messages,
              model: state.model,
            ));
          },
          (entity) {
            final model = LocationModel.fromEntity(entity);

            if (event.status == Status.clockIn) {
              emit(LocationGetSuccessfulState(
                model: model,
              ));
              startWorkingTimer(model);
            } else if (event.status == Status.clockOut) {
              workingTimer?.cancel();
              emit(
                LocationGetSuccessfulState(
                  model: model,
                ),
              );
              startWorkingTimer(model);
            }
          },
        );
      } else {
        emit(GetLocationFailedState(
            message: 'Permission Denied!', model: state.model));
      }
    } catch (e) {
      emit(
        GetLocationFailedState(
          message: 'Something Wrong! Please check your internet connection.',
          model: state.model,
        ),
      );
    }
  }

  void startSystemTimer() {
    systemTimer = Timer.periodic(
      const Duration(seconds: 5),
      (timer) {
        add(
          TimerEvent(
            model: state.model,
          ),
        );
      },
    );
    if (workingTimer != null) {
      systemTimer?.cancel();
      return;
    }
  }

  Future<void> startWorkingTimer(LocationModel model) async {
    if (model.status == CHECK_IN) {
      ///Call for cache state change
      changeState(model);
      systemTimer?.cancel();
      workingTimer = Timer.periodic(
        const Duration(minutes: 1),
        (timer) async {
          changeState(model);
        },
      );
    } else {
      changeState(model);
    }
  }

  void changeState(LocationModel model) {
    if (model.status == CHECK_IN) {
      workingHrs = DateTime.now().difference(
        model.clockIn ?? DateTime.now(),
      );
    } else {
      workingTimer?.cancel();
      if (systemTimer == null) {
        startSystemTimer();
      }
      workingHrs = (model.clockOut ?? DateTime.now()).difference(
        model.clockIn ?? DateTime.now(),
      );
    }

    if (workingHrs != null) {
      hour = twoDigits(workingHrs!.inHours.remainder(24));
      minute = twoDigits(workingHrs!.inMinutes.remainder(60));
      add(TimerEvent(model: model.copyWith(hour: hour, minute: minute)));
    }
  }

  Future<void> getLocationCache() async {
    final result = await locationCacheUseCase();
    result.fold(
      (l) => null,
      (entity) => add(
        LocationCacheEvent(
          model: LocationModel.fromEntity(entity),
        ),
      ),
    );
  }

  Future<bool> requestLocationPermission() async {
    const locationPermission = ph.Permission.location;

    final permissionStatus = await locationPermission.status;
    if (permissionStatus == ph.PermissionStatus.permanentlyDenied) {
      await ph.openAppSettings();

      return false;
    } else if (permissionStatus != ph.PermissionStatus.granted) {
      final status = await ph.Permission.location.request();
      return status == ph.PermissionStatus.granted;
    } else {
      return true;
    }
  }

  @override
  Future<void> close() {
    workingTimer?.cancel();
    systemTimer?.cancel();
    return super.close();
  }
}
