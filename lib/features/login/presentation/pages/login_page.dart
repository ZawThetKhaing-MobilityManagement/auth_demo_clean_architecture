import 'package:demo_login_ui/core/routes/route.dart';
import 'package:demo_login_ui/core/utils/string_ext.dart';
import 'package:demo_login_ui/features/login/domain/usecases/login_usecase.dart';
import 'package:demo_login_ui/features/login/presentation/bloc/auth_bloc.dart';
import 'package:demo_login_ui/features/login/presentation/widgets/button.dart';
import 'package:demo_login_ui/features/login/presentation/widgets/login_or_register.dart';
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
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: BlocListener<AuthBloc, AuthState>(
          listener: (context, state) {
            print('state is $state and');
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
                  content: Text(state.message),
                ),
              );
            }
            if (state is AuthenticatedState) {
              isLoading = false;
              print(state.userModel.token);
              Navigator.of(context).pushNamedAndRemoveUntil(
                Routes.home,
                (route) => false,
                arguments: state.userModel,
              );
            }
            if (state is UnAuthenticatedState) {
              isLoading = false;
              Navigator.of(context).pushNamedAndRemoveUntil(
                Routes.login,
                (route) => false,
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
                const WelcomeContainer(
                  mainText: "Get Started",
                  subText: "by creating a new account",
                ),
                const SizedBox(
                  height: 30,
                ),
                TextFormField(
                  controller: _emailController,
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
                    hintText: 'Strong password',
                    suffixIcon: Icon(
                      Icons.lock_outline,
                      size: 24,
                    ),
                  ),
                  onEditingComplete: () {
                    if (formkey.currentState?.validate() == true &&
                        isLoading == false) {
                      isLoading = true;
                      context.read<AuthBloc>().add(
                            LoginEvent(
                              params: LoginInParams(
                                email: _emailController.text,
                                password: _passwordController.text,
                              ),
                            ),
                          );
                    }
                  },
                ),
                const SizedBox(
                  height: 17,
                ),
                GestureDetector(
                  onTap: () {},
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        "Forget password ?",
                        style: TextStyle(
                          fontSize: 10,
                          color: Color.fromRGBO(255, 57, 81, 1),
                        ),
                      ),
                    ],
                  ),
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
                      context.read<AuthBloc>().add(
                            LoginEvent(
                              params: LoginInParams(
                                email: _emailController.text,
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
                LoginOrRegister(
                  text: 'New member?',
                  funText: 'Register now',
                  onTap: () {
                    Navigator.of(context).pushNamed(Routes.signUp);
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
