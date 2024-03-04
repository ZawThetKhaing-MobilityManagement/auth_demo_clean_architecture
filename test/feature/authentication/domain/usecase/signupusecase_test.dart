import 'package:dartz/dartz.dart';
import 'package:demo_login_ui/core/usecase/usecase.dart';
import 'package:demo_login_ui/features/login/domain/entities/user_entity.dart';
import 'package:demo_login_ui/features/login/domain/usecases/signup_usecase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../helper/test_helper.mocks.dart';

void main() {
  late MockAuthenticationRepository mockAuthenticationRepostory;
  late SignUpUsecase signUpUsecase;

  setUp(() {
    mockAuthenticationRepostory = MockAuthenticationRepository();
    signUpUsecase =
        SignUpUsecase(authenticationRepository: mockAuthenticationRepostory);
  });

  const temail = 'email@example.com';
  const tname = 'name@example.com';
  const tUser = UserEntity(id: 1, name: tname, email: temail);
  final params = SignInParams(email: 'email', name: 'name', password: '');
  test(
    'should be signUp user when usecase called',
    () async {
      ///Arrange
      when(mockAuthenticationRepostory.signUp(params: anyNamed('params')))
          .thenAnswer((realInvocation) async => const Right(tUser));

      ///Act
      final result = await signUpUsecase.call(params);

      ///Assert
      expect(
        result,
        equals(const Right(tUser)),
      );
    },
  );

  test(
    'shoud be throw error when argument exception',
    () async {
      //arrange
      when(mockAuthenticationRepostory.signUp(params: anyNamed('params')))
          .thenThrow(
        Left(
          Exception(),
        ),
      );

      //act
      final result = signUpUsecase.call(params);

      expect(result, throwsA(const TypeMatcher<Exception>()));
    },
  );
}
