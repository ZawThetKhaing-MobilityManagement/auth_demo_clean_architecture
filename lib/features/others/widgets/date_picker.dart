import 'package:demo_login_ui/core/style/text_style.dart';
import 'package:demo_login_ui/features/leave/presentation/bloc/leave_request_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class DatePicker extends StatelessWidget {
  const DatePicker({
    super.key,
    required this.hintText,
    required this.date,
    this.isStartDate = true,
  });

  final String hintText;
  final DateTime? date;
  final bool isStartDate;

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<LeaveRequestCubit>();
    return GestureDetector(
      onTap: () async {
        final dateRange = await showDatePicker(
          context: context,
          firstDate: DateTime.now(),
          lastDate: DateTime(DateTime.now().year + 1),
        );

        if (isStartDate) {
          cubit.datePickerChange(startDate: dateRange);
        } else {
          cubit.datePickerChange(endDate: dateRange);
        }
      },
      child: Card(
        child: Container(
          width: 130,
          padding: const EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                hintText,
                style: TextStyleData.medium.copyWith(
                  color: Colors.black,
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              Text(
                date == null ? '-' : DateFormat.yMMMd().format(date!),
                style: TextStyleData.semiBold.copyWith(
                  color: Colors.black,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
