import 'package:adora_baby/app/modules/auth/views/baby_detail_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../config/app_colors.dart';
import '../../../config/app_theme.dart';
import '../../../widgets/buttons.dart';
import '../../../widgets/custom_progress_bar.dart';
import '../../../widgets/exit_dialog.dart';
import '../controllers/auth_controllers.dart';

class UsernameView extends GetView<AuthController> {
  UsernameView({super.key});

  final FocusNode fNameNode = FocusNode();
  final FocusNode uNameNode = FocusNode();
  final FocusNode passwordNode = FocusNode();

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
      },child: Scaffold(
        body: SingleChildScrollView(
          child: Stack(
            children: [
              SafeArea(
                child: Column(
                  children: [
                    const Hero(
                      tag: 'progress',
                      child: LinearProgressIndicator(
                        backgroundColor: Colors.transparent,
                        valueColor: AlwaysStoppedAnimation(AppColors.primary300),
                        value: 0.65,
                        minHeight: 7,
                      ),
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 32.0, right: 32, top: 12),
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
                            child: SvgPicture.asset(
                                "assets/images/arrow-left.svg",
                                height: 22,
                                color: const Color(0xff667080)),
                          ),
                          const SizedBox(
                            height: 14,
                          ),
                          SizedBox(
                            height: 272,
                            width: double.infinity,
                            child: SvgPicture.asset(
                                "assets/images/username_svg.svg"),
                          ),
                          const SizedBox(
                            height: 28,
                          ),
                          Text(
                            'Almost there...',
                            style: kThemeData.textTheme.displayMedium,
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Text(
                            'Just getting to know you better, so it is easier to come back to us.',
                            style: kThemeData.textTheme.bodyLarge,
                          ),
                          const SizedBox(
                            height: 32,
                          ),
                          TextField(
                              controller: controller.fullNameController,
                              // inputFormatters: [
                              //   LengthLimitingTextInputFormatter(6),
                              //   FilteringTextInputFormatter.digitsOnly
                              // ],
                              keyboardType: TextInputType.name,
                              onSubmitted: (_) {
                                node.requestFocus(uNameNode);
                              },
                              focusNode: fNameNode,
                              cursorColor: AppColors.mainColor,
                              style: kThemeData.textTheme.bodyLarge,
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
                                        color: DarkTheme.normal.withOpacity(0.7),
                                      ),
                                      borderRadius: BorderRadius.circular(33)),
                                  hintText: 'Full Name',
                                  contentPadding:
                                      const EdgeInsets.symmetric(horizontal: 24),
                                  hintStyle: const TextStyle(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 16,
                                      fontFamily: 'Poppins',
                                      color: Color.fromRGBO(178, 187, 198, 1),
                                      letterSpacing: 0.04))),
                          const SizedBox(
                            height: 32,
                          ),
                          TextField(
                              controller: controller.userNameController,
                              // inputFormatters: [
                              //   LengthLimitingTextInputFormatter(6),
                              //   FilteringTextInputFormatter.digitsOnly
                              // ],

                              focusNode: uNameNode,
                              keyboardType: TextInputType.name,
                              cursorColor: AppColors.mainColor,
                              style: kThemeData.textTheme.bodyLarge,
                              onSubmitted: (_) {
                                node.requestFocus(passwordNode);
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
                                        color: DarkTheme.normal.withOpacity(0.7),
                                      ),
                                      borderRadius: BorderRadius.circular(33)),
                                  hintText: 'User Name',
                                  contentPadding:
                                      const EdgeInsets.symmetric(horizontal: 24),
                                  hintStyle: const TextStyle(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 16,
                                      fontFamily: 'Poppins',
                                      color: Color.fromRGBO(178, 187, 198, 1),
                                      letterSpacing: 0.04))),
                          const SizedBox(
                            height: 32,
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
                                    obscureText:
                                        controller.passwordInvisible.value,
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
                                              color: DarkTheme.normal
                                                  .withOpacity(0.7),
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(33)),
                                        hintText: 'Password',
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
                                            color: DarkTheme.dark,
                                          ),
                                        ),
                                        contentPadding:
                                            const EdgeInsets.symmetric(
                                                horizontal: 24, vertical: 12),
                                        hintStyle: const TextStyle(
                                            fontWeight: FontWeight.w400,
                                            fontSize: 16,
                                            fontFamily: 'Poppins',
                                            color:
                                                Color.fromRGBO(178, 187, 198, 1),
                                            letterSpacing: 0.04))),
                              )),
                          const SizedBox(
                            height: 36,
                          ),
                          ButtonsWidget(
                            name: 'Next',
                            onPressed: controller
                                        .progressBarStatusUsername.value ==
                                    false
                                ? () async {
                                    controller.progressBarStatusUsername.value =
                                        true;
                                    final status =
                                        await controller.validateUsernamePage();
                                    if (!status) {
                                      var snackBar = SnackBar(
                                        elevation: 0,
                                        behavior: SnackBarBehavior.floating,
                                        backgroundColor: Colors.red,
                                        duration:
                                            const Duration(milliseconds: 2000),
                                        content: Text("${controller.authError}"),
                                      );
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(snackBar);
                                      controller.progressBarStatusUsername.value =
                                          false;
                                    } else {
                                      final response =
                                          await controller.registerUsername();
                                      if (response) {
                                        Get.to(() => BabyDetails(),);
                                        controller.progressBarStatusUsername
                                            .value = false;
                                      } else {
                                        var snackBar = SnackBar(
                                          elevation: 0,
                                          behavior: SnackBarBehavior.floating,
                                          backgroundColor: Colors.red,
                                          duration:
                                              const Duration(milliseconds: 2000),
                                          content:
                                              Text("${controller.authError}"),
                                        );
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(snackBar);
                                        controller.progressBarStatusUsername
                                            .value = false;
                                      }
                                    }
                                  }
                                : () {},
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Obx(() => controller.progressBarStatusUsername.value
                  ? CustomProgressBar()
                  : Container())
            ],
          ),
        ),
      ),
    );
  }
}
