import 'package:dartz/dartz.dart';
import 'package:demo_login_ui/features/login/data/model/user_model.dart';
import 'package:demo_login_ui/features/login/data/repository/authentication_repository_impl.dart';
import 'package:demo_login_ui/features/login/domain/usecases/signup_usecase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../helper/test_helper.mocks.dart';

void main() {
  late AuthenticationRepositoryImpl mockAuthenticationRepositoryImpl;
  late MockUserRemoteDataSourceImpl mockUserRemoteDataSourceImpl;
  late MockUserLocalDataSourceImpl mockUserLocalDataSourceImpl;

  setUp(() {
    mockUserRemoteDataSourceImpl = MockUserRemoteDataSourceImpl();
    mockUserLocalDataSourceImpl = MockUserLocalDataSourceImpl();
    mockAuthenticationRepositoryImpl = AuthenticationRepositoryImpl(
      userRemoteDataSource: mockUserRemoteDataSourceImpl,
      userLocalDataSoure: mockUserLocalDataSourceImpl,
    );
  });

  final tParams =
      SignInParams(email: 'test@gmail.com', name: 'testName', password: '');
  final tuserModel = UserModel(name: tParams.email, email: tParams.name);

  test('should be return user model when sign in ', () async {
    when(
      mockUserRemoteDataSourceImpl.signUpwithEmailandPassword(
        tParams,
      ),
    ).thenAnswer((realInvocation) async => Right(tuserModel));

    final result =
        await mockAuthenticationRepositoryImpl.signUp(params: tParams);

    expect(
      result,
      equals(Right(tuserModel)),
    );
  });
}
