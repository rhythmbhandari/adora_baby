import 'package:adora_baby/app/config/app_theme.dart';
import 'package:adora_baby/app/modules/cart/controllers/cart_controller.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:responsive_framework/responsive_wrapper.dart';

import 'app/routes/app_pages.dart';
import 'app/utils/storage_manager.dart';

final storage = StorageManager();

Future<void> main() async {
  runApp(
    GetMaterialApp(
      builder: (context, child) => ResponsiveWrapper.builder(
        child,
        maxWidth: 1200,
        minWidth: 480,
        defaultScale: true,
        breakpoints: [
          const ResponsiveBreakpoint.resize(480, name: MOBILE),
          const ResponsiveBreakpoint.autoScale(800, name: TABLET),
          const ResponsiveBreakpoint.resize(1000, name: DESKTOP),
        ],
        // background: Container(color: Color(0xFFF5F5F5))
      ),
      debugShowCheckedModeBanner: false,
      title: "Application",
      theme: kThemeData,
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
    ),
  );
}
