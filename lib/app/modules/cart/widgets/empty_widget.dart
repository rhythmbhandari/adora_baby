import 'package:adora_baby/app/modules/profile/views/diamonds_view.dart';
import 'package:adora_baby/app/modules/profile/views/order_history.dart';
import 'package:adora_baby/app/modules/shop/views/temp_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../config/app_colors.dart';
import '../../../config/app_theme.dart';
import '../../profile/views/order_history_detail.dart';

class EmptyWidget extends StatelessWidget {
  const EmptyWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: Get.height * 0.85,
      margin: EdgeInsets.symmetric(
        vertical: Get.height * 0.02,
      ),
      decoration: BoxDecoration(
        color: LightTheme.white,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SvgPicture.asset(
            'assets/images/no_data.svg',
            width: Get.width,
            // height: Get.height * 0.4,
          ),
          Container(
            height: 37,
          ),
          GestureDetector(
            onTap: (){
              // Get.to(TempView());
            },
            child: Container(
              padding: EdgeInsets.symmetric(
                horizontal: 20,
              ),
              child: Text(
                'No data available.',
                textAlign: TextAlign.center,
                style: Get.theme.textTheme.headlineMedium?.copyWith(
                  color: DarkTheme.darkLightActive,
                ),
              ),
            ),
          ),
        ],
      ),
    );  }
}
