import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class CustomProgressBar extends StatelessWidget {
  bool isBlack;

  CustomProgressBar({
    this.isBlack = false,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Center(
      child: SizedBox(
          height: 0.2 * Get.height,
          width: 0.2 * Get.height,
          child: Lottie.asset('assets/animations/loader.json')),
    );
  }
}
