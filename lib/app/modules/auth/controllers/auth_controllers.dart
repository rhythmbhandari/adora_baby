import 'package:adora_baby/app/config/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../data/repositories/auth_repository.dart';

class AuthController extends GetxController {
  TextEditingController phoneController = TextEditingController();
  TextEditingController otpController = TextEditingController();

  TextEditingController fullNameController = TextEditingController();
  TextEditingController userNameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController babyNameController = TextEditingController();
  TextEditingController dobController = TextEditingController();
  TextEditingController specialNoteController = TextEditingController();

  TextEditingController loginPhoneController = TextEditingController();

  TextEditingController loginPasswordController = TextEditingController();

  TextEditingController resetPasswordController = TextEditingController();

  TextEditingController confirmPasswordController = TextEditingController();

  final resetPassword = false.obs;

  final passwordInvisible = true.obs;
  final passwordInvisibleLogin = true.obs;

  final resetPasswordInvisibleLogin = true.obs;

  final confirmPasswordInvisibleLogin = true.obs;
  String? _dob;

  final babyMedicalCondition = [].obs;

  final selectedTags = [].obs;

  setDate(String date) => _dob = date;

  final phone = ''.obs;
  final otp = ''.obs;
  final userName = ''.obs;
  final name = ''.obs;
  final dob = ''.obs;
  final babyName = ''.obs;
  final password = ''.obs;
  final authError = ''.obs;

  final resetPassw = ''.obs;
  final confirmPass = ''.obs;

  final specialNote = ''.obs;
  final selectedConditions = [].obs;

  final loginPhone = ''.obs;
  final loginPassword = ''.obs;

  final progressBarStatus = false.obs;

  final progressBarStatusReset = false.obs;

  final progressBarStatusLogin = false.obs;

  final progressBarStatusOtp = false.obs;

  final progressBarBabyDetail = false.obs;
  final progressBarCompleteProfile = false.obs;
  final isChecked = false.obs;
  final progressBarStatusUsername = false.obs;

  final progressBarStatusCompleteProfile = false.obs;

  void changePasswordVisibility(bool status) =>
      passwordInvisible.value = status;

  void changePasswordVisibilityLogin(bool status) =>
      passwordInvisibleLogin.value = status;

  void changePasswordVisibilityReset(bool status) =>
      resetPasswordInvisibleLogin.value = status;

  void changePasswordVisibilityConfirm(bool status) =>
      confirmPasswordInvisibleLogin.value = status;

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

  bool validateResetPassword() {
    resetPassw.value = resetPasswordController.text.trim();
    confirmPass.value = confirmPasswordController.text.trim();

    bool isValid = true;
    if (resetPassw.value.isEmpty) {
      isValid = false;
      authError.value = 'Password cannot be empty.'.tr;
    } else if (resetPassw.value.length < 8) {
      isValid = false;
      authError.value = 'Password needs to be at least 8 digits.'.tr;
    } else if (confirmPass.value.isEmpty) {
      isValid = false;
      authError.value = 'Confirm Password cannot be empty.'.tr;
    } else if (confirmPass.value.length < 8) {
      isValid = false;
      authError.value = 'Confirm Password needs to be at least 8 digits.'.tr;
    } else if (confirmPass.value != resetPassw.value) {
      isValid = false;
      authError.value = 'Password and Confirm Password do not match.'.tr;
    }
    return isValid;
  }

  bool validateMedicalCondition() {
    specialNote.value = specialNoteController.value.text.trim();

    // selectedConditions.addAll(selectedTags);

    // selectedConditions.value = "";
    //
    // if (selectedTags.length == 1) {
    //   selectedConditions.value = '"${selectedTags[0]}"';
    // } else {
    //   for (var i = 0; i < selectedTags.length; i++) {
    //     if (i == selectedTags.length - 1) {
    //       selectedConditions.value += '"${selectedTags[i]}"';
    //     } else {
    //       selectedConditions.value += '"${selectedTags[i]}",';
    //     }
    //   }
    // }

    bool isValid = true;
    print('Selected Tags is ${selectedTags.isEmpty}');
    if (selectedTags.isEmpty && specialNote.value == "") {
      isValid = false;
    }
    return isValid;
  }

  bool validateLogin() {
    loginPhone.value = loginPhoneController.text.trim();
    loginPassword.value = loginPasswordController.text.trim();

    bool isValid = true;
    if (loginPhone.value.isEmpty) {
      isValid = false;
      authError.value = 'Phone number cannot be empty.'.tr;
    } else if (loginPhone.value.length != 10) {
      isValid = false;
      authError.value = 'Phone number needs to be 10 digit'.tr;
    } else if (loginPassword.value.isEmpty) {
      isValid = false;
      authError.value = 'Password cannot be empty.'.tr;
    } else if (loginPassword.value.length < 8) {
      isValid = false;
      authError.value = 'Password needs to be at least 8 digits.'.tr;
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
    _dob = dobController.text.trim();

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

  Future<bool> requestOtpFromServer() async {
    try {
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

  Future<bool> registerUsername() async {
    try {
      final status = await AuthRepository.registerUserName(
              fullNameController.text.trim(),
              userNameController.text.trim(),
              passwordController.text.trim())
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

  Future<bool> registerBabyName() async {
    try {
      final status = await AuthRepository.registerBabyName(
              fullNameController.text.trim(),
              userNameController.text.trim(),
              passwordController.text.trim(),
              babyNameController.text.trim(),
              '${dobController.text.trim()}T00:00')
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

  Future<bool> registerMedicalCondition() async {
    try {
      final status = await AuthRepository.registerBabyName(
              fullNameController.text.trim(),
              userNameController.text.trim(),
              passwordController.text.trim(),
              babyNameController.text.trim(),
              '${dobController.text.trim()}T00:00')
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

  Future<bool> resetPasswordStarted() async {
    try {
      final status =
          await AuthRepository.reset(resetPasswordController.text.trim())
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

  Future<bool> requestResetPassword() async {
    try {
      final status =
          await AuthRepository.resetPassword(phoneController.text.trim())
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

  Future<bool> addMedicalCondition() async {
    try {
      final status = await AuthRepository.updateMedicalCondition(
              specialNote.value, selectedTags)
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

  Future<bool> verifyOtpFromServer() async {
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

  Future<bool> verifyResetPassword() async {
    try {
      final status = await AuthRepository.verifyReset(
              phoneController.text.trim(), otpController.text.trim())
          .catchError((error) {
        authError.value = error;
        return false;
      });
      print('Reset status is $status');
      if (status) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }

  Future<bool> login() async {
    try {
      final status = await AuthRepository.initiateLogin(
              loginPhoneController.text.trim(),
              loginPasswordController.text.trim())
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

  Future<List> getMedicalCategories() async {
    try {
      final response =
          await AuthRepository.fetchMedicalCategories().catchError((error) {
        authError.value = error;
        return false;
      });

      if (response.isNotEmpty) {
        babyMedicalCondition.value = response;
        return response;
      } else {
        return [];
      }
    } catch (e) {
      return [];
    }
  }


}
