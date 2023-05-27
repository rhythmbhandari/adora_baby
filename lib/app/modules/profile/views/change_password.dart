import 'package:adora_baby/app/modules/home/controllers/home_controller.dart';
import 'package:adora_baby/app/widgets/buttons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../config/app_colors.dart';
import '../../../config/app_theme.dart';
import '../../../widgets/awesome_snackbar/custom_snack_bar.dart';
import '../../../widgets/awesome_snackbar/top_snack_bar.dart';
import '../../../widgets/custom_progress_bar.dart';

class ChangePassword extends GetView<HomeController> {
  ChangePassword({Key? key}) : super(key: key);

  final FocusNode currentPassNode = FocusNode();
  final FocusNode newPassNode = FocusNode();
  final FocusNode confirmPassNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    final node = FocusScope.of(context);
    return Stack(
      children: [
        Scaffold(
            backgroundColor: Colors.white,
            body: SafeArea(
                bottom: false,
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: double.infinity,
                        height: 88,
                        color: Colors.white,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 33.0),
                              child: GestureDetector(
                                  onTap: () {
                                    Get.back();
                                  },
                                  child: SvgPicture.asset(
                                    "assets/images/arrow-left.svg",
                                    height: 26,
                                    width: 26,
                                    color: DarkTheme.darkNormal,
                                  )),
                            ),
                            const SizedBox(),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: Get.height * 0.01,
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 32,
                        ),
                        child: SingleChildScrollView(
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Center(
                                  child: SvgPicture.asset(
                                    "assets/images/change_pass.svg",
                                    height: Get.height * 0.32,
                                    width: 26,
                                  ),
                                ),
                                SizedBox(
                                  height: Get.height * 0.05,
                                ),
                                Text('Change Password',
                                    style: kThemeData.textTheme.displayMedium),
                                SizedBox(
                                  height: Get.height * 0.01,
                                ),
                                Text(
                                  'Set your new password to continue your journey.',
                                  style: kThemeData.textTheme.bodyLarge,
                                ),
                                SizedBox(
                                  height: Get.height * 0.03,
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          color: DarkTheme.lighter, width: 0),
                                      borderRadius: BorderRadius.circular(33)),
                                  child: Obx(
                                    () => TextField(
                                        controller: controller.currentPassController,
                                        // inputFormatters: [
                                        //   LengthLimitingTextInputFormatter(22),
                                        // ],
                                        focusNode: currentPassNode,
                                        obscureText:
                                            controller.currentPassInvisible.value,
                                        keyboardType: TextInputType.visiblePassword,
                                        cursorColor: AppColors.mainColor,
                                        style: kThemeData.textTheme.bodyLarge,
                                        onSubmitted: (_) {
                                          node.requestFocus(newPassNode);
                                        },
                                        decoration: InputDecoration(
                                          border: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(33),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                              borderSide: const BorderSide(
                                                width: 1,
                                                color: DarkTheme.darkLighter,
                                              ),
                                              borderRadius: BorderRadius.circular(33)),
                                          contentPadding: const EdgeInsets.symmetric(
                                              horizontal: 24, vertical: 16),
                                          hintStyle:
                                              kThemeData.textTheme.bodyLarge?.copyWith(
                                            color: DarkTheme.darkLighter,
                                          ),
                                          hintText: 'Current Password',
                                          suffixIcon: GestureDetector(
                                            onTap: () {
                                              controller.changePasswordVisibility(
                                                  controller.currentPassInvisible);
                                            },
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.only(right: 24.0),
                                              child: SvgPicture.asset(
                                                  !controller.currentPassInvisible.value
                                                      ? "assets/images/eye.svg"
                                                      : "assets/images/eye-slash.svg",
                                                  height: 22,
                                                  color: const Color(0xff667080)),
                                            ),
                                          ),
                                        )),
                                  ),
                                ),
                                SizedBox(
                                  height: Get.height * 0.04,
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          color: DarkTheme.lighter, width: 0),
                                      borderRadius: BorderRadius.circular(33)),
                                  child: Obx(
                                    () => TextField(
                                        controller: controller.newPassController,
                                        // inputFormatters: [
                                        //   LengthLimitingTextInputFormatter(22),
                                        // ],
                                        focusNode: newPassNode,
                                        obscureText: controller.newPassInvisible.value,
                                        keyboardType: TextInputType.visiblePassword,
                                        cursorColor: AppColors.mainColor,
                                        style: kThemeData.textTheme.bodyLarge,
                                        onSubmitted: (_) {
                                          node.requestFocus(
                                            confirmPassNode,
                                          );
                                        },
                                        decoration: InputDecoration(
                                          border: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(33),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                              borderSide: const BorderSide(
                                                width: 1,
                                                color: DarkTheme.darkLighter,
                                              ),
                                              borderRadius: BorderRadius.circular(33)),
                                          contentPadding: const EdgeInsets.symmetric(
                                              horizontal: 24, vertical: 16),
                                          hintStyle:
                                              kThemeData.textTheme.bodyLarge?.copyWith(
                                            color: DarkTheme.darkLighter,
                                          ),
                                          hintText: 'New Password',
                                          suffixIcon: GestureDetector(
                                            onTap: () {
                                              controller.changePasswordVisibility(
                                                  controller.newPassInvisible);
                                            },
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.only(right: 24.0),
                                              child: SvgPicture.asset(
                                                  !controller.newPassInvisible.value
                                                      ? "assets/images/eye.svg"
                                                      : "assets/images/eye-slash.svg",
                                                  height: 22,
                                                  color: const Color(0xff667080)),
                                            ),
                                          ),
                                        )),
                                  ),
                                ),
                                SizedBox(
                                  height: Get.height * 0.04,
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          color: DarkTheme.lighter, width: 0),
                                      borderRadius: BorderRadius.circular(33)),
                                  child: Obx(
                                    () => TextField(
                                        controller: controller.confirmPassController,
                                        // inputFormatters: [
                                        //   LengthLimitingTextInputFormatter(22),
                                        // ],
                                        focusNode: confirmPassNode,
                                        obscureText:
                                            controller.confirmPassInvisible.value,
                                        keyboardType: TextInputType.visiblePassword,
                                        cursorColor: AppColors.mainColor,
                                        style: kThemeData.textTheme.bodyLarge,
                                        onSubmitted: (_) {
                                          node.unfocus();
                                        },
                                        decoration: InputDecoration(
                                          border: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(33),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                              borderSide: const BorderSide(
                                                width: 1,
                                                color: DarkTheme.darkLighter,
                                              ),
                                              borderRadius: BorderRadius.circular(33)),
                                          contentPadding: const EdgeInsets.symmetric(
                                              horizontal: 24, vertical: 16),
                                          hintStyle:
                                              kThemeData.textTheme.bodyLarge?.copyWith(
                                            color: DarkTheme.darkLighter,
                                          ),
                                          hintText: 'Confirm New Password',
                                          suffixIcon: GestureDetector(
                                            onTap: () {
                                              controller.changePasswordVisibility(
                                                  controller.confirmPassInvisible);
                                            },
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.only(right: 24.0),
                                              child: SvgPicture.asset(
                                                  !controller.confirmPassInvisible.value
                                                      ? "assets/images/eye.svg"
                                                      : "assets/images/eye-slash.svg",
                                                  height: 22,
                                                  color: const Color(0xff667080)),
                                            ),
                                          ),
                                        )),
                                  ),
                                ),
                              ]),
                        ),
                      ),SizedBox(
                        height: Get.height * 0.04,
                      ),
                      Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 32,
                          ),
                          child: ButtonsWidget(
                              name: 'Reset',
                              onPressed: controller.progressBarStatusReset.value ==
                                  false
                                  ? () async {
                                try {
                                  controller.progressBarStatusReset.value =
                                  true;
                                  if (controller
                                      .validateResetPassword()) {
                                    final status =
                                    await controller.initiatePasswordChange();
                                    if (!status) {
                                      controller.progressBarStatusReset.value =
                                      false;
                                      showTopSnackBar(
                                        Overlay.of(context)!,
                                        CustomSnackBar.error(
                                          message:
                                          '${controller.authError.toUpperCase()}',
                                        ),
                                        displayDuration: const Duration(
                                          seconds: 3,
                                        ),
                                      );
                                    } else {
                                      controller.progressBarStatusReset.value =
                                      false;
                                      showTopSnackBar(
                                        Overlay.of(context)!,
                                        CustomSnackBar.success(
                                          message:
                                          'Successfully changed password.',
                                        ),
                                        displayDuration: const Duration(
                                          seconds: 3,
                                        ),
                                      );
                                      Get.back();
                                    }
                                  } else {
                                    showTopSnackBar(
                                      Overlay.of(context)!,
                                      CustomSnackBar.warning(
                                        message:
                                        '${controller.authError.toUpperCase()}',
                                      ),
                                      displayDuration: const Duration(
                                        seconds: 3,
                                      ),
                                    );
                                    controller.progressBarStatusReset.value =
                                    false;
                                  }
                                } catch (e) {
                                  controller.progressBarStatusReset.value =
                                  false;
                                }
                              }
                                  : () {},)),
                      SizedBox(
                        height: Get.height * 0.06,
                      ),
                    ],
                  ),
                ))),
        Obx(() => controller.progressBarStatusReset.value
            ? CustomProgressBar()
            : Container())
      ],
    );
  }
}
