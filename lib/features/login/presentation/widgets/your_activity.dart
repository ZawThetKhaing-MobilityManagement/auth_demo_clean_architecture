import 'package:demo_login_ui/core/const/const.dart';
import 'package:demo_login_ui/core/style/text_style.dart';
import 'package:demo_login_ui/features/attendence/presentation/cubit/attendence_list_cubit/attendence_list_cubit.dart';
import 'package:demo_login_ui/features/attendence/presentation/cubit/attendence_list_cubit/attendence_list_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class YourActivity extends StatelessWidget {
  const YourActivity({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AttendenceListCubit, AttendenceListState>(
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
                state.model?.data.isEmpty == true
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
                        child: state.model?.data.isNotEmpty == true
                            ? ListView.builder(
                                itemCount: (state.model?.data.length ?? 0) > 14
                                    ? 14
                                    : state.model?.data.length,
                                itemBuilder: (_, index) {
                                  return Card(
                                    elevation: 0.5,
                                    color: Colors.white,
                                    child: Padding(
                                      padding: const EdgeInsets.all(12.0),
                                      child: Row(
                                        children: [
                                          Container(
                                            width: 32,
                                            height: 32,
                                            decoration: BoxDecoration(
                                              color: mainColor.withOpacity(0.5),
                                              shape: BoxShape.circle,
                                            ),
                                            child: const Icon(
                                              PhosphorIconsRegular.signIn,
                                              size: 16,
                                              color: mainColor,
                                            ),
                                          ),
                                          const SizedBox(
                                            width: 8,
                                          ),
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Text(
                                                      'Clock in',
                                                      style: TextStyleData
                                                          .semiBold
                                                          .copyWith(
                                                        color: Colors.black,
                                                      ),
                                                    ),
                                                    Text(
                                                      DateFormat.jm().format(
                                                        state.model?.data[index]
                                                                .checkIn ??
                                                            DateTime.now(),
                                                      ),
                                                      style: TextStyleData
                                                          .semiBold
                                                          .copyWith(
                                                        color: Colors.black,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Text(
                                                      'Clock out',
                                                      style: TextStyleData
                                                          .semiBold
                                                          .copyWith(
                                                        color: Colors.black,
                                                      ),
                                                    ),
                                                    Text(
                                                      state.model?.data[index]
                                                                  .checkOut ==
                                                              null
                                                          ? "-----"
                                                          : DateFormat.jm()
                                                              .format(state
                                                                  .model!
                                                                  .data[index]
                                                                  .checkOut!),
                                                      style: TextStyleData
                                                          .semiBold
                                                          .copyWith(
                                                        color: Colors.black,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                const SizedBox(
                                                  height: 4,
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Text(
                                                      state.model?.data[index]
                                                              .dealerName ??
                                                          '',
                                                      style: TextStyleData
                                                          .regular
                                                          .copyWith(
                                                        color: Colors.grey,
                                                      ),
                                                    ),
                                                    Text(
                                                      DateFormat.yMMMMd()
                                                          .format(
                                                        state.model?.data[index]
                                                                .createdAt ??
                                                            DateTime.now(),
                                                      ),
                                                      style: TextStyleData
                                                          .regular
                                                          .copyWith(
                                                        color: Colors.grey,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
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
                                child: const CircularProgressIndicator(),
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
