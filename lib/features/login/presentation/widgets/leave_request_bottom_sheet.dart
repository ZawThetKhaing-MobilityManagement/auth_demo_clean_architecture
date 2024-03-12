import 'package:demo_login_ui/core/const/const.dart';
import 'package:demo_login_ui/core/style/text_style.dart';
import 'package:demo_login_ui/features/leave/domain/usecases/request_leave_usecase.dart';
import 'package:demo_login_ui/features/leave/presentation/bloc/leave_request_cubit.dart';
import 'package:demo_login_ui/features/login/presentation/widgets/button.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class LeaveRequestBottomSheet extends StatefulWidget {
  final String token;
  const LeaveRequestBottomSheet({
    super.key,
    required this.token,
  });

  @override
  State<LeaveRequestBottomSheet> createState() =>
      _LeaveRequestBottomSheetState();
}

class _LeaveRequestBottomSheetState extends State<LeaveRequestBottomSheet> {
  final TextEditingController controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LeaveRequestCubit, LeaveRequestState>(
      listener: (context, state) async {
        if (state is LeaveRequestSuccessful) {
          await showDialog(
            context: context,
            builder: (_) => AlertDialog(
              icon: PhosphorIcon(
                PhosphorIconsFill.checkCircle,
                color: mainColor,
                size: 50,
              ),
              title: const Text("Leave request successfully !"),
              actions: [
                Button(
                  onPressed: Navigator.of(context).pop,
                  widgets: const [
                    Text("Ok"),
                  ],
                ),
              ],
            ),
          ).whenComplete(Navigator.of(context).pop);
        } else if (state is LeaveRequestFailed) {
          showDialog(
            context: context,
            builder: (_) => AlertDialog(
              icon: PhosphorIcon(
                Icons.error,
                color: mainColor,
                size: 50,
              ),
              title: const Text("Fill data correctly !"),
              actions: [
                Button(
                  onPressed: Navigator.of(context).pop,
                  widgets: const [
                    Text("Ok"),
                  ],
                ),
              ],
            ),
          );
        }
      },
      builder: (context, state) {
        final cubit = context.read<LeaveRequestCubit>();
        return Container(
          height: MediaQuery.of(context).size.height * 0.56,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10),
              topRight: Radius.circular(10),
            ),
            color: Colors.white,
          ),
          child: Padding(
            padding: const EdgeInsets.only(bottom: 15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Set The Dates",
                          style: TextStyleData.semiBold.copyWith(
                            color: Colors.black,
                          ),
                        ),
                        IconButton(
                          onPressed: Navigator.of(context).pop,
                          icon: const Icon(Icons.close),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: () async {
                            final dateRange = await showDatePicker(
                              context: context,
                              firstDate: DateTime.now(),
                              lastDate: DateTime(DateTime.now().year + 1),
                            );

                            cubit.datePickerChange(startDate: dateRange);
                          },
                          child: Card(
                            child: Container(
                              width: 130,
                              padding: const EdgeInsets.all(15),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Start Date",
                                    style: TextStyleData.medium.copyWith(
                                      color: Colors.black,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    state.startDate == null
                                        ? '-'
                                        : DateFormat.yMMMd()
                                            .format(state.startDate!),
                                    style: TextStyleData.semiBold.copyWith(
                                      color: Colors.black,
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () async {
                            final dateRange = await showDatePicker(
                              context: context,
                              firstDate: DateTime.now(),
                              lastDate: DateTime(DateTime.now().year + 1),
                            );
                            cubit.datePickerChange(endDate: dateRange);
                          },
                          child: Card(
                            child: Container(
                              width: 130,
                              padding: const EdgeInsets.all(15.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "End Date",
                                    style: TextStyleData.medium.copyWith(
                                      color: Colors.black,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    state.endDate == null
                                        ? '-'
                                        : DateFormat.yMMMd()
                                            .format(state.endDate!),
                                    style: TextStyleData.semiBold.copyWith(
                                      color: Colors.black,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    TextFormField(
                      decoration: const InputDecoration(hintText: 'Reason'),
                      controller: controller,
                      validator: (value) =>
                          value?.isEmpty == true ? 'Reason required' : null,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      "Leaves Category",
                      style:
                          TextStyleData.semiBold.copyWith(color: Colors.black),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    DropdownButton(
                      value: state.dropDownValue,
                      borderRadius: BorderRadius.circular(10),
                      hint: const Text("Select"),
                      isExpanded: true,
                      items: const [
                        DropdownMenuItem(
                          value: 'casual',
                          child: Text("Casual"),
                        ),
                        DropdownMenuItem(
                          value: 'medical',
                          child: Text("Medical"),
                        ),
                        DropdownMenuItem(
                          value: 'annual',
                          child: Text("Annual"),
                        ),
                      ],
                      onChanged: (value) {
                        cubit.dropDownChange(value);
                      },
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                  ],
                ),
                Button(
                  onPressed: () async {
                    if (controller.text.isEmpty ||
                        state.startDate == null ||
                        state.endDate == null ||
                        state.dropDownValue == null ||
                        state.startDate
                                ?.compareTo(state.endDate ?? DateTime.now()) ==
                            1) {
                      cubit.emitFailedState();
                      return;
                    }

                    final leaveParams = LeaveParams(
                      reason: controller.text,
                      permissionType: state.dropDownValue ?? '',
                      startDate: state.startDate ?? DateTime.now(),
                      token: widget.token,
                      endDate: state.endDate ?? DateTime.now(),
                    );
                    cubit.postLeaveRequest(leaveParams);
                  },
                  widgets: const [
                    Text("Apply Leave"),
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
