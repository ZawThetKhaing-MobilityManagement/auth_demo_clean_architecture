import 'package:demo_login_ui/core/const/const.dart';
import 'package:demo_login_ui/core/style/text_style.dart';
import 'package:demo_login_ui/features/get_location/presentation/bloc/location_bloc.dart';
import 'package:demo_login_ui/features/login/data/model/user_model.dart';
import 'package:demo_login_ui/features/login/presentation/widgets/mini_clock_in_out.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class HomePage extends StatelessWidget {
  final UserModel userModel;
  const HomePage({
    super.key,
    required this.userModel,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 80,
        foregroundColor: Colors.white,
        backgroundColor: mainColor,
        title: Container(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          height: 80,
          child: Row(
            children: [
              const CircleAvatar(
                radius: 24,
                child: Icon(Icons.person),
              ),
              const SizedBox(
                width: 10,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    userModel.name,
                    style: TextStyleData.semiBold,
                  ),
                  Text(
                    "Sale Promoter",
                    style: TextStyleData.medium,
                  ),
                ],
              )
            ],
          ),
        ),
        actions: const [
          Icon(
            Icons.notifications_none,
            size: 24,
          ),
          SizedBox(
            width: 20,
          )
        ],
        automaticallyImplyLeading: false,
      ),
      backgroundColor: mainColor,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            margin: const EdgeInsets.symmetric(vertical: 24),
            child: Column(
              children: [
                Text(
                  DateFormat.jm().format(DateTime.now()).toString(),
                  style: TextStyleData.large.copyWith(
                    color: Colors.white,
                  ),
                ),
                Text(
                  DateFormat.MMMMEEEEd().format(DateTime.now()).toString(),
                  style: TextStyleData.medium.copyWith(
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
          GestureDetector(
            onTap: () {
              print('click me');
              context
                  .read<LocationBloc>()
                  .add(GetLocationEvent(token: userModel.token ?? ''));
            },
            child: Container(
              width: 118,
              height: 116,
              decoration: BoxDecoration(
                color: Colors.white70,
                borderRadius: BorderRadius.circular(
                  24,
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    PhosphorIconsRegular.handPointing,
                    size: 50,
                    color: Colors.black,
                  ),
                  Text(
                    "Clock-in",
                    style: TextStyleData.medium.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 32,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 24.0, right: 24, bottom: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                MiniClockInOut(
                  icon: PhosphorIconsRegular.clock,
                  status: "Clock-In",
                  time: DateTime.now(),
                ),
                MiniClockInOut(
                  icon: PhosphorIconsRegular.clockAfternoon,
                  status: "Clock-Out",
                  time: DateTime.now(),
                ),
                MiniClockInOut(
                  icon: PhosphorIconsRegular.timer,
                  status: "Working Hrs ",
                  time: DateTime.now(),
                ),
              ],
            ),
          ),
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.95),
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(10),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 10.0, bottom: 16),
                    child: Text(
                      "Your Activity",
                      style: TextStyleData.semiBold.copyWith(
                        color: Colors.black,
                      ),
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: 4,
                      itemBuilder: (_, index) => Card(
                        elevation: 0.5,
                        color: Colors.white,
                        child: ListTile(
                          leading: Container(
                            width: 32,
                            height: 32,
                            decoration: BoxDecoration(
                              color: mainColor.withOpacity(0.5),
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              PhosphorIconsRegular.signIn,
                              size: 16,
                              color: mainColor,
                            ),
                          ),
                          title: Text(
                            "Clock-In",
                            style: TextStyleData.semiBold.copyWith(
                              color: Colors.black,
                            ),
                          ),
                          subtitle: Text(
                            DateFormat.yMMMMd().format(DateTime.now()),
                            style: TextStyleData.regular.copyWith(
                              color: Colors.grey,
                            ),
                          ),
                          trailing: Column(
                            children: [
                              Text(
                                DateFormat.jm().format(DateTime.now()),
                                style: TextStyleData.semiBold.copyWith(
                                  color: Colors.black,
                                ),
                              ),
                              Text(
                                "On-time",
                                style: TextStyleData.regular.copyWith(
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),

      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: mainColor,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(
              PhosphorIconsFill.house,
            ),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: "Profile",
          )
        ],
      ),
      // floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      // floatingActionButton: Padding(
      //   padding: const EdgeInsets.all(20),
      //   child: Row(
      //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //     children: [
      //       Button(
      //         onPressed: () {
      //           try {
      //             context.read<AuthBloc>().add(LogoutEvent());
      //             Navigator.of(context)
      //                 .pushNamedAndRemoveUntil(Routes.login, (route) => false);
      //           } catch (e) {}
      //         },
      //         widgets: const [
      //           Text(
      //             "Logout",
      //             style: TextStyle(fontSize: 24),
      //           ),
      //           SizedBox(
      //             width: 10,
      //           ),
      //           Icon(Icons.logout),
      //         ],
      //       ),
      //     ],
      //   ),
      // ),
    );
  }
}
