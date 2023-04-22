
import 'package:adora_baby/app/config/app_colors.dart';
import 'package:adora_baby/app/config/app_theme.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:get/get.dart';
import 'package:responsive_framework/responsive_wrapper.dart';
import 'package:firebase_core/firebase_core.dart';
import 'app/utils/local_notification_service.dart';
import 'firebase_options.dart';

import 'app/routes/app_pages.dart';
import 'app/utils/storage_manager.dart';

final storage = StorageManager();

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  String messageType = message.data['type'];
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
}


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  FirebaseMessaging messaging = FirebaseMessaging.instance;
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    if (message.notification != null) {
    }
  });

  LocalNotification.initialize();
  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    LocalNotification.showNotification(message);
  });

  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: AppColors.primary500, // You can use this as well
      statusBarIconBrightness: Brightness.light, // OR Vice Versa for ThemeMode.dark
      statusBarBrightness: Brightness.light, // OR Vice Versa for ThemeMode.dark
    ),
  );


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
      ),
      debugShowCheckedModeBanner: false,
      title: "Application",
      theme: kThemeData,
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
    ),
  );
}
