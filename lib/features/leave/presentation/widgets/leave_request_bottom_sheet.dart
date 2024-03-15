import 'package:demo_login_ui/core/style/text_style.dart';
import 'package:demo_login_ui/features/leave/domain/usecases/request_leave_usecase.dart';
import 'package:demo_login_ui/features/leave/presentation/bloc/leave_request_cubit.dart';
import 'package:demo_login_ui/features/others/widgets/button.dart';
import 'package:demo_login_ui/features/others/widgets/date_picker.dart';
import 'package:demo_login_ui/features/others/widgets/leave_request_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
                  builder: (_) => const LeaveRequestDialog(
                      icon: PhosphorIconsRegular.check,
                      title: "Leave apply Successful!",
                      content: "Please wait for your request approved."))
              .whenComplete(Navigator.of(context).pop);
        } else if (state is LeaveRequestFailed) {
          showDialog(
            context: context,
            builder: (_) => LeaveRequestDialog(
              icon: Icons.error,
              title: state.message?.split('!').first ?? "Leave apply failed!",
              content: state.message?.split('!').last ?? 'Fill data correctly.',
            ),
          );
        }
      },
      builder: (context, state) {
        final cubit = context.read<LeaveRequestCubit>();
        return Container(
          height: MediaQuery.of(context).size.height,
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
                        DatePicker(
                          hintText: "Start Date",
                          date: state.startDate,
                        ),
                        DatePicker(
                          isStartDate: false,
                          hintText: "End Date",
                          date: state.endDate,
                        )
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
                    if (state is LeaveRequestProcessing) return;
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
                  text: 'Apply Leave',
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
