import 'dart:convert';
import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../config/constants.dart';
import '../../../data/network/dio_client.dart';
import '../../../data/repositories/auth_repository.dart';
import '../../../utils/secure_storage.dart';

class HomeController extends GetxController {
  final count = 0.obs;
  final currentPage = 0.obs;

  final isRedirected = 3.obs;

  TextEditingController currentPassController = TextEditingController();
  TextEditingController newPassController = TextEditingController();
  TextEditingController confirmPassController = TextEditingController();

  final currentPassInvisible = true.obs;
  final newPassInvisible = true.obs;
  final confirmPassInvisible = true.obs;

  final authError = ''.obs;
  final progressBarStatusReset = false.obs;

  void changePasswordVisibility(RxBool status) => status.value = !status.value;

  @override
  void onInit() {
    sendDeviceToken();
    super.onInit();
  }

  static Future<bool> sendDeviceToken() async {
    try {
      const url = '$BASE_URL/device/';

      final firebaseMessaging = FirebaseMessaging.instance;
      final deviceType = Platform.isAndroid ? 'Android' : 'iOS';

      String? deviceToken = Platform.isAndroid
          ? await firebaseMessaging.getToken()
          : await firebaseMessaging.getAPNSToken();

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
        return true;
      }
      return false;
    } catch (e) {
      return false;
    }
  }

  bool validateResetPassword() {
    String currentPass = currentPassController.text.trim();
    String newPass = newPassController.text.trim();
    String confirmNewPass = confirmPassController.text.trim();

    bool isValid = true;
    if (currentPass.isEmpty) {
      isValid = false;
      authError.value = 'Current password cannot be empty.';
    } else if (currentPass.length < 8) {
      isValid = false;
      authError.value = 'Current password needs to be at least 8 digits.';
    } else if (newPass.isEmpty) {
      isValid = false;
      authError.value = 'New password cannot be empty.';
    } else if (newPass.length < 8) {
      isValid = false;
      authError.value = 'New password needs to be at least 8 digits.';
    } else if (newPass == currentPass) {
      isValid = false;
      authError.value = 'New password cannot be the same as current password.';
    } else if (confirmNewPass.isEmpty) {
      isValid = false;
      authError.value = 'Confirm new password cannot be empty.';
    } else if (confirmNewPass.length < 8) {
      isValid = false;
      authError.value = 'Confirm new password needs to be at least 8 digits.';
    } else if (newPass != confirmNewPass) {
      isValid = false;
      authError.value = 'New password and confirm new password do not match';
    }
    return isValid;
  }

  Future<bool> initiatePasswordChange() async {
    try {
      final status = await AuthRepository.changePassword(
        currentPassController.text.trim(),
        newPassController.text.trim(),
      );

      if (status) {
        return true;
      } else {
        return false;
      }
    } catch (error) {
      authError.value = '$error';
      return false;
    }
  }
}
