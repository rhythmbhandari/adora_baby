import 'package:adora_baby/app/modules/delete_account/controllers/delete_account_controllers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../../main.dart';
import '../../../config/app_colors.dart';
import '../../../config/app_theme.dart';
import '../../../config/constants.dart';
import '../../../routes/app_pages.dart';
import '../../../widgets/awesome_snackbar/custom_snack_bar.dart';
import '../../../widgets/awesome_snackbar/top_snack_bar.dart';
import '../../../widgets/buttons.dart';
import '../../../widgets/custom_progress_bar.dart';

class DeleteConfirmView extends GetView<DeleteAccountController> {
  DeleteConfirmView({Key? key}) : super(key: key);

  final FocusNode passwordNode = FocusNode();
  final FocusNode confirmPasswordNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    final node = FocusScope.of(context);

    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 32.0, right: 32, top: 30),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                      child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      GestureDetector(
                        onTap: () async {
                          Get.back();
                        },
                        child: SvgPicture.asset("assets/images/arrow-left.svg",
                            height: 24, color: const Color(0xff667080)),
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                      Text('Goodbye, hope you will be back!',
                          textAlign: TextAlign.start,
                          style: Get.theme.textTheme.titleMedium?.copyWith(
                              color: DarkTheme.dark,
                              fontFamily: 'PLayfair',
                              fontSize: 35,
                              letterSpacing: -0.02,
                              height: 1.2,
                              fontWeight: FontWeight.w600)),
                      const SizedBox(
                        height: 30,
                      ),
                      Obx(() => Container(
                            decoration: BoxDecoration(
                                border: Border.all(
                                    color: DarkTheme.lighter, width: 0),
                                borderRadius: BorderRadius.circular(33)),
                            child: TextField(
                                controller: controller.passwordController,
                                // inputFormatters: [
                                //   LengthLimitingTextInputFormatter(22),
                                // ],
                                focusNode: passwordNode,
                                obscureText: controller.passwordInvisible.value,
                                keyboardType: TextInputType.visiblePassword,
                                cursorColor: AppColors.mainColor,
                                style: kThemeData.textTheme.bodyLarge,
                                onSubmitted: (_) {
                                  node.requestFocus(confirmPasswordNode);
                                },
                                decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                        width: 1,
                                        color: Colors.transparent,
                                      ),
                                      borderRadius: BorderRadius.circular(33),
                                    ),
                                    disabledBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                        width: 1,
                                        color: Colors.transparent,
                                      ),
                                      borderRadius: BorderRadius.circular(33),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          width: 1,
                                          color:
                                              DarkTheme.normal.withOpacity(0.7),
                                        ),
                                        borderRadius:
                                            BorderRadius.circular(33)),
                                    hintText: 'Enter Password',
                                    suffixIcon: GestureDetector(
                                      onTap: () {
                                        controller.changePasswordVisibility(
                                            !controller
                                                .passwordInvisible.value);
                                      },
                                      child: Icon(
                                        controller.passwordInvisible.value
                                            ? Icons.visibility_off_outlined
                                            : Icons.visibility_outlined,
                                        color: DarkTheme.darkNormal,
                                      ),
                                    ),
                                    contentPadding: const EdgeInsets.symmetric(
                                        horizontal: 24, vertical: 12),
                                    hintStyle: const TextStyle(
                                        fontWeight: FontWeight.w400,
                                        fontSize: 16,
                                        fontFamily: 'Poppins',
                                        color: Color.fromRGBO(178, 187, 198, 1),
                                        letterSpacing: 0.04))),
                          )),
                      const SizedBox(
                        height: 32,
                      ),
                      Obx(() => Container(
                            decoration: BoxDecoration(
                                border: Border.all(
                                    color: DarkTheme.lighter, width: 0),
                                borderRadius: BorderRadius.circular(33)),
                            child: TextField(
                                controller:
                                    controller.confirmPasswordController,
                                // inputFormatters: [
                                //   LengthLimitingTextInputFormatter(22),
                                // ],
                                focusNode: confirmPasswordNode,
                                obscureText:
                                    controller.passwordConfirmInvisible.value,
                                keyboardType: TextInputType.visiblePassword,
                                cursorColor: AppColors.mainColor,
                                style: kThemeData.textTheme.bodyLarge,
                                onSubmitted: (_) {
                                  node.unfocus();
                                },
                                decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                        width: 1,
                                        color: Colors.transparent,
                                      ),
                                      borderRadius: BorderRadius.circular(33),
                                    ),
                                    disabledBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                        width: 1,
                                        color: Colors.transparent,
                                      ),
                                      borderRadius: BorderRadius.circular(33),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          width: 1,
                                          color:
                                              DarkTheme.normal.withOpacity(0.7),
                                        ),
                                        borderRadius:
                                            BorderRadius.circular(33)),
                                    hintText: 'Confirm Password',
                                    suffixIcon: GestureDetector(
                                      onTap: () {
                                        controller
                                            .changeConfirmPasswordVisibility(
                                                !controller
                                                    .passwordConfirmInvisible
                                                    .value);
                                      },
                                      child: Icon(
                                        controller
                                                .passwordConfirmInvisible.value
                                            ? Icons.visibility_off_outlined
                                            : Icons.visibility_outlined,
                                        color: DarkTheme.darkNormal,
                                      ),
                                    ),
                                    contentPadding: const EdgeInsets.symmetric(
                                        horizontal: 24, vertical: 12),
                                    hintStyle: const TextStyle(
                                        fontWeight: FontWeight.w400,
                                        fontSize: 16,
                                        fontFamily: 'Poppins',
                                        color: Color.fromRGBO(178, 187, 198, 1),
                                        letterSpacing: 0.04))),
                          )),
                      const SizedBox(
                        height: 20,
                      ),
                    ],
                  )),
                  ButtonsWidget(
                      name: 'Delete my Account',
                      onPressed: () async {
                        final status = await controller.validateDeletion();
                        if (!status) {
                          showTopSnackBar(
                            Overlay.of(context),
                            CustomSnackBar.warning(
                              message: '${controller.authError.toUpperCase()}',
                            ),
                            displayDuration: const Duration(
                              seconds: 3,
                            ),
                          );
                          controller.hideProgressBar();
                        } else {
                          await storage.delete(
                            Constants.ACCESS_TOKEN,
                          );
                          await storage.delete(
                            Constants.LOGGED_IN_STATUS,
                          );
                          await storage.delete(
                            Constants.REFRESH_TOKEN,
                          );
                          Get.offAllNamed(Routes.LOGIN);
                        }
                      }),
                  const SizedBox(
                    height: 61,
                  ),
                ],
              ),
            ),
            Obx(() => controller.progressBarStatus.value
                ? CustomProgressBar()
                : Container())
          ],
        ),
      ),
    );
  }
}
