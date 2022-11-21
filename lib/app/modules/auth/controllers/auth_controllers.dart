import 'package:adora_baby/app/config/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../repositories/auth_repository.dart';

class AuthController extends GetxController {
  TextEditingController phoneController = TextEditingController();
  TextEditingController otpController = TextEditingController();

  TextEditingController fullNameController = TextEditingController();
  TextEditingController userNameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController babyNameController = TextEditingController();
  TextEditingController dobController = TextEditingController();
  TextEditingController specialNoteController = TextEditingController();

  final passwordInvisible = true.obs;
  String? _dob;

  final storeMedicalCategories = [].obs;
  final storeMedicalCategoriesId = [].obs;

  final storeMedicalSubCategories = [].obs;
  final storeMedicalSubCategoriesId = [].obs;

  final storeMedicalCategoriesBool = [].obs;
  final storeMedicalSubCategoriesBool = [].obs;

  final storeMedicalLength = [].obs;

  setDate(String date) => _dob = date;

  final phone = ''.obs;
  final otp = ''.obs;
  final userName = ''.obs;
  final name = ''.obs;
  final dob = ''.obs;
  final babyName = ''.obs;
  final password = ''.obs;
  final authError = ''.obs;
  final progressBarStatus = false.obs;

  final chipList = ['Peanut', 'Milk', 'Soy'].obs;
  final chipIdList = [
    'a75e0c55-d518-4dc3-86dc-3d5569a6f1f9',
    'd9360b4f-ecb7-4eef-a85d-bdcee7810fc9',
    '9b5a9f8a-1f5d-433a-98c3-9713bb263de8'
  ].obs;
  final boolList = [false, false, false, false, false, false].obs;

  final chipList1 = ['Cold', 'Vomit', 'Insomnia'].obs;
  final chipIdList1 = [
    'a3db1ce6-4cda-464b-8d0f-3bb6afa0a783',
    '1840a1cc-9fb3-47c3-8dc8-c4392677d4e6',
    'a1352eb9-6a78-45ce-9a9c-9f9774e41233'
  ].obs;
  final boolList1 = [false, false, false, false, false, false].obs;

  final progressBarStatusOtp = false.obs;

  final progressBarBabyDetail = false.obs;
  final progressBarCompleteProfile = false.obs;

  final progressBarStatusUsername = false.obs;

  void changePasswordVisibility(bool status) =>
      passwordInvisible.value = status;

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

  Future<bool> validateUsernamePage() async {
    name.value = fullNameController.text.trim();
    userName.value = userNameController.text.trim();
    password.value = passwordController.text.trim();

    bool isValid = true;
    if (name.value.isEmpty) {
      isValid = false;
      authError.value = 'Name cannot be empty.'.tr;
    } else if (userName.value.isEmpty) {
      isValid = false;
      authError.value = 'User Name cannot be empty.'.tr;
    } else if (password.value.isEmpty) {
      isValid = false;
      authError.value = 'Password cannot be empty.'.tr;
    } else if (password.value.length < 8) {
      isValid = false;
      authError.value = 'Password needs to be at least 8 digits.'.tr;
    } else if (name.value.length < 3) {
      isValid = false;
      authError.value = 'Name is too short.'.tr;
    } else if (userName.value.length < 3) {
      isValid = false;
      authError.value = 'User Name is too short.'.tr;
    }
    return isValid;
  }

  Future<bool> validateBabyDetail() async {
    babyName.value = babyNameController.text.trim();

    bool isValid = true;
    if (babyName.value.isEmpty) {
      isValid = false;
      authError.value = 'Baby Name cannot be empty.'.tr;
    } else if (babyName.value.length < 3) {
      isValid = false;
      authError.value = 'Baby Name is too short.'.tr;
    } else if (_dob == '') {
      isValid = false;
      authError.value = 'Please select Date of Birth'.tr;
    }
    return isValid;
  }

  Future<bool> requestOtpController() async {
    try {
      const CircularProgressIndicator(color: AppColors.mainColor);
      // if (phoneController.text.trim() == '9869191572') {
      //   return true;
      // }
      final status =
          await AuthRepository.requestOtp(phoneController.text.trim())
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
      final status = await AuthRepository.verifyOtp(
              phoneController.text.trim(), otpController.text.trim())
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

  Future<bool> getMedicalCategories() async {
    try {
      final response =
          await AuthRepository.fetchMedicalCategories().catchError((error) {
        authError.value = error;
        return false;
      });

      if (response.isNotEmpty) {
        storeMedicalCategories.value = response[0];
        storeMedicalCategoriesId.value = response[1];

        storeMedicalSubCategories.value = response[2];
        storeMedicalSubCategoriesId.value = response[3];

        storeMedicalLength.value = response[4];

        storeMedicalCategoriesBool.value = response[5];
        storeMedicalSubCategoriesBool.value = response[6];
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }
}
