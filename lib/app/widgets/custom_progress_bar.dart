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

    return Container(
      height: size.height,
      width: size.width,
      color: isBlack? Colors.black: Color(0xff181818).withOpacity(0.75),
      child: Center(
        child: SizedBox(
            height: 0.2 * Get.height,
            width: 0.2 * Get.height,
            child: Lottie.asset('assets/animations/loader.json')),
      ),
    );
  }
}
