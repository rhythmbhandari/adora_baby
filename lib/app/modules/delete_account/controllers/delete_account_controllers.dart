import 'dart:developer';

import 'package:adora_baby/app/data/repositories/auth_repository.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DeleteAccountController extends GetxController {
  TextEditingController reasonController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  final passwordInvisible = true.obs;
  final passwordConfirmInvisible = true.obs;
  final authError = ''.obs;

  final progressBarStatus = false.obs;

  showProgressBar() => progressBarStatus.value = true;

  hideProgressBar() => progressBarStatus.value = false;

  void changePasswordVisibility(bool status) =>
      passwordInvisible.value = status;

  void changeConfirmPasswordVisibility(bool status) =>
      passwordConfirmInvisible.value = status;

  Future<bool> validateReason() async {
    try {
      final reason = reasonController.text;
      if (reason.isEmpty) {
        authError.value = 'Please enter a reason';
        return false;
      }
      if (reason.length < 5) {
        authError.value = 'Please enter a longer reason';
        return false;
      }
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> validateDeletion() async {
    try {
      showProgressBar();
      final reason = reasonController.text;
      final password = passwordController.text;
      final confirmPass = confirmPasswordController.text;

      if (password.isEmpty) {
        authError.value = 'Please enter your password';
        return false;
      }
      if (confirmPass.isEmpty) {
        authError.value = 'Please confirm your password';
        return false;
      }
      if (confirmPass != password) {
        authError.value = 'Passwords do not match.';
        return false;
      }
      final status = await AuthRepository.deleteAccount(
          reason: reason, password: password, confirmPassword: confirmPass);
      hideProgressBar();

      return status;
    } catch (e) {
      hideProgressBar();

      authError.value = e.toString() ?? 'Server Error';
      return false;
    }
  }
}
