import 'package:demo_login_ui/core/const/const.dart';
import 'package:demo_login_ui/core/style/text_style.dart';
import 'package:demo_login_ui/features/attendence/data/model/location_model.dart';
import 'package:demo_login_ui/features/attendence/presentation/bloc/location_bloc.dart';
import 'package:demo_login_ui/features/attendence/presentation/cubit/attendence_list_cubit/attendence_list_cubit.dart';
import 'package:demo_login_ui/features/attendence/presentation/cubit/region_list/region_list_cubit.dart';
import 'package:demo_login_ui/features/login/data/model/user_model.dart';
import 'package:demo_login_ui/features/login/presentation/widgets/mini_clock_in_out.dart';
import 'package:demo_login_ui/features/others/widgets/alert.dart';
import 'package:demo_login_ui/features/others/widgets/custom_dialog.dart';
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
    final regionListCubit = context.read<RegionListCubit>();

    return BlocConsumer<LocationBloc, LocationState>(
      listener: (context, state) {
        if (state is LocationGetSuccessfulState) {
          showDialog(
            context: context,
            builder: (_) => const CustomDialog(
              title: "Attendence Successful!",
              content:
                  "Great job! Your attendance has been successfully recorded. You're all set for today.",
              isSuccess: true,
            ),
          );
          context
              .read<AttendenceListCubit>()
              .getAttendenceList(userModel.token ?? '');
        } else if (state is GetLocationFailedState) {
          showDialog(
            context: context,
            builder: (_) => const CustomDialog(
              isSuccess: false,
              title: "Attendence fail!",
              content:
                  "You're not in specified range.Click me at specified area.",
            ),
          );
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
                  Text(DateFormat.jm().format(DateTime.now()).toString(),
                      style: TextStyleData.large),
                  Text(
                    DateFormat.MMMMEEEEd().format(DateTime.now()).toString(),
                    style: TextStyleData.medium,
                  ),
                ],
              ),
            ),
            GestureDetector(
              onTap: () async {
                if (state is LoactionGetProcessingState) return;

                ///show bottom sheet when role is leader ;

                if (userModel.employeeRole == 'Leader') {
                  showBottomSheet(
                    backgroundColor: Colors.white,
                    context: context,
                    builder: (_) {
                      return Alert(
                        onDealerChanged: regionListCubit.dealerDropDownChange,
                        onRegionChanged: regionListCubit.regionDropDownChange,
                        onPressed: () {
                          if (model?.status == CHECK_OUT ||
                              model?.status == null) {
                            context.read<LocationBloc>().add(
                                  GetLocationEvent(
                                    token: userModel.token ?? '',
                                    status: Status.clockIn,
                                    dealerId:
                                        regionListCubit.state.selectedDealerId,
                                  ),
                                );
                            return;
                          } else {
                            context.read<LocationBloc>().add(
                                  GetLocationEvent(
                                    token: userModel.token ?? '',
                                    status: Status.clockOut,
                                    clockIn: model?.clockIn,
                                    dealerId:
                                        regionListCubit.state.selectedDealerId,
                                  ),
                                );
                            return;
                          }
                        },
                      );
                    },
                  );
                  return;
                }

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
                      ? mainColor
                      : Colors.grey,
                  borderRadius: BorderRadius.circular(24),
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
                          const Icon(
                            PhosphorIconsRegular.handPointing,
                            size: 50,
                            color: Colors.white,
                          ),
                          Text(
                            model?.status == CHECK_OUT || model?.status == null
                                ? "Clock in"
                                : "Clock out",
                            style: TextStyleData.medium.copyWith(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
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
              padding: const EdgeInsets.only(left: 24.0, right: 24, bottom: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  MiniClockInOut(
                    icon: PhosphorIconsRegular.clock,
                    status: "Clock in",
                    time: model?.clockIn ?? clockIn,
                  ),
                  MiniClockInOut(
                    icon: PhosphorIconsRegular.clockAfternoon,
                    status: "Clock out",
                    time: model?.clockOut,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        PhosphorIconsRegular.timer,
                        size: 32,
                        color: mainColor,
                      ),
                      Text(
                        "${model?.hour ?? '00'}:${model?.minute ?? '00'}",
                        style: TextStyleData.semiBold,
                      ),
                      Text("Working hours", style: TextStyleData.regular),
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
