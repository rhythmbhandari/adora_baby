import 'package:adora_baby/app/config/app_colors.dart';
import 'package:adora_baby/app/modules/splash/views/splash_container.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/splash_controller.dart';

class SplashView extends GetView<SplashController> {
  const SplashView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: LightTheme.light,
      body: controller.obx(
        (_) {
          return Container();
        },
        onLoading: const SplashContainer(),
      ),
    );
  }
}
