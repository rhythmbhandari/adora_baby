import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import '../app/config/app_colors.dart';

class CustomProgressBar extends StatelessWidget {



  @override
  Widget build(BuildContext context) {


    return Center(
      child: SizedBox(
          height: 0.2 * Get.height,
          width: 0.2 * Get.height,
          child: Lottie.asset('assets/animations/loader.json')),
    );
  }
}
