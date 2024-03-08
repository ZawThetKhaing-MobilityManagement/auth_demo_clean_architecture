import 'package:demo_login_ui/core/const/const.dart';
import 'package:demo_login_ui/core/style/text_style.dart';
import 'package:demo_login_ui/features/login/presentation/widgets/button.dart';
import 'package:demo_login_ui/features/login/presentation/widgets/leave_remaing_box.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class LeaveView extends StatelessWidget {
  const LeaveView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Leaves"),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              showModalBottomSheet(
                isScrollControlled: true,
                context: context,
                builder: (_) {
                  return Container(
                    height: MediaQuery.of(context).size.height * 0.8,
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10),
                      ),
                      color: Colors.white,
                    ),
                    child: ListView(
                      // crossAxisAlignment: CrossAxisAlignment.start,
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
                        TextFormField(
                          decoration: const InputDecoration(hintText: 'Reason'),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        CalendarDatePicker(
                          initialDate: DateTime.now(),
                          firstDate: DateTime(DateTime.now().year - 3),
                          lastDate: DateTime(DateTime.now().year + 3),
                          onDateChanged: (a) {},
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Start",
                                  style: TextStyleData.medium.copyWith(
                                    color: Colors.black,
                                  ),
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  DateFormat.yMMMd().format(DateTime.now()),
                                  style: TextStyleData.semiBold.copyWith(
                                    color: Colors.black,
                                  ),
                                )
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "End",
                                  style: TextStyleData.medium.copyWith(
                                    color: Colors.black,
                                  ),
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  DateFormat.yMMMd().format(DateTime.now()),
                                  style: TextStyleData.semiBold.copyWith(
                                    color: Colors.black,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        Text(
                          "Leaves Category",
                          style: TextStyleData.semiBold
                              .copyWith(color: Colors.black),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        DropdownButton(
                          borderRadius: BorderRadius.circular(10),
                          hint: const Text("Select"),
                          isExpanded: true,
                          items: const [
                            DropdownMenuItem(
                              value: 'Casual',
                              child: Text("Casual"),
                            ),
                            DropdownMenuItem(
                              value: 'Medical',
                              child: Text("Medical"),
                            ),
                            DropdownMenuItem(
                              value: 'Anual',
                              child: Text("Anual"),
                            ),
                          ],
                          onChanged: (value) {},
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Button(
                          onPressed: () {},
                          widgets: const [
                            Text("Apply Leave"),
                          ],
                        )
                      ],
                    ),
                  );
                },
              );
            },
            icon: const PhosphorIcon(PhosphorIconsRegular.plusSquare),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                LeaveRemainingBox(
                  status: 'Leave Balance',
                  color: Colors.orange,
                  remainDays: 10,
                ),
                LeaveRemainingBox(
                  status: 'Leave Pendings',
                  color: Colors.yellow,
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
            Expanded(
              child: ListView.builder(
                itemCount: 3,
                itemBuilder: (_, index) {
                  return Card(
                    elevation: 0.5,
                    child: Container(
                      padding: const EdgeInsets.all(16),
                      margin: const EdgeInsets.symmetric(vertical: 16),
                      child: Column(
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Date",
                                    style: TextStyleData.medium.copyWith(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        DateFormat.yMMMd()
                                            .format(DateTime.now())
                                            .toString(),
                                        style: TextStyleData.semiBold.copyWith(
                                          color: Colors.black,
                                        ),
                                      ),
                                      Text(
                                        ' - ${DateFormat.yMMMd().format(DateTime.now()).toString()}',
                                        style: TextStyleData.semiBold.copyWith(
                                          color: Colors.black,
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                              Text(
                                "Pendings",
                                style: TextStyleData.medium.copyWith(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          Row(
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Apply Days",
                                    style: TextStyleData.medium.copyWith(
                                        color: Colors.black,
                                        fontWeight: FontWeight.w400),
                                  ),
                                  Text(
                                    "3 Days",
                                    style: TextStyleData.semiBold.copyWith(
                                      color: Colors.black,
                                    ),
                                  )
                                ],
                              ),
                              const SizedBox(
                                width: 40,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Approved By",
                                    style: TextStyleData.medium.copyWith(
                                        color: Colors.black,
                                        fontWeight: FontWeight.w400),
                                  ),
                                  Text(
                                    "-",
                                    style: TextStyleData.semiBold.copyWith(
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
      ),
    );
  }
}
