import 'package:adora_baby/app/config/app_theme.dart';
import 'package:adora_baby/app/modules/auth/views/baby_detail_view.dart';
import 'package:adora_baby/app/modules/auth/views/forget_password_view.dart';
import 'package:adora_baby/app/modules/auth/views/phone_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../../main.dart';
import '../../../config/app_colors.dart';
import '../../../config/constants.dart';
import '../../../routes/app_pages.dart';
import '../../../widgets/awesome_snackbar/custom_snack_bar.dart';
import '../../../widgets/awesome_snackbar/top_snack_bar.dart';
import '../../../widgets/buttons.dart';
import '../../../widgets/custom_progress_bar.dart';
import '../../../widgets/exit_dialog.dart';
import '../controllers/auth_controllers.dart';

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  late AuthController controller;

  @override
  void initState() {
    super.initState();
    try {
      controller = Get.find<AuthController>();
    } catch (e) {
      controller = Get.put<AuthController>(AuthController());
    }
  }

  final FocusNode loginPhoneNode = FocusNode();
  final FocusNode loginPasswordNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    Color getColor(Set<MaterialState> states) {
      const Set<MaterialState> interactiveStates = <MaterialState>{
        MaterialState.pressed,
        MaterialState.hovered,
        MaterialState.focused,
      };
      if (states.any(interactiveStates.contains)) {
        return Colors.white;
      }
      return DarkTheme.lighter;
    }

    final node = FocusScope.of(context);
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.only(left: 32.0, right: 32, top: 30),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 30,
                    ),
                    SizedBox(
                      height: 244,
                      width: double.infinity,
                      child: SvgPicture.asset("assets/images/login_svg.svg"),
                    ),
                    Text('Login', style: kThemeData.textTheme.displayMedium),
                    const SizedBox(
                      height: 32,
                    ),
                    TextField(
                        controller: controller.loginPhoneController,
                        inputFormatters: [
                          LengthLimitingTextInputFormatter(10),
                          FilteringTextInputFormatter.digitsOnly
                        ],
                        keyboardType: TextInputType.number,
                        cursorColor: AppColors.mainColor,
                        onSubmitted: (_) {
                          node.requestFocus(loginPasswordNode);
                        },
                        style: kThemeData.textTheme.bodyLarge,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(33),
                            ),
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  width: 1,
                                  color: DarkTheme.normal.withOpacity(0.7),
                                ),
                                borderRadius: BorderRadius.circular(33)),
                            hintText: 'Phone Number',
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
                              controller: controller.loginPasswordController,
                              // inputFormatters: [
                              //   LengthLimitingTextInputFormatter(22),
                              // ],
                              focusNode: loginPasswordNode,
                              obscureText:
                                  controller.passwordInvisibleLogin.value,
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
                                      borderRadius: BorderRadius.circular(33)),
                                  hintText: 'Password',
                                  suffixIcon: GestureDetector(
                                    onTap: () {
                                      controller.changePasswordVisibilityLogin(
                                          !controller
                                              .passwordInvisibleLogin.value);
                                    },
                                    child: Icon(
                                      controller.passwordInvisibleLogin.value
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
                      height: 30,
                    ),
                    ButtonsWidget(
                      name: 'Login',
                      onPressed: controller.progressBarStatusLogin.value ==
                              false
                          ? () async {
                              try {
                                controller.progressBarStatusLogin.value = true;
                                if (controller.validateLogin()) {
                                  final status = await controller.login();
                                  if (!status) {
                                    controller.progressBarStatusLogin.value =
                                        false;
                                    showTopSnackBar(
                                      Overlay.of(context)!,
                                      CustomSnackBar.error(
                                        message:
                                            controller.authError.toUpperCase(),
                                      ),
                                      displayDuration: const Duration(
                                        seconds: 3,
                                      ),
                                    );
                                    if (controller.authError
                                        .contains('stage incomplete')) {
                                      Get.to(() => BabyDetails());
                                    }
                                  } else {
                                    controller.progressBarStatusLogin.value =
                                        false;
                                    storage.writeData(
                                        Constants.LOGGED_IN_STATUS, 'yes');
                                    Get.toNamed(Routes.HOME,
                                        arguments: controller.phoneController);
                                  }
                                } else {
                                  showTopSnackBar(
                                    Overlay.of(context)!,
                                    CustomSnackBar.error(
                                      message:
                                          controller.authError.toUpperCase(),
                                    ),
                                    displayDuration: const Duration(
                                      seconds: 3,
                                    ),
                                  );
                                  controller.progressBarStatusLogin.value =
                                      false;
                                }
                              } catch (e) {
                                controller.progressBarStatusLogin.value = false;
                              }
                            }
                          : () {},
                    ),
                    const SizedBox(
                      height: 18,
                    ),
                    Row(
                      children: [
                        Obx(() => Checkbox(
                              checkColor: AppColors.mainColor,
                              fillColor:
                                  MaterialStateProperty.resolveWith(getColor),
                              onChanged: (bool? value) {
                                controller.isChecked.value = value!;
                              },
                              value: controller.isChecked.value,
                            )),
                        Text(
                          "Remember Me",
                          style: Get.textTheme.bodyMedium
                              ?.copyWith(color: DarkTheme.lighter),
                        ),
                        Expanded(
                          child: SizedBox(
                            width: 0.01 * Get.width,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Get.to(() => const ForgetPasswordView(),
                                preventDuplicates: true);
                          },
                          child: Text(
                            "Forgot Password?",
                            style: Get.textTheme.bodyMedium
                                ?.copyWith(color: AppColors.primary500),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: Get.height * 0.12,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
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
                          child: Text(
                            "Don't have an account yet? ",
                            style: Get.textTheme.bodyMedium?.copyWith(
                                color: const Color.fromRGBO(78, 26, 61, 1)),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Get.to(() => const PhoneView(),
                                preventDuplicates: true);
                          },
                          child: Text(
                            "Register",
                            style: kThemeData.textTheme.bodyMedium,
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
            Obx(() => controller.progressBarStatusLogin.value
                ? Center(child: CustomProgressBar())
                : Container())
          ],
        ),
      ),
    );
  }
}
