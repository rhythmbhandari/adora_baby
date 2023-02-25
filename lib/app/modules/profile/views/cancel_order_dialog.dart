import 'package:adora_baby/app/modules/profile/controllers/profile_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../config/app_colors.dart';

class CancelOrderDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30),
      ),
      // side: BorderSide(color: AppColors.linear1)),
      backgroundColor: AppColors.primary500,
      title: Text(
        'Are you sure you want to cancel this order?',
        style: TextStyle(
            color: LightTheme.lightActive,
            // fontFamily: 'WWF',
            fontSize: 20),
      ),
      actionsAlignment: MainAxisAlignment.spaceBetween,
      actions: [
        GestureDetector(
          onTap: () async {

            Navigator.pop(context, true);

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
                  padding: EdgeInsets.only(
                      left: 0.01 * Get.height, right: 0.014 * Get.height),
                  child: Text(
                    "Yes",
                    style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'Graphik',
                        fontSize: 16,
                        fontWeight: FontWeight.w500),
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
              Navigator.pop(context, false);
            },
            child: Text(
              "No",
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: LightTheme.lightActive,
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
