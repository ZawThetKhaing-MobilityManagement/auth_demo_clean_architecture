import 'package:cached_network_image/cached_network_image.dart';
import 'package:demo_login_ui/features/login/presentation/bloc/auth_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class ChangeProfilePage extends StatelessWidget {
  const ChangeProfilePage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Change Profile"),
        centerTitle: true,
      ),
      body: BlocBuilder<AuthBloc, AuthState>(
        builder: (context, state) {
          final userModel = state.userModel;
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.only(bottom: 8),
                    height: 150,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        width: 2.5,
                        color: Theme.of(context).hintColor,
                      ),
                      image: userModel?.image == null
                          ? null
                          : DecorationImage(
                              image: CachedNetworkImageProvider(
                                userModel!.image!,
                              ),
                              fit: BoxFit.contain,
                            ),
                    ),
                    alignment: Alignment.center,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        SizedBox(
                          child: userModel?.image == null
                              ? const PhosphorIcon(
                                  PhosphorIconsRegular.user,
                                  size: 90,
                                )
                              : null,
                        ),
                        const PhosphorIcon(
                          PhosphorIconsRegular.cameraPlus,
                          size: 32,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: 60,
                    decoration: BoxDecoration(
                      color: Theme.of(context).inputDecorationTheme.fillColor,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    padding: const EdgeInsets.only(left: 10),
                    alignment: Alignment.centerLeft,
                    child: Text(
                      userModel?.name ?? "",
                      style: TextStyle(
                        color: Theme.of(context)
                            .inputDecorationTheme
                            .prefixIconColor,
                        fontSize: 18,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: 60,
                    decoration: BoxDecoration(
                      color: Theme.of(context).inputDecorationTheme.fillColor,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    padding: const EdgeInsets.only(left: 10),
                    alignment: Alignment.centerLeft,
                    child: Text(
                      userModel?.phone ?? "",
                      style: TextStyle(
                        color: Theme.of(context)
                            .inputDecorationTheme
                            .prefixIconColor,
                        fontSize: 18,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () {},
                      child: const Text("Done"),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
