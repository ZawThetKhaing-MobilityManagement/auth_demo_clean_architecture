import 'package:demo_login_ui/features/login/data/datasource/localDataSource/user_local_data_source.dart';
import 'package:demo_login_ui/features/login/data/datasource/remoteDataSource/user_remote_data_source.dart';
import 'package:demo_login_ui/features/login/data/repository/authentication_repository_impl.dart';
import 'package:demo_login_ui/features/login/domain/repositories/authentication_repository.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';

@GenerateNiceMocks([
  MockSpec<UserRemoteDataSourceImpl>(),
  MockSpec<UserLocalDataSourceImpl>(),
  MockSpec<AuthenticationRepository>(),
  MockSpec<http.Client>(),
  MockSpec<AuthenticationRepositoryImpl>()
])
void main() {}
