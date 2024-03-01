import 'package:demo_login_ui/core/usecase/usecase.dart';
import 'package:demo_login_ui/features/login/data/model/user_model.dart';
import 'package:demo_login_ui/features/login/presentation/bloc/authbloc_bloc.dart';
import 'package:demo_login_ui/features/login/presentation/pages/home_page.dart';
import 'package:demo_login_ui/features/login/presentation/widgets/button.dart';
import 'package:demo_login_ui/features/login/presentation/widgets/policy_check.dart';
import 'package:demo_login_ui/features/login/presentation/widgets/welcome_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

final TextEditingController _emailController = TextEditingController();
final TextEditingController _usernameController = TextEditingController();

class SignUpPage extends StatelessWidget {
  const SignUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> formkey = GlobalKey<FormState>();
    return SafeArea(
      child: Scaffold(
        body: BlocConsumer<AuthBloc, AuthState>(
          listener: (context, state) async {
            if (state is AuthenticatedState) {}
            if (state is ProcessingState) {
              const Center(child: CircularProgressIndicator());
            }
            if (state is SuccessfulState) {
              Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(
                  builder: (_) => HomeScreen(
                    userModel: UserModel(
                      username: _usernameController.text,
                      email: _emailController.text,
                    ),
                  ),
                ),
                (_) => false,
              );
            }

            if (state is FaliureState) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text("Something went wrong"),
                ),
              );
            }
          },
          builder: (context, state) {
            return Form(
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
                  TextFormField(
                    controller: _usernameController,
                    validator: (value) =>
                        value?.isEmpty == true ? "Username required" : null,
                    decoration: const InputDecoration(
                      hintText: 'Full name',
                      suffixIcon: Icon(
                        Icons.person_outline_outlined,
                        size: 24,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    controller: _emailController,

                    //Just verify not null for testing.
                    validator: (value) =>
                        value?.isEmpty == true ? "Email required" : null,

                    decoration: const InputDecoration(
                      hintText: 'Valid email',
                      suffixIcon: Icon(
                        Icons.mail_outline,
                        size: 24,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    //Just verify not null for testing.
                    validator: (value) =>
                        value?.isEmpty == true ? "Password required" : null,
                    decoration: const InputDecoration(
                      hintText: 'Strong password',
                      suffixIcon: Icon(
                        Icons.lock_outline,
                        size: 24,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    //Just verify not null for testing.
                    validator: (value) =>
                        value?.isEmpty == true ? "Password required" : null,
                    decoration: const InputDecoration(
                      hintText: 'Confirm password',
                      suffixIcon: Icon(
                        Icons.lock_outline,
                        size: 24,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const PolicyCheck(),
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
                      if (formkey.currentState?.validate() == true) {
                        //Just store userName and email for testing.
                        context.read<AuthBloc>().add(
                              SignInEvent(
                                params: SignInParams(
                                  email: _emailController.text,
                                  name: _usernameController.text,
                                ),
                              ),
                            );
                      }
                    },
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  SizedBox(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Already a member? ",
                          style: TextStyle(fontSize: 13),
                        ),
                        GestureDetector(
                          onTap: () {},
                          child: const Text(
                            "Log in",
                            style: TextStyle(
                              fontSize: 13,
                              color: Color.fromRGBO(255, 57, 81, 1),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
