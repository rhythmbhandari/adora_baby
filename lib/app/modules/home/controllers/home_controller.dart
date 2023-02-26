import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../config/constants.dart';
import '../../../data/network/dio_client.dart';
import '../../../utils/secure_storage.dart';
import '../../profile/controllers/profile_controller.dart';

class HomeController extends GetxController {
  //TODO: Implement HomeController

  final count = 0.obs;
  final currentPage = 0.obs;

  final isRedirected = 3.obs;

  //

  // int currentPage = 0;
  // late TabController tabController;

  @override
  void onInit() {
    sendDeviceToken();
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void increment() => count.value++;

  static Future<bool> sendDeviceToken() async {
    try {
      const url = '$BASE_URL/device/';

      final firebaseMessaging = FirebaseMessaging.instance;
      final deviceType = Platform.isAndroid ? 'Android' : 'iOS';

      String? deviceToken = Platform.isAndroid
          ? await firebaseMessaging.getToken()
          : await firebaseMessaging.getAPNSToken();
      log(deviceToken ?? '');

      final body = jsonEncode(
        {"device_token": deviceToken, "device_type": deviceType},
      );

      final status = await DioHelper.postRequest(
        url,
        body,
        false,
        await SecureStorage.returnHeaderWithToken(),
      );
      if (status) {
        log('Sent device Token ===');
        return true;
      }
      return false;
    } catch (e) {
      return false;
    }
  }
}
