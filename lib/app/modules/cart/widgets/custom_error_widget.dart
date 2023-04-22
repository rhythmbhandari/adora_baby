import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../config/app_colors.dart';

class CustomErrorWidget extends StatelessWidget {
  const CustomErrorWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: Get.height * 0.85,
      margin: EdgeInsets.symmetric(
        vertical: Get.height * 0.02,
      ),
      decoration: const BoxDecoration(
        color: LightTheme.white,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SvgPicture.asset(
            'assets/images/error.svg',
            width: Get.width,
            // height: Get.height * 0.4,
          ),
          Container(
            height: 37,
          ),
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
            ),
            child: Text(
              'Could not load data.',
              textAlign: TextAlign.center,
              style: Get.theme.textTheme.headlineMedium?.copyWith(
                color: DarkTheme.darkLightActive,
              ),
            ),
          ),
        ],
      ),
    );  }
}
