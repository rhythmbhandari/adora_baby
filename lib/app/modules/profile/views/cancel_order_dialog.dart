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
      backgroundColor: LightTheme.lightNormalActive,
      title: Text('Are you sure you want to cancel this order?',
          textAlign: TextAlign.center,
          style: Get.theme.textTheme.titleMedium?.copyWith(
              color: DarkTheme.darkNormal,
              fontSize: 18,
              fontWeight: FontWeight.w700)),
      actionsAlignment: MainAxisAlignment.spaceBetween,
      actions: [
        GestureDetector(
          onTap: () async {
            Navigator.pop(context, false);
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
                  child: Text("No",
                      style: Get.theme.textTheme.labelSmall?.copyWith(
                          color: DarkTheme.darkNormal,
                          fontSize: 12,
                          fontWeight: FontWeight.w400)),
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
              Navigator.pop(context, true);
            },
            child: Text(
              "Yes",
              style: Get.theme.textTheme.labelSmall?.copyWith(
                  color: DarkTheme.darkNormal,
                  fontSize: 12,
                  fontWeight: FontWeight.w400),
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
