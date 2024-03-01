import 'package:demo_login_ui/features/login/data/datasource/localDataSource/user_local_data_source.dart';
import 'package:demo_login_ui/features/login/data/datasource/remoteDataSource/authentication_remote_data_source.dart';
import 'package:demo_login_ui/features/login/data/repository/authentication_repository_impl.dart';
import 'package:demo_login_ui/features/login/domain/repositories/authentication_repository.dart';
import 'package:demo_login_ui/features/login/domain/usecases/auth_user_usecase.dart';
import 'package:demo_login_ui/features/login/domain/usecases/logout_usecase.dart';
import 'package:demo_login_ui/features/login/domain/usecases/signup_usecase.dart';
import 'package:demo_login_ui/features/login/presentation/bloc/authbloc_bloc.dart';
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
      logoutUsecase: sl(),
    ),
  );

  //!repository
  sl.registerLazySingleton<AuthenticationRepository>(
    () => AuthenticationRepositoryImpl(
      userRemoteDataSource: sl(),
      userLocalDataSoure: sl(),
    ),
  );

  //!datasource

  sl.registerLazySingleton<UserRemoteDataSource>(
      () => UserRemoteDataSourceImpl(client: sl()));

  sl.registerLazySingleton<UserLocalDataSource>(
      () => UserLocalDataSourceImpl(sharedPreferences: sl()));

  //!usecase

  sl.registerLazySingleton(() => SignUpUsecase(authenticationRepository: sl()));
  sl.registerLazySingleton(
      () => AuthUserUsecase(authenticationRepository: sl()));
  sl.registerLazySingleton(() => LogoutUsecase(authenticationRepository: sl()));

  //!external

  sl.registerLazySingleton(() => http.Client());

  final SharedPreferences sharedPreferences =
      await SharedPreferences.getInstance();

  sl.registerLazySingleton(() => sharedPreferences);
}
