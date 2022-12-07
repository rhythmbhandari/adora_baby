import 'package:adora_baby/app/config/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../config/app_colors.dart';

class ButtonsWidget extends StatelessWidget {
  final String name;
  final void Function()? onPressed;

  const ButtonsWidget({super.key, required this.name, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        padding:
            const EdgeInsets.only(top: 20, bottom: 20, left: 60, right: 60),
        decoration: BoxDecoration(
          color: AppColors.primary500,
          borderRadius: BorderRadius.circular(30),
        ),
        child: Center(
          child: Text(name,
              style: const TextStyle(
                color: Colors.white,

                fontFamily: "Poppins",
                fontSize: 10,
                fontWeight: FontWeight.w600,
              )),
        ),
      ),
    );
  }
}
