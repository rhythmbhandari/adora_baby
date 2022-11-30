import 'package:adora_baby/app/config/app_theme.dart';
import 'package:adora_baby/utils/storage_manager.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'app/dependencies.dart';
import 'app/routes/app_pages.dart';

final storage = StorageManager();

Future<void> main() async {
  await init();

  runApp(
    GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Application",
      theme: kThemeData,
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
    ),
  );
}
