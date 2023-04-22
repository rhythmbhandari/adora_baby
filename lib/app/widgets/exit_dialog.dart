import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../config/app_colors.dart';

class ExitDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30),
      ),
      // side: BorderSide(color: AppColors.linear1)),
      backgroundColor: LightTheme.lightNormalActive,
      title: Text('Are you sure you want to quit?',
          textAlign: TextAlign.center,
          style: Get.theme.textTheme.titleMedium?.copyWith(
              color: DarkTheme.darkNormal,
              fontSize: 18,
              fontWeight: FontWeight.w700)),
      actionsAlignment: MainAxisAlignment.spaceBetween,
      actions: [
        GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Center(
            child: Container(
              height: 0.05 * Get.height,
              width: 0.6 * Get.width,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topRight,
                    end: Alignment.bottomLeft,
                    colors: [
                      AppColors.linear2,
                      AppColors.linear1,
                    ]),
                borderRadius: BorderRadius.circular(15),
              ),
              child: Center(
                child: Padding(
                  padding: EdgeInsets.only(
                      left: 0.01 * Get.height, right: 0.014 * Get.height),
                  child: FittedBox(
                    child: Text("No, Continue Using the App",
                        maxLines: 1,
                        style: Get.theme.textTheme.labelSmall?.copyWith(
                            color: DarkTheme.darkNormal,
                            fontSize: 14,
                            fontWeight: FontWeight.w400)),
                  ),
                ),
              ),
            ),
          ),
        ),
        SizedBox(
          height: 0.02 * Get.height,
        ),
        Center(
          child: GestureDetector(
            onTap: () {
              exit(0);
            },
            child: Text(
              "Yes, I’ll come back later",
              style: TextStyle(
                  fontSize: 0.014*Get.height,
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                  // decoration: TextDecoration.underline,
                  decorationColor: Colors.grey),
            ),
          ),
        ),
        SizedBox(
          height: 0.02 * Get.height,
        )
      ],
    );
  }

}