import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../config/app_colors.dart';

class EmptyWidget extends StatelessWidget {
  const EmptyWidget({
    Key? key, this.isSearched = false,
    this.title = 'No data available.'
  }) : super(key: key);

  final bool isSearched;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: Get.height * 0.85,
      margin: EdgeInsets.symmetric(
        vertical: Get.height * 0.02,
      ),
      decoration: BoxDecoration(
        color: isSearched? LightTheme.whiteActive: LightTheme.white,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SvgPicture.asset(
            'assets/images/oops.svg',
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
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
              ),
              child: Text(
                title,
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
