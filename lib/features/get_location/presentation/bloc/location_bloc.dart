import 'package:demo_login_ui/core/service/location_service.dart';
import 'package:demo_login_ui/features/get_location/domain/usecases/get_current_location_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:permission_handler/permission_handler.dart' as ph;

part 'location_event.dart';
part 'location_state.dart';

class LocationBloc extends Bloc<LocationEvent, LocationState> {
  final GetCurrentLocationUsecase locationUsecase;
  LocationBloc({required this.locationUsecase}) : super(LocationInitial()) {
    on<GetLocationEvent>((event, emit) async {
      final location = LocationService();
      try {
        final permission = await requestLocationPermission();
        if (permission) {
          final position = await location.getCurrentLocation();

          final result = await locationUsecase(
            LocationParams(
              lat: position.latitude,
              lon: position.longitude,
              token: event.token,
            ),
          );

          return result.fold(
            (l) => emit(LocationGetFailedState(message: l.messages)),
            (r) => emit(
              LocationGetSuccessfulState(),
            ),
          );
        }
      } catch (e) {
        print('Error $e');
      }
    });
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
