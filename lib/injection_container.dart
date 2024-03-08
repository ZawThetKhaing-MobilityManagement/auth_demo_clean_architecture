import 'package:demo_login_ui/features/get_location/data/datasource/local_data_source/location_local_data_source.dart';
import 'package:demo_login_ui/features/get_location/data/datasource/remote_data_source/location_remote_data_source.dart';
import 'package:demo_login_ui/features/get_location/data/repository/location_repository_impl.dart';
import 'package:demo_login_ui/features/get_location/domain/repository/location_repository.dart';
import 'package:demo_login_ui/features/get_location/domain/usecases/get_attendence_activity_usecase.dart';
import 'package:demo_login_ui/features/get_location/domain/usecases/get_current_location_usecase.dart';
import 'package:demo_login_ui/features/get_location/domain/usecases/get_location_cache_usecase.dart';

import 'package:demo_login_ui/features/get_location/presentation/bloc/location_bloc.dart';
import 'package:demo_login_ui/features/get_location/presentation/cubit/attendence_list_cubit/attendence_list_cubit.dart';
import 'package:demo_login_ui/features/get_location/presentation/cubit/home_view_cubit_cubit.dart';
import 'package:demo_login_ui/features/get_location/presentation/cubit/timer_cubit.dart';
import 'package:demo_login_ui/features/login/data/datasource/localDataSource/user_local_data_source.dart';
import 'package:demo_login_ui/features/login/data/datasource/remoteDataSource/user_remote_data_source.dart';
import 'package:demo_login_ui/features/login/data/repository/authentication_repository_impl.dart';
import 'package:demo_login_ui/features/login/domain/repositories/authentication_repository.dart';
import 'package:demo_login_ui/features/login/domain/usecases/auth_user_usecase.dart';
import 'package:demo_login_ui/features/login/domain/usecases/login_usecase.dart';
import 'package:demo_login_ui/features/login/domain/usecases/logout_usecase.dart';
import 'package:demo_login_ui/features/login/domain/usecases/signup_usecase.dart';
import 'package:demo_login_ui/features/login/presentation/bloc/auth_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

final sl = GetIt.instance;

Future<void> init() async {
  //!bloc
  sl.registerFactory(
    () => AuthBloc(
      authUserUsecase: sl(),
      signUpUsecase: sl(),
      loginUsecase: sl(),
      logoutUsecase: sl(),
    ),
  );

  sl.registerFactory(() => HomeViewCubit());
  sl.registerFactory(
    () => AttendenceListCubit(getAttendenceActivityUsecase: sl()),
  );

  sl.registerFactory(
    () => LocationBloc(
      locationUsecase: sl(),
      locationCacheUseCase: sl(),
    ),
  );

  //!repository
  sl.registerLazySingleton<AuthenticationRepository>(
    () => AuthenticationRepositoryImpl(
      userRemoteDataSource: sl(),
      userLocalDataSoure: sl(),
    ),
  );
  sl.registerLazySingleton<LocationRepository>(
    () => LocationRepositoryImpl(
      locationRemoteDataSource: sl(),
      locationLocalDataSoure: sl(),
    ),
  );

  //!datasource

  sl.registerLazySingleton<UserRemoteDataSource>(
      () => UserRemoteDataSourceImpl(client: sl()));

  sl.registerLazySingleton<UserLocalDataSource>(
      () => UserLocalDataSourceImpl(sharedPreferences: sl()));

  sl.registerLazySingleton<LocationRemoteDataSource>(
      () => LocationRemoteDataSourceImpl(client: sl()));
  sl.registerLazySingleton<LocationLocalDataSoure>(
      () => LocationLocalDataSoureImpl(sharedPreferences: sl()));

  //!usecase

  sl.registerLazySingleton(() => SignUpUsecase(authenticationRepository: sl()));

  sl.registerLazySingleton(
      () => AuthUserUsecase(authenticationRepository: sl()));

  sl.registerLazySingleton(() => LogoutUsecase(authenticationRepository: sl()));

  sl.registerLazySingleton(() => LoginUsecase(authenticationRepository: sl()));

  sl.registerLazySingleton(
      () => GetCurrentLocationUsecase(locationRepository: sl()));

  sl.registerLazySingleton(
      () => GetLocationCacheUseCase(locationRepository: sl()));
  sl.registerLazySingleton(
      () => GetAttendenceActivityUsecase(locationRepository: sl()));

  //!external

  sl.registerLazySingleton(() => http.Client());

  final SharedPreferences sharedPreferences =
      await SharedPreferences.getInstance();

  sl.registerLazySingleton(() => sharedPreferences);
}
