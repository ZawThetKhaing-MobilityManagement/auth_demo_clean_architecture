import 'package:demo_login_ui/core/const/const.dart';
import 'package:demo_login_ui/features/get_location/presentation/bloc/location_bloc.dart';
import 'package:demo_login_ui/features/login/data/model/user_model.dart';
import 'package:demo_login_ui/features/login/presentation/widgets/clock_in.dart';
import 'package:demo_login_ui/features/login/presentation/widgets/home_app_bar.dart';
import 'package:demo_login_ui/features/login/presentation/widgets/your_activity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeView extends StatefulWidget {
  final UserModel userModel;
  const HomeView({super.key, required this.userModel});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  late final LocationBloc locationBloc;
  @override
  void initState() {
    locationBloc = context.read<LocationBloc>();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print(widget.userModel.token);
    return Scaffold(
      backgroundColor: mainColor,
      appBar: AppBar(
        toolbarHeight: 80,
        foregroundColor: Colors.white,
        backgroundColor: mainColor,
        title: HomeAppBar(
          userModel: widget.userModel,
        ),
        actions: const [
          Icon(
            Icons.notifications_none,
            size: 24,
          ),
          SizedBox(width: 20),
        ],
        automaticallyImplyLeading: false,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ClockIn(userModel: widget.userModel),
          const YourActivity(),
        ],
      ),
    );
  }
}
