import 'package:demo_login_ui/core/utils/string_ext.dart';
import 'package:demo_login_ui/features/login/domain/usecases/signup_usecase.dart';
import 'package:demo_login_ui/features/login/presentation/bloc/auth_bloc.dart';
import 'package:demo_login_ui/features/login/presentation/widgets/button.dart';
import 'package:demo_login_ui/features/login/presentation/widgets/welcome_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  final FocusNode _emailF = FocusNode();
  final FocusNode _passwordF = FocusNode();
  final FocusNode _confrimPasswordF = FocusNode();

  final GlobalKey<FormState> formkey = GlobalKey<FormState>();
  bool isLoading = false;

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _usernameController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _emailF.dispose();
    _passwordF.dispose();
    _confrimPasswordF.dispose();
    formkey.currentState?.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: BlocBuilder<AuthBloc, AuthState>(
          builder: (_, state) {
            if (state is ProcessingState) {
              isLoading = false;
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            return Form(
              key: formkey,
              child: ListView(
                padding: const EdgeInsets.symmetric(
                  horizontal: 30,
                ),
                children: [
                  const WelcomeContainer(),
                  TextFormField(
                    controller: _usernameController,
                    validator: (value) =>
                        value?.isEmpty == true ? "Username required !" : null,
                    decoration: const InputDecoration(
                      hintText: 'Full name',
                      suffixIcon: Icon(
                        Icons.person_outline_outlined,
                        size: 24,
                      ),
                    ),
                    onEditingComplete: _emailF.requestFocus,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    controller: _emailController,
                    focusNode: _emailF,
                    //Just verify not null for testing.
                    validator: (value) => value?.isEmpty == true
                        ? "Email required !"
                        : value!.isValidEmail
                            ? null
                            : "Invalid Email !",

                    decoration: const InputDecoration(
                      hintText: 'Valid email',
                      suffixIcon: Icon(
                        Icons.mail_outline,
                        size: 24,
                      ),
                    ),
                    onEditingComplete: _passwordF.requestFocus,
                  ),
                  const SizedBox(
                    height: 20,
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
                      hintText: 'Strong password',
                      suffixIcon: Icon(
                        Icons.lock_outline,
                        size: 24,
                      ),
                    ),
                    onEditingComplete: _confrimPasswordF.requestFocus,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    controller: _confirmPasswordController,
                    focusNode: _confrimPasswordF,
                    obscureText: true,
                    validator: (value) => value?.isEmpty == true
                        ? "Password required"
                        : value! != _passwordController.text
                            ? "Password does not match !"
                            : null,
                    decoration: const InputDecoration(
                      hintText: 'Confirm password',
                      suffixIcon: Icon(
                        Icons.lock_outline,
                        size: 24,
                      ),
                    ),
                    onEditingComplete: () {
                      if (formkey.currentState?.validate() == true &&
                          isLoading == false) {
                        isLoading = true;
                        _confrimPasswordF.unfocus();

                        context.read<AuthBloc>().add(
                              SignUpEvent(
                                signUpParams: SignInParams(
                                  email: _emailController.text,
                                  name: _usernameController.text,
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
                    widgets: const [
                      Text(
                        "Next",
                        style: TextStyle(fontSize: 20),
                      ),
                      Icon(Icons.chevron_right),
                    ],
                    onPressed: () {
                      if (formkey.currentState?.validate() == true &&
                          isLoading == false) {
                        isLoading = true;
                        _confrimPasswordF.unfocus();

                        context.read<AuthBloc>().add(
                              SignUpEvent(
                                signUpParams: SignInParams(
                                  email: _emailController.text,
                                  name: _usernameController.text,
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
            );
          },
        ),
      ),
    );
  }
}
