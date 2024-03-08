import 'package:demo_login_ui/core/const/const.dart';
import 'package:demo_login_ui/core/style/text_style.dart';
import 'package:demo_login_ui/features/get_location/presentation/bloc/location_bloc.dart';
import 'package:demo_login_ui/features/get_location/presentation/cubit/attendence_list_cubit/attendence_list_cubit.dart';
import 'package:demo_login_ui/features/login/data/model/user_model.dart';
import 'package:demo_login_ui/features/login/presentation/widgets/button.dart';
import 'package:demo_login_ui/features/login/presentation/widgets/mini_clock_in_out.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class ClockIn extends StatefulWidget {
  final UserModel userModel;
  const ClockIn({
    super.key,
    required this.userModel,
  });

  @override
  State<ClockIn> createState() => _ClockInState();
}

class _ClockInState extends State<ClockIn> {
  DateTime? clockIn;
  DateTime? clockOut;
  String? hour;
  String? minute;
  String status = CHECK_OUT;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LocationBloc, LocationState>(
      listener: (context, state) {
        print(state);
        if (state is LocationGetSuccessfulState) {
          showDialog(
            context: context,
            builder: (_) {
              return AlertDialog(
                icon: Container(
                  width: 90,
                  height: 90,
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: mainColor.withOpacity(0.5),
                    shape: BoxShape.circle,
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      color: mainColor,
                      shape: BoxShape.circle,
                    ),
                    child: const PhosphorIcon(
                      PhosphorIconsRegular.checkCircle,
                      color: Colors.white,
                    ),
                  ),
                ),
                title: const Text("Attendance Successful!"),
                content: const Text(
                  "Great job! Your attendance has been successfully recorded. You're all set for today.",
                  textAlign: TextAlign.center,
                ),
                contentTextStyle: TextStyleData.medium.copyWith(
                  color: Colors.black,
                ),
                actions: [
                  Button(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    widgets: const [
                      Text("Done"),
                    ],
                  )
                ],
              );
            },
          );
          context
              .read<AttendenceListCubit>()
              .getAttendenceList(widget.userModel.token ?? '');
          clockIn = state.model.clockIn;
          status = state.model.status;
          clockOut = state.model.clockOut;
          hour = state.model.hour;
          minute = state.model.minute;
          status = state.model.status;
        } else if (state is TimerState) {
          clockIn = state.model.clockIn;
          status = state.model.status;
          clockOut = state.model.clockOut;
          hour = state.model.hour;
          minute = state.model.minute;
          status = state.model.status;
          print(state.model.toJson());
        }
      },
      builder: (context, state) {
        print("status $status");
        return Column(
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
                if (state is LocationLoadingState) return;
                if (status == CHECK_OUT) {
                  context.read<LocationBloc>().add(
                        GetLocationEvent(
                          token: widget.userModel.token ?? '',
                          status: Status.clockIn,
                        ),
                      );
                  return;
                }
                context.read<LocationBloc>().add(
                      GetLocationEvent(
                        token: widget.userModel.token ?? '',
                        status: Status.clockOut,
                        clockIn: clockIn,
                      ),
                    );
                return;
              },
              child: Container(
                width: 118,
                height: 116,
                decoration: BoxDecoration(
                  color:
                      status == CHECK_OUT ? Colors.green[200] : Colors.white70,
                  borderRadius: BorderRadius.circular(
                    24,
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      PhosphorIconsRegular.handPointing,
                      size: 50,
                      color: status == CHECK_OUT ? Colors.white : Colors.black,
                    ),
                    Text(
                      status == CHECK_OUT ? "Clock-in" : "Clock-out",
                      style: TextStyleData.medium.copyWith(
                        fontWeight: FontWeight.bold,
                        color:
                            status == CHECK_OUT ? Colors.white : Colors.black,
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
                    time: clockIn,
                  ),
                  MiniClockInOut(
                    icon: PhosphorIconsRegular.clockAfternoon,
                    status: "Clock-Out",
                    time: clockOut,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        PhosphorIconsRegular.timer,
                        size: 32,
                        color: Colors.white,
                      ),
                      Text(
                        "${hour == 'null' || hour == null ? '00' : hour}:${minute == 'null' || minute == null ? '00' : minute}",
                        style: TextStyleData.semiBold,
                      ),
                      Text("Working-hours", style: TextStyleData.regular),
                    ],
                  ),
                ],
              ),
            )
          ],
        );
      },
    );
  }
}
