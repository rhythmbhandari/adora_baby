import 'package:adora_baby/app/config/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../repositories/auth_repository.dart';


class AuthController extends GetxController {
  TextEditingController phoneController = TextEditingController();
  TextEditingController otpController = TextEditingController();
  final phone = ''.obs;
  final otp = ''.obs;
  final authError = ''.obs;
  final progressBarStatus = false.obs;


  bool validatePhoneNumber() {
    phone.value = phoneController.text.trim();
    bool isValid = true;
    if (phone.value.isEmpty) {
      isValid = false;
      authError.value = 'Field cannot be empty.'.tr;
    } else if (phone.value.length != 10) {
      isValid = false;
      authError.value = 'Phone number needs to be 10 digit'.tr;
    }
    return isValid;
  }
  bool validateOtp() {
    otp.value = otpController.text.trim();
    bool isValid = true;
    if (otp.value.isEmpty) {
      isValid = false;
      authError.value = 'Field cannot be empty.'.tr;
    } else if (phone.value.length != 6) {
      isValid = false;
      authError.value = 'Phone number needs to be 6 digit'.tr;
    }
    return isValid;
  }
  Future<bool> requestOtpController() async {
    try {
      const CircularProgressIndicator(color: AppColors.mainColor);
      final status = await AuthRepository.requestOtp(phoneController.text.trim())
          .catchError((error) {
        authError.value = error;
        return false;
      });

      if (status) {
        return true;
      } else {
        return false;
      }
    } catch (e) {

      return false;
    }
  }
  Future<bool> verifyOtpController() async {
    try {

      final status = await AuthRepository.verifyOtp(phoneController.text.trim(),otpController.text.trim())
          .catchError((error) {
        authError.value = error;
        return false;
      });

      if (status) {
        return true;
      } else {
        return false;
      }
    } catch (e) {

      return false;
    }
  }


}
