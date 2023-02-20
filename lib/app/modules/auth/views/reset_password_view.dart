import 'package:adora_baby/app/config/app_theme.dart';
import 'package:adora_baby/app/modules/auth/views/login_view.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import '../../../config/app_colors.dart';
import '../../../routes/app_pages.dart';
import '../../../widgets/buttons.dart';
import '../../../widgets/custom_progress_bar.dart';
import '../../../widgets/exit_dialog.dart';
import '../controllers/auth_controllers.dart';

class ResetPasswordView extends GetView<AuthController> {
  ResetPasswordView({super.key});

  final FocusNode resetPaswordNode = FocusNode();
  final FocusNode confirmPaswordNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    final node = FocusScope.of(context);
    return WillPopScope(
      onWillPop: () async {
        await showDialog<bool>(
          context: context,
          builder: (context) {
            return ExitDialog();
          },
        );
        return false;
      },
      child: Scaffold(
        body: SafeArea(
          child: Stack(
            children: [
              SingleChildScrollView(
                child: Padding(
                  padding:
                      const EdgeInsets.only(left: 32.0, right: 32, top: 30),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      GestureDetector(
                        onTap: () async {
                          await showDialog<bool>(
                            context: context,
                            builder: (context) {
                              return ExitDialog();
                            },
                          );
                        },
                        child: SvgPicture.asset("assets/images/arrow-left.svg",
                            height: 22, color: Color(0xff667080)),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      SizedBox(
                        height: 312,
                        width: double.infinity,
                        child: SvgPicture.asset(
                            "assets/images/reset_password.svg"),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Text('Reset Password?',
                          style: kThemeData.textTheme.displayMedium),
                      const SizedBox(
                        height: 10,
                      ),
                      Text('Set your new password to continue your journey.',
                          // textAlign: TextAlign.justify,
                          style: kThemeData.textTheme.bodyLarge),
                      const SizedBox(
                        height: 20,
                      ),
                      Obx(() => Container(
                            decoration: BoxDecoration(
                                border: Border.all(
                                    color: DarkTheme.lighter, width: 0),
                                borderRadius: BorderRadius.circular(33)),
                            child: TextField(
                                controller: controller.resetPasswordController,
                                // inputFormatters: [
                                //   LengthLimitingTextInputFormatter(22),
                                // ],
                                focusNode: resetPaswordNode,
                                obscureText: controller
                                    .resetPasswordInvisibleLogin.value,
                                keyboardType: TextInputType.visiblePassword,
                                cursorColor: AppColors.mainColor,
                                style: kThemeData.textTheme.bodyLarge,
                                onSubmitted: (_) {
                                  node.requestFocus(confirmPaswordNode);
                                },
                                decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        width: 1,
                                        color: Colors.transparent,
                                      ),
                                      borderRadius: BorderRadius.circular(33),
                                    ),
                                    disabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
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
                                    hintText: 'Password',
                                    suffixIcon: GestureDetector(
                                      onTap: () {
                                        controller
                                            .changePasswordVisibilityReset(
                                                !controller
                                                    .resetPasswordInvisibleLogin
                                                    .value);
                                      },
                                      child: Icon(
                                        controller.resetPasswordInvisibleLogin
                                                .value
                                            ? Icons.visibility_off_outlined
                                            : Icons.visibility_outlined,
                                        color: DarkTheme.darkNormal,
                                      ),
                                    ),
                                    contentPadding: EdgeInsets.symmetric(
                                        horizontal: 24, vertical: 12),
                                    hintStyle: TextStyle(
                                        fontWeight: FontWeight.w400,
                                        fontSize: 16,
                                        fontFamily: 'Poppins',
                                        color: Color.fromRGBO(178, 187, 198, 1),
                                        letterSpacing: 0.04))),
                          )),
                      const SizedBox(
                        height: 30,
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
                                focusNode: confirmPaswordNode,
                                obscureText: controller
                                    .confirmPasswordInvisibleLogin.value,
                                keyboardType: TextInputType.visiblePassword,
                                cursorColor: AppColors.mainColor,
                                style: kThemeData.textTheme.bodyLarge,
                                onSubmitted: (_) {
                                  node.unfocus();
                                },
                                decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        width: 1,
                                        color: Colors.transparent,
                                      ),
                                      borderRadius: BorderRadius.circular(33),
                                    ),
                                    disabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
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
                                    hintText: 'Password',
                                    suffixIcon: GestureDetector(
                                      onTap: () {
                                        controller
                                            .changePasswordVisibilityConfirm(
                                                !controller
                                                    .confirmPasswordInvisibleLogin
                                                    .value);
                                      },
                                      child: Icon(
                                        controller.confirmPasswordInvisibleLogin
                                                .value
                                            ? Icons.visibility_off_outlined
                                            : Icons.visibility_outlined,
                                        color: DarkTheme.darkNormal,
                                      ),
                                    ),
                                    contentPadding: EdgeInsets.symmetric(
                                        horizontal: 24, vertical: 12),
                                    hintStyle: TextStyle(
                                        fontWeight: FontWeight.w400,
                                        fontSize: 16,
                                        fontFamily: 'Poppins',
                                        color: Color.fromRGBO(178, 187, 198, 1),
                                        letterSpacing: 0.04))),
                          )),
                      const SizedBox(
                        height: 30,
                      ),
                      ButtonsWidget(
                        name: 'Reset',
                        onPressed: controller.progressBarStatusReset.value ==
                                false
                            ? () async {
                                try {
                                  controller.progressBarStatusReset.value =
                                      true;
                                  if (await controller
                                      .validateResetPassword()) {
                                    final status =
                                        await controller.resetPasswordStarted();
                                    if (!status) {
                                      controller.progressBarStatusReset.value =
                                          false;
                                      var snackBar = SnackBar(
                                        elevation: 0,
                                        behavior: SnackBarBehavior.floating,
                                        backgroundColor: Colors.red,
                                        duration: Duration(milliseconds: 2000),
                                        content: Text(
                                            "${controller.authError.toUpperCase()}"),
                                      );
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(snackBar);
                                    } else {
                                      if (kDebugMode) {
                                        print("success");
                                      }
                                      controller.progressBarStatusReset.value =
                                          false;
                                      var snackBar = SnackBar(
                                        elevation: 0,
                                        behavior: SnackBarBehavior.floating,
                                        backgroundColor: AppColors.success500,
                                        duration: Duration(milliseconds: 2000),
                                        content: Text(
                                            "Successfully updated Password."),
                                      );
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(snackBar);
                                      Get.offAndToNamed(Routes.PHONE,
                                          arguments: true);
                                    }
                                  } else {
                                    var snackBar = SnackBar(
                                      elevation: 0,
                                      behavior: SnackBarBehavior.floating,
                                      backgroundColor: Colors.red,
                                      duration: Duration(milliseconds: 2000),
                                      content: Text("${controller.authError}"),
                                    );
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(snackBar);
                                    controller.progressBarStatusReset.value =
                                        false;
                                  }
                                } catch (e) {
                                  controller.progressBarStatusReset.value =
                                      false;
                                }
                              }
                            : () {},
                      ),
                    ],
                  ),
                ),
              ),
              Obx(() => controller.progressBarStatusReset.value
                  ? CustomProgressBar()
                  : Container())
            ],
          ),
        ),
      ),
    );
  }
}
