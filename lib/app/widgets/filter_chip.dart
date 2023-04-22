import 'package:adora_baby/app/modules/auth/controllers/auth_controllers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../config/app_colors.dart';

class FilterChipWidget extends StatefulWidget {
  final String chipName;
  final int index;
  final String chipType;


  const FilterChipWidget({super.key, required this.chipName, required this.index, required this.chipType});

  @override
  _FilterChipWidgetState createState() => _FilterChipWidgetState();
}

class _FilterChipWidgetState extends State<FilterChipWidget> {
  AuthController authController = Get.find();
   late final boolList;


  @override
  Widget build(BuildContext context) {
    return Obx(() => Stack(
      children: [
        Container(
          padding: const EdgeInsets.only(right: 3),
          child: FilterChip(
                showCheckmark: false,
                checkmarkColor: AppColors.success500,
                label: Text(widget.chipName),
                labelStyle: !boolList[widget.index]
                    ?const TextStyle(color: DarkTheme.lighter): const TextStyle(color: Colors.white),
                selected: boolList[widget.index],
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                    side: boolList[widget.index]
                        ? const BorderSide(color: AppColors.primary400)
                        : const BorderSide(color: DarkTheme.lighter)),
                backgroundColor: Colors.white,
                selectedColor: AppColors.primary400,
                // selectedColor: Colors.red,
                onSelected: (isSelected) {
                  FocusScopeNode currentFocus = FocusScope.of(context);
                  if (!currentFocus.hasPrimaryFocus) {
                    currentFocus.unfocus();
                  }
                  boolList[widget.index] = isSelected;
                },
              ),
        ),
        boolList[widget.index]
            ? Positioned(
          top: 0,
          right: 0,
          child: SizedBox(
            // margin: EdgeInsets.all(8),
            height: 18,
            width: 18,
            child: Container(
              // margin: EdgeInsets.all(8),
              height: 18,
              width: 18,
              decoration: BoxDecoration(
                color: boolList[widget.index]
                    ? AppColors.primary600
                    : AppColors.secondary100,
                shape: BoxShape.circle,
                gradient: const LinearGradient(
                    begin: Alignment.topRight,
                    end: Alignment.bottomLeft,
                    colors: [
                      AppColors.primary300,
                      AppColors.primary600,
                    ]),
              ),
              child: boolList[widget.index]
                  ? const Icon(
                Icons.done,
                size: 16,
                color: Colors.white,
              )
                  : Container(),
            ),
          ),
        )
            : const SizedBox(
          height: 0,
          width: 0,
        ),
      ],
    ));
  }
}
