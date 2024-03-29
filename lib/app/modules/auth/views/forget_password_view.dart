import 'package:adora_baby/app/config/app_theme.dart';
import 'package:adora_baby/app/modules/auth/views/login_view.dart';
import 'package:adora_baby/app/modules/auth/views/reset_password_view.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import '../../../config/app_colors.dart';
import '../../../routes/app_pages.dart';
import '../../../widgets/buttons.dart';
import '../../../widgets/custom_progress_bar.dart';
import '../controllers/auth_controllers.dart';

class ForgetPasswordView extends GetView<AuthController> {
  const ForgetPasswordView({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController phoneController = TextEditingController();
    return Scaffold(
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
                      onTap: () {
                        Get.back();
                      },
                      child: SvgPicture.asset("assets/images/arrow-left.svg",
                          height: 22, color: Color(0xff667080)),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                      height: 312,
                      width: double.infinity,
                      child: SvgPicture.asset("assets/images/forget_password_svg.svg"),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Text('Forgot Password?',
                        style: kThemeData.textTheme.displayMedium),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                        'Happens to the best of us. Just enter your phone number to retreive it.',
                        // textAlign: TextAlign.justify,
                        style: kThemeData.textTheme.bodyLarge),
                    const SizedBox(
                      height: 20,
                    ),
                    TextField(
                        controller: controller.phoneController,
                        inputFormatters: [
                          LengthLimitingTextInputFormatter(10),
                          FilteringTextInputFormatter.digitsOnly
                        ],
                        keyboardType: TextInputType.number,
                        cursorColor: AppColors.mainColor,
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
                            contentPadding: const EdgeInsets.symmetric(
                                horizontal: 24),
                            hintStyle: const TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 16,
                                fontFamily: 'Poppins',
                                color: Color.fromRGBO(178, 187, 198, 1),
                                letterSpacing: 0.04))),
                    const SizedBox(
                      height: 30,
                    ),
                    ButtonsWidget(
                      name: 'Submit',
                      onPressed: controller.progressBarStatus.value == false
                          ? () async {
                        try {
                          controller.progressBarStatus.value = true;
                          if (await controller
                              .validatePhoneNumber()) {
                            final status = await controller
                                .requestResetPassword();
                            if (!status) {
                              controller.progressBarStatus.value =
                              false;
                              var snackBar = SnackBar(
                                elevation: 0,
                                behavior: SnackBarBehavior.floating,
                                backgroundColor: Colors.red,
                                duration:
                                Duration(milliseconds: 2000),
                                content: Text(
                                    "${controller.authError.toUpperCase()}"),
                              );
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(snackBar);
                            } else {
                              if (kDebugMode) {
                                print("success");
                              }
                              controller.progressBarStatus.value =
                              false;
                              Get.toNamed(Routes.OTP,
                                  arguments:true);
                            }
                          } else {
                            var snackBar = SnackBar(
                              elevation: 0,
                              behavior: SnackBarBehavior.floating,
                              backgroundColor: Colors.red,
                              duration: Duration(milliseconds: 2000),
                              content:
                              Text("${controller.authError}"),
                            );
                            ScaffoldMessenger.of(context)
                                .showSnackBar(snackBar);
                            controller.progressBarStatus.value =
                            false;
                          }
                        } catch (e) {
                          controller.progressBarStatus.value = false;
                        }
                      }
                          : () {},
                    ),
                  ],
                ),
              ),
            ),

            Obx(() => controller.progressBarStatus.value
                ? Center(child: CustomProgressBar())
                : Container())
          ],
        ),
      ),
    );
  }
}
