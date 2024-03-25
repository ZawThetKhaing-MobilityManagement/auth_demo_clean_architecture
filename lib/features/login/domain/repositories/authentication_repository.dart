import 'package:demo_login_ui/core/utils/typedef.dart';
import 'package:demo_login_ui/features/login/domain/entities/user_entity.dart';
import 'package:demo_login_ui/features/login/domain/usecases/change_password_usecase.dart';
import 'package:demo_login_ui/features/login/domain/usecases/login_usecase.dart';
import 'package:demo_login_ui/features/others/pages/change_password_page.dart';

abstract class AuthenticationRepository {
  ResultFuture<UserEntity> login({
    required LoginInParams params,
  });

  ResultFuture<UserEntity?> authUser();

  ResultVoid logout();
  ResultVoid changePassword(
    ChangePasswordParams params,
  );
}
