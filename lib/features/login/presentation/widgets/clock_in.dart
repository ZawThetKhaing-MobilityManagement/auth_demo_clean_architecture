import 'package:demo_login_ui/core/const/const.dart';
import 'package:demo_login_ui/core/style/text_style.dart';
import 'package:demo_login_ui/features/get_location/data/model/location_model.dart';
import 'package:demo_login_ui/features/get_location/presentation/bloc/location_bloc.dart';
import 'package:demo_login_ui/features/get_location/presentation/cubit/attendence_list_cubit/attendence_list_cubit.dart';
import 'package:demo_login_ui/features/login/data/model/user_model.dart';
import 'package:demo_login_ui/features/login/presentation/widgets/mini_clock_in_out.dart';
import 'package:demo_login_ui/features/login/presentation/widgets/success_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class ClockIn extends StatelessWidget {
  final UserModel userModel;
  const ClockIn({
    super.key,
    required this.userModel,
  });

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LocationBloc, LocationState>(
      listener: (context, state) {
        if (state is LocationGetSuccessfulState) {
          showDialog(
            context: context,
            builder: (_) => const SuccessDialog(),
          );
          context
              .read<AttendenceListCubit>()
              .getAttendenceList(userModel.token ?? '');
        }
      },
      builder: (context, state) {
        final LocationModel? model = state.model;
        DateTime? clockIn = model?.clockIn;
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
                if (state is LoactionGetProcessingState) return;

                if (model?.status == CHECK_OUT || model?.status == null) {
                  context.read<LocationBloc>().add(
                        GetLocationEvent(
                          token: userModel.token ?? '',
                          status: Status.clockIn,
                        ),
                      );
                } else {
                  context.read<LocationBloc>().add(
                        GetLocationEvent(
                          token: userModel.token ?? '',
                          status: Status.clockOut,
                          clockIn: model?.clockIn,
                        ),
                      );
                }
              },
              child: Container(
                width: 118,
                height: 116,
                decoration: BoxDecoration(
                  color: model?.status == CHECK_OUT || model?.status == null
                      ? Colors.green[200]
                      : Colors.white70,
                  borderRadius: BorderRadius.circular(
                    24,
                  ),
                ),
                child: state is LoactionGetProcessingState
                    ? const Center(
                        child: CircularProgressIndicator(
                          color: Colors.white,
                        ),
                      )
                    : Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            PhosphorIconsRegular.handPointing,
                            size: 50,
                            color: model?.status == CHECK_OUT ||
                                    model?.status == null
                                ? Colors.white
                                : Colors.black,
                          ),
                          Text(
                            model?.status == CHECK_OUT || model?.status == null
                                ? "Clock-in"
                                : "Clock-out",
                            style: TextStyleData.medium.copyWith(
                              fontWeight: FontWeight.bold,
                              color: model?.status == CHECK_OUT ||
                                      model?.status == null
                                  ? Colors.white
                                  : Colors.black,
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
                    time: model?.clockIn ?? clockIn,
                  ),
                  MiniClockInOut(
                    icon: PhosphorIconsRegular.clockAfternoon,
                    status: "Clock-Out",
                    time: model?.clockOut,
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
                        "${model?.hour ?? '00'}:${model?.minute ?? '00'}",
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
