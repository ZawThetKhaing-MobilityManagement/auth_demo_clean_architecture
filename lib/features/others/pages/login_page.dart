import 'package:demo_login_ui/core/routes/route.dart';
import 'package:demo_login_ui/core/utils/string_ext.dart';
import 'package:demo_login_ui/features/login/domain/usecases/login_usecase.dart';
import 'package:demo_login_ui/features/login/presentation/bloc/auth_bloc.dart';
import 'package:demo_login_ui/features/others/widgets/button.dart';
import 'package:demo_login_ui/features/login/presentation/widgets/welcome_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final FocusNode _passwordF = FocusNode();
  final GlobalKey<FormState> formkey = GlobalKey<FormState>();
  bool isLoading = false;

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _passwordF.dispose();
    formkey.currentState?.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is ProcessingState) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                duration: Duration(milliseconds: 300),
                content: Text("Logging in..."),
              ),
            );
          }
          if (state is FaliureState) {
            isLoading = false;
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                duration: const Duration(milliseconds: 300),
                content: Text(state.message.toString()),
              ),
            );
          }
          if (state is AuthenticatedState) {
            isLoading = false;
            Navigator.of(context).pushNamedAndRemoveUntil(
              Routes.home,
              (route) => false,
              arguments: state.userModel,
            );
          }
          if (state is UnAuthenticatedState) {
            isLoading = false;
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                duration: Duration(milliseconds: 300),
                content: Text("Please login in..."),
              ),
            );
          }
        },
        child: Form(
          key: formkey,
          child: ListView(
            padding: const EdgeInsets.symmetric(
              horizontal: 30,
            ),
            children: [
              const WelcomeContainer(),
              const SizedBox(
                height: 30,
              ),
              TextFormField(
                controller: _emailController,
                //Just verify not null for testing.
                validator: (value) =>
                    value?.isEmpty == true ? "Phone number required !" : null,
                keyboardType: TextInputType.phone,
                decoration: const InputDecoration(
                  hintText: 'Phone number',
                  suffixIcon: Icon(
                    Icons.phone,
                    size: 24,
                  ),
                ),

                onEditingComplete: _passwordF.requestFocus,
              ),
              const SizedBox(
                height: 30,
              ),
              TextFormField(
                obscureText: true,
                focusNode: _passwordF,
                controller: _passwordController,
                validator: (value) => value?.isEmpty == true
                    ? "Password required !"
                    : value!.isValidPassword
                        ? null
                        : "Atleast 8 words required !",
                decoration: const InputDecoration(
                  hintText: 'Password',
                  suffixIcon: Icon(
                    Icons.lock_outline,
                    size: 24,
                  ),
                ),
                onEditingComplete: () {
                  if (formkey.currentState?.validate() == true &&
                      isLoading == false) {
                    isLoading = true;
                    _passwordF.unfocus();
                    context.read<AuthBloc>().add(
                          LoginEvent(
                            loginInParams: LoginInParams(
                              phone: _emailController.text,
                              password: _passwordController.text,
                            ),
                          ),
                        );
                  }
                },
              ),
              const SizedBox(
                height: 30,
              ),
              Button(
                text: 'Next',
                onPressed: () {
                  if (formkey.currentState?.validate() == true &&
                      isLoading == false) {
                    isLoading = true;
                    _passwordF.unfocus();

                    context.read<AuthBloc>().add(
                          LoginEvent(
                            loginInParams: LoginInParams(
                              phone: _emailController.text,
                              password: _passwordController.text,
                            ),
                          ),
                        );
                  }
                },
              ),
              const SizedBox(
                height: 25,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
