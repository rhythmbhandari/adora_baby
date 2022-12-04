import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../config/app_colors.dart';

class ExitDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),),
          // side: BorderSide(color: AppColors.linear1)),
      backgroundColor: AppColors.secondary100,
      title: Text(
        'Quit?',
        style: TextStyle(
            color: Colors.black,
            // fontFamily: 'WWF',
            fontSize: 0.03 * Get.height),
      ),
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
                      AppColors.primary500,
                      AppColors.secondary500,
                    ]),
                borderRadius: BorderRadius.circular(15),
              ),
              child: Center(
                child: Padding(
                  padding: EdgeInsets.only(left:0.01*Get.height,right: 0.014*Get.height),
                  child: Text(
                    "NO, CONTINUE USING THE APP",
                    style: TextStyle(
                        color: Colors.white, fontFamily: 'Graphik',fontSize: 0.01*Get.height,
                        fontWeight: FontWeight.w500
                    ),
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
              "YES, I'LL COME BACK LATER.",
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