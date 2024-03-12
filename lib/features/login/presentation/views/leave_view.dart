import 'package:demo_login_ui/core/const/const.dart';
import 'package:demo_login_ui/core/style/text_style.dart';
import 'package:demo_login_ui/features/leave/presentation/bloc/leave_request_cubit.dart';
import 'package:demo_login_ui/features/login/data/model/user_model.dart';
import 'package:demo_login_ui/features/login/presentation/widgets/leave_remaing_box.dart';
import 'package:demo_login_ui/features/login/presentation/widgets/leave_request_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class LeaveView extends StatelessWidget {
  final UserModel userModel;
  const LeaveView({
    super.key,
    required this.userModel,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Leaves"),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              showBottomSheet(
                elevation: 10,
                context: context,
                builder: (context) {
                  return LeaveRequestBottomSheet(
                    token: userModel.token ?? '',
                  );
                },
              );
            },
            icon: const PhosphorIcon(PhosphorIconsRegular.plusSquare),
          ),
        ],
      ),
      body: BlocBuilder<LeaveRequestCubit, LeaveRequestState>(
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    LeaveRemainingBox(
                      status: 'Leave Balance',
                      color: Colors.yellow,
                      remainDays: 10,
                    ),
                    LeaveRemainingBox(
                      status: 'Leave Pendings',
                      color: Colors.orange,
                      remainDays: 2,
                    ),
                  ],
                ),
                const SizedBox(
                  height: 16,
                ),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    LeaveRemainingBox(
                      status: 'Leave Approved',
                      color: Colors.green,
                      remainDays: 3,
                    ),
                    LeaveRemainingBox(
                      status: 'Leave Rejected',
                      color: Colors.red,
                      remainDays: 1,
                    ),
                  ],
                ),
                Container(
                  width: 150,
                  height: 50,
                  margin: const EdgeInsets.only(top: 20, bottom: 10),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: mainColor,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    "Leaves History",
                    style: TextStyleData.medium.copyWith(),
                  ),
                ),
                state.leaveList?.isEmpty == true
                    ? Expanded(
                        child: Center(
                          child: Text(
                            "No Leaves request.",
                            style: TextStyleData.medium.copyWith(
                              color: Colors.black,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      )
                    : Expanded(
                        child: state.leaveList == null
                            ? const Center(
                                child: CircularProgressIndicator(),
                              )
                            : ListView.builder(
                                itemCount: state.leaveList!.length,
                                itemBuilder: (_, index) {
                                  // Sort with created At
                                  state.leaveList!.sort((a, b) =>
                                      b.createdAt!.compareTo(a.createdAt!));
                                  final leave = state.leaveList![index];
                                  final applyDay = leave.endDate
                                      .difference(leave.startDate)
                                      .inDays;

                                  return Card(
                                    elevation: 0.5,
                                    child: Container(
                                      padding: const EdgeInsets.all(16),
                                      margin: const EdgeInsets.symmetric(
                                          vertical: 16),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    "Date",
                                                    style: TextStyleData.medium
                                                        .copyWith(
                                                      color: Colors.black,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                    ),
                                                  ),
                                                  Row(
                                                    children: [
                                                      Text(
                                                        DateFormat.yMMMd()
                                                            .format(
                                                          leave.startDate,
                                                        ),
                                                        style: TextStyleData
                                                            .semiBold
                                                            .copyWith(
                                                          color: Colors.black,
                                                        ),
                                                      ),
                                                      Text(
                                                        ' - ${DateFormat.yMMMd().format(leave.endDate)}',
                                                        style: TextStyleData
                                                            .semiBold
                                                            .copyWith(
                                                          color: Colors.black,
                                                        ),
                                                      ),
                                                    ],
                                                  )
                                                ],
                                              ),
                                              Text(
                                                leave.status! == 'pending'
                                                    ? 'Pending'
                                                    : leave.status! ==
                                                            'rejected'
                                                        ? 'Rejected'
                                                        : 'Approved',
                                                style: TextStyleData.medium
                                                    .copyWith(
                                                  color:
                                                      leave.status! == 'pending'
                                                          ? Colors.orange
                                                          : leave.status! ==
                                                                  'rejected'
                                                              ? Colors.red
                                                              : Colors.green,
                                                  fontWeight: FontWeight.w400,
                                                ),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(
                                            height: 8,
                                          ),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                "Title",
                                                style: TextStyleData.medium
                                                    .copyWith(
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.w400,
                                                ),
                                              ),
                                              Text(
                                                leave.reason,
                                                style: TextStyleData.semiBold
                                                    .copyWith(
                                                  color: Colors.black,
                                                ),
                                              )
                                            ],
                                          ),
                                          const SizedBox(
                                            height: 8,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    "Apply Days",
                                                    style: TextStyleData.medium
                                                        .copyWith(
                                                      color: Colors.black,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                    ),
                                                  ),
                                                  Text(
                                                    applyDay == 0
                                                        ? '1 day'
                                                        : '$applyDay days',
                                                    style: TextStyleData
                                                        .semiBold
                                                        .copyWith(
                                                      color: Colors.black,
                                                    ),
                                                  )
                                                ],
                                              ),
                                              const SizedBox(
                                                width: 40,
                                              ),
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    "Approved By",
                                                    style: TextStyleData.medium
                                                        .copyWith(
                                                            color: Colors.black,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w400),
                                                  ),
                                                  Text(
                                                    leave.approvedBy ?? '-',
                                                    style: TextStyleData
                                                        .semiBold
                                                        .copyWith(
                                                      color: Colors.black,
                                                    ),
                                                  )
                                                ],
                                              )
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              ),
                      ),
              ],
            ),
          );
        },
      ),
    );
  }
}
