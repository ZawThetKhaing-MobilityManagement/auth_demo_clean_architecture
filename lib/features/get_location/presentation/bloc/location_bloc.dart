import 'dart:async';

import 'package:demo_login_ui/core/const/const.dart';
import 'package:demo_login_ui/core/service/location_service.dart';
import 'package:demo_login_ui/features/get_location/data/model/location_model.dart';
import 'package:demo_login_ui/features/get_location/domain/entities/attendence_list_entity.dart';
import 'package:demo_login_ui/features/get_location/domain/entities/location_entity.dart';
import 'package:demo_login_ui/features/get_location/domain/usecases/get_current_location_usecase.dart';
import 'package:demo_login_ui/features/get_location/domain/usecases/get_location_cache_usecase.dart';
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
    on<GetLocationEvent>(
      (event, emit) async {
        print("${event.status}");
        emit(LocationLoadingState());
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
                token: event.token,
                status: 'check-in',
                clockIn: DateTime.now(),
              );
            } else {
              params = LocationParams(
                lat: position.latitude,
                lon: position.longitude,
                token: event.token,
                status: 'check-out',
                clockIn: event.clockIn,
                clockOut: DateTime.now(),
              );
            }
            final result = await locationUsecase(params);

            return result.fold(
              (l) {
                print("Failed");
                emit(LocationGetFailedState(message: l.messages));
              },
              (entity) {
                if (event.status == Status.clockIn) {
                  emit(LocationGetSuccessfulState(
                    model: LocationModel.fromEntity(entity),
                  ));
                  startTimer(entity);
                } else if (event.status == Status.clockOut) {
                  workingTimer.cancel();
                  print(entity.clockOut);
                  emit(
                    LocationGetSuccessfulState(
                      model: LocationModel.fromEntity(entity),
                    ),
                  );
                }
              },
            );
          }
        } catch (e) {
          print('Error $e');
        }
      },
    );

    on<GetLocationFailedEvent>(
      (event, emit) => emit(LocationGetFailedState(message: event.message)),
    );
    on<TimerEvent>(
      (event, emit) {
        print("evetn");
        emit(
          TimerState(model: event.model),
        );
        print("OK");
      },
    );

    on<LocationCacheEvent>((event, emit) {
      emit(
        TimerState(
          model: LocationModel.fromEntity(event.entity),
        ),
      );
      return startTimer(event.entity);
    });
  }

  Timer workingTimer = Timer(Duration.zero, () {});
  Duration workingHrs = Duration.zero;
  String twoDigits(int n) => n.toString().padLeft(2, "0");
  late String hour;
  late String minute;

  Future<void> startTimer(LocationEntity entity) async {
    LocationModel model = LocationModel.fromEntity(entity);
    if (model.status == CHECK_IN) {
      ///Call for cache state change
      changeState(model);
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
      workingTimer.cancel();
      workingHrs = (model.clockOut ?? DateTime.now()).difference(
        model.clockIn ?? DateTime.now(),
      );
    }
    hour = twoDigits(workingHrs.inHours.remainder(24));
    minute = twoDigits(workingHrs.inMinutes.remainder(60));
    add(TimerEvent(model: model.copyWith(hour: hour, minute: minute)));
  }

  void getLocationCache() async {
    final result = await locationCacheUseCase();
    result.fold(
      (l) => null,
      (entity) => add(
        LocationCacheEvent(
          entity: entity,
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
}
