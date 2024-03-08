import 'package:demo_login_ui/core/const/const.dart';
import 'package:demo_login_ui/core/style/text_style.dart';
import 'package:demo_login_ui/features/get_location/data/model/attendence_list_model.dart';
import 'package:demo_login_ui/features/get_location/presentation/cubit/attendence_list_cubit/attendence_list_cubit.dart';
import 'package:demo_login_ui/features/get_location/presentation/cubit/attendence_list_cubit/attendence_list_state.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class YourActivity extends StatefulWidget {
  const YourActivity({super.key});

  @override
  State<YourActivity> createState() => _YourActivityState();
}

class _YourActivityState extends State<YourActivity> {
  AttendenceListModel? model;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AttendenceListCubit, AttendenceListState>(
      listener: (context, state) {
        print("Attendence is $state");
        if (state is LoadedAttendenceList) {
          model = state.model;
        }
      },
      builder: (context, state) {
        return Expanded(
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
                model?.data.isEmpty == true
                    ? Expanded(
                        child: Container(
                          alignment: Alignment.center,
                          child: Text(
                            "No activity data.",
                            style: TextStyleData.medium.copyWith(
                              color: Colors.black,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      )
                    : Expanded(
                        child: model?.data.isNotEmpty == true
                            ? ListView.builder(
                                itemCount: (model?.data.length ?? 0) > 14
                                    ? 14
                                    : model?.data.length,
                                itemBuilder: (_, index) {
                                  print("BUild");
                                  return Card(
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
                                        model?.data[index].status == CHECK_IN
                                            ? 'Clock-In'
                                            : 'Clock-Out',
                                        style: TextStyleData.semiBold.copyWith(
                                          color: Colors.black,
                                        ),
                                      ),
                                      subtitle: Text(
                                        DateFormat.yMMMMd().format(
                                          model?.data[index].createdAt ??
                                              DateTime.now(),
                                        ),
                                        style: TextStyleData.regular.copyWith(
                                          color: Colors.grey,
                                        ),
                                      ),
                                      trailing: Column(
                                        children: [
                                          Text(
                                            DateFormat.jm().format(
                                              model?.data[index].createdAt ??
                                                  DateTime.now(),
                                            ),
                                            style:
                                                TextStyleData.semiBold.copyWith(
                                              color: Colors.black,
                                            ),
                                          ),
                                          Text(
                                            "On-time",
                                            style:
                                                TextStyleData.regular.copyWith(
                                              color: Colors.grey,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              )
                            : Container(
                                alignment: Alignment.center,
                                child: CircularProgressIndicator(),
                              ),
                      ),
              ],
            ),
          ),
        );
      },
    );
  }
}
