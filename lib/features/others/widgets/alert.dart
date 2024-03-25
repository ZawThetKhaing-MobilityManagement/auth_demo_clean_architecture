import 'package:demo_login_ui/core/const/const.dart';
import 'package:demo_login_ui/core/style/text_style.dart';
import 'package:demo_login_ui/features/attendence/presentation/cubit/region_list/region_list_cubit.dart';
import 'package:demo_login_ui/features/others/widgets/button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class Alert extends StatefulWidget {
  const Alert({
    super.key,
    required this.onDealerChanged,
    required this.onRegionChanged,
    required this.onPressed,
  });

  final void Function(String?)? onDealerChanged;
  final void Function(String?)? onRegionChanged;
  final void Function() onPressed;

  @override
  State<Alert> createState() => _AlertState();
}

class _AlertState extends State<Alert> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RegionListCubit, ShopListState>(
      builder: (context, state) {
        return state is Loading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Select a dealer location.",
                    style: TextStyleData.large,
                  ),
                  AlertDialog(
                    icon: Container(
                      width: 90,
                      height: 90,
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: mainColor.withOpacity(0.5),
                        shape: BoxShape.circle,
                      ),
                      child: Container(
                        decoration: const BoxDecoration(
                          color: mainColor,
                          shape: BoxShape.circle,
                        ),
                        child: const PhosphorIcon(
                          PhosphorIconsRegular.navigationArrow,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    content: Column(
                      children: [
                        DropdownButton(
                          borderRadius: BorderRadius.circular(8),
                          value: state.region,
                          hint: const Text("Select region"),
                          isExpanded: true,
                          items: state.regionModel?.regionList
                              .map(
                                (region) => DropdownMenuItem(
                                  value: region.id.toString(),
                                  child: Text(region.name),
                                ),
                              )
                              .toList(),
                          onChanged: widget.onRegionChanged,
                        ),
                        DropdownButton(
                          borderRadius: BorderRadius.circular(8),
                          value: state.city,
                          hint: const Text("Select dealer"),
                          isExpanded: true,
                          items: state.dealerListModel?.dealerList
                              .map(
                                (dealer) => DropdownMenuItem(
                                  value: dealer.id.toString(),
                                  child: Text(dealer.name),
                                ),
                              )
                              .toList(),
                          onChanged: widget.onDealerChanged,
                        ),
                      ],
                    ),
                    actions: [
                      Button(
                        onPressed: () {
                          Navigator.of(context).pop();
                          widget.onPressed();
                        },
                        text: "Done",
                      )
                    ],
                  ),
                ],
              );
      },
    );
  }
}
