import 'package:adora_baby/app/modules/auth/controllers/auth_controllers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../app/config/app_colors.dart';

class FilterChipWidget extends StatefulWidget {
  final String chipName;
  final int index;
  final String chipType;


  const FilterChipWidget({required this.chipName, required this.index, required this.chipType});

  @override
  _FilterChipWidgetState createState() => _FilterChipWidgetState();
}

class _FilterChipWidgetState extends State<FilterChipWidget> {
  AuthController authController = Get.find();
   late final boolList;


  @override
  Widget build(BuildContext context) {
    if(widget.chipType == '1'){
      boolList = authController.boolList;
    }else{
      boolList = authController.boolList1;
    }
    return Obx(() => Stack(
      children: [
        Container(
          padding: EdgeInsets.only(right: 3),
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
                        ? BorderSide(color: AppColors.primary400)
                        : BorderSide(color: DarkTheme.lighter)),
                backgroundColor: Colors.white,
                selectedColor: AppColors.primary400,
                // selectedColor: Colors.red,
                onSelected: (isSelected) {
                  FocusScopeNode currentFocus = FocusScope.of(context);
                  if (!currentFocus.hasPrimaryFocus) {
                    currentFocus.unfocus();
                  }
                  boolList[widget.index] = isSelected;
                  print(isSelected);
                },
              ),
        ),
        boolList[widget.index]
            ? Positioned(
          top: 0,
          right: 0,
          child: Container(
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
                gradient: LinearGradient(
                    begin: Alignment.topRight,
                    end: Alignment.bottomLeft,
                    colors: [
                      AppColors.primary300,
                      AppColors.primary600,
                    ]),
              ),
              child: boolList[widget.index]
                  ? Icon(
                Icons.done,
                size: 16,
                color: Colors.white,
              )
                  : Container(),
            ),
          ),
        )
            : Container(
          height: 0,
          width: 0,
        ),
      ],
    ));
  }
}
