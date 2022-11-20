import 'package:adora_baby/app/config/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../app/config/app_colors.dart';


class ButtonsWidget extends StatelessWidget {
  final String name;
  final void Function()? onPressed;
  const ButtonsWidget({super.key, required this.name, required this.onPressed});
  @override
  Widget build(BuildContext context) {
    return  GestureDetector(
      onTap: onPressed,

      child: Container(
        height: 0.065 * Get.height,
        width: 0.9 * Get.width,
        decoration: BoxDecoration(
          color: AppColors.mainColor,
          borderRadius: BorderRadius.circular(30),
        ),
        child:  Center(
          child: Text(
            name,
            style: kThemeData.textTheme.labelMedium,
          ),
        ),
      ),
    );
  }

}