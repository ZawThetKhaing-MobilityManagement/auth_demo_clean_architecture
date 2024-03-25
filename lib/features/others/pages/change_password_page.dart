import 'package:demo_login_ui/features/login/domain/usecases/change_password_usecase.dart';
import 'package:demo_login_ui/features/login/presentation/bloc/auth_bloc.dart';
import 'package:demo_login_ui/features/others/widgets/password_text_field.dart';
import 'package:demo_login_ui/features/others/widgets/custom_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChangePasswordPage extends StatefulWidget {
  const ChangePasswordPage({super.key});

  @override
  State<ChangePasswordPage> createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage> {
  final TextEditingController _currentPassword = TextEditingController();
  final TextEditingController _newPassword = TextEditingController();
  final TextEditingController _confirmPassword = TextEditingController();

  final FocusNode _newPasswordF = FocusNode();
  final FocusNode _confirmPasswordF = FocusNode();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _currentPassword.dispose();
    _newPassword.dispose();
    _confirmPassword.dispose();
    _newPasswordF.dispose();
    _confirmPasswordF.dispose();
    _formKey.currentState?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Change Password"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              PasswordTextField(
                controller: _currentPassword,
                hintText: "Current password",
                onEditingComplete: _newPasswordF.requestFocus,
              ),
              PasswordTextField(
                controller: _newPassword,
                focusNode: _newPasswordF,
                hintText: "New password",
                onEditingComplete: _confirmPasswordF.requestFocus,
              ),
              PasswordTextField(
                controller: _confirmPassword,
                focusNode: _confirmPasswordF,
                hintText: "Confrim new password",
                validator: (value) => value?.isEmpty == true
                    ? "Required"
                    : value != _newPassword.text
                        ? "Password does not match"
                        : null,
                onEditingComplete: changePassword,
              ),
              const SizedBox(
                height: 8,
              ),
              BlocConsumer<AuthBloc, AuthState>(
                listener: (context, state) {
                  switch (state) {
                    case PasswordChangedState():
                      showDialog(
                          context: context,
                          builder: (_) {
                            return CustomDialog(
                              title: "Password change successful!",
                              content: state.message ?? "",
                              isSuccess: true,
                            );
                          }).whenComplete(() {
                        _currentPassword.clear();
                        _newPassword.clear();
                        _confirmPassword.clear();
                      });
                    case FaliureState():
                      showDialog(
                          context: context,
                          builder: (_) {
                            return CustomDialog(
                              title: "Password change failed!",
                              content: state.message ?? "",
                              isSuccess: false,
                            );
                          });
                    default:
                  }
                },
                builder: (context, state) {
                  return SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: changePassword,
                      child: state is ProcessingState
                          ? const CircularProgressIndicator(
                              color: Colors.white,
                              strokeWidth: 3,
                            )
                          : const Text("Done"),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  void changePassword() {
    if (_formKey.currentState?.validate() != true) return;
    _confirmPasswordF.unfocus();
    ChangePasswordParams params = ChangePasswordParams(
      currentPassword: _currentPassword.text,
      newPassword: _newPassword.text,
    );
    context.read<AuthBloc>().add(
          ChangePasswordEvent(changePasswordParams: params),
        );
  }
}
