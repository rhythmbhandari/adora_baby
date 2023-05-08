import 'package:adora_baby/app/config/app_theme.dart';
import 'package:adora_baby/app/modules/auth/views/username_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import '../../../config/app_colors.dart';
import '../../../widgets/awesome_snackbar/custom_snack_bar.dart';
import '../../../widgets/awesome_snackbar/top_snack_bar.dart';
import '../../../widgets/buttons.dart';
import '../../../widgets/custom_progress_bar.dart';
import '../../../widgets/exit_dialog.dart';
import '../../../widgets/stop_watcher.dart';
import '../controllers/auth_controllers.dart';
import 'reset_password_view.dart';

class OtpView extends GetView<AuthController> {
  const OtpView({super.key});

  setMediaType(context) async {
    if (Get.arguments != null) {
      final bool = Get.arguments;
      controller.resetPassword.value = bool;
    }
  }

  @override
  Widget build(BuildContext context) {
    setMediaType(context);
    final StopWatchTimer stopWatchTimer = StopWatchTimer(
      mode: StopWatchMode.countDown,
      presetMillisecond: StopWatchTimer.getMilliSecFromSecond(60),
    );
    stopWatchTimer.onExecute
        .add(StopWatchExecute.reset);
    stopWatchTimer.onExecute
        .add(StopWatchExecute.start);
    return WillPopScope(
      onWillPop: () async {
        if (controller.resetPassword.value) {
          Get.back();
          return true;
        } else {
          await showDialog<bool>(
            context: context,
            builder: (context) {
              return ExitDialog();
            },
          );
          return false;
        }
      },
      child: Scaffold(
        body: SafeArea(
          child: Stack(
            children: [
              SingleChildScrollView(
                child: Column(
                  children: [
                    controller.resetPassword.value
                        ? Container()
                        : const Hero(
                            tag: 'progress',
                            child: LinearProgressIndicator(
                              backgroundColor: Colors.transparent,
                              valueColor:
                                  AlwaysStoppedAnimation(AppColors.primary300),
                              value: 0.45,
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
                              if (controller.resetPassword.value) {
                                Get.back();
                              } else {
                                await showDialog<bool>(
                                  context: context,
                                  builder: (context) {
                                    return ExitDialog();
                                  },
                                );
                              }
                            },
                            child: SvgPicture.asset(
                                "assets/images/arrow-left.svg",
                                height: 22,
                                color: const Color(0xff667080)),
                          ),
                          SizedBox(
                            height: 350,
                            width: double.infinity,
                            child:
                                SvgPicture.asset("assets/images/Group 740.svg"),
                          ),
                          Text(
                            'Enter OTP',
                            style: kThemeData.textTheme.displayMedium,
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Text(
                            'An 6 digit code has been sent to your number, please enter it below.',
                            style: kThemeData.textTheme.bodyLarge,
                          ),
                          const SizedBox(
                            height: 36,
                          ),
                          TextField(
                              controller: controller.otpController,
                              inputFormatters: [
                                LengthLimitingTextInputFormatter(6),
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
                                        color:
                                            DarkTheme.normal.withOpacity(0.7),
                                      ),
                                      borderRadius: BorderRadius.circular(33)),
                                  hintText: 'OTP',
                                  contentPadding: const EdgeInsets.symmetric(
                                      horizontal: 24),
                                  hintStyle: const TextStyle(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 16,
                                      fontFamily: 'Poppins',
                                      color: Color.fromRGBO(178, 187, 198, 1),
                                      letterSpacing: 0.04))),
                          const SizedBox(
                            height: 36,
                          ),
                          ButtonsWidget(
                            name: 'Submit',
                            onPressed: controller.progressBarStatusOtp.value ==
                                    false
                                ? () async {
                                    controller.progressBarStatusOtp.value =
                                        true;
                                    if (controller.resetPassword.value) {
                                      final status = await controller
                                          .verifyResetPassword();
                                      if (!status) {
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
                                        controller.progressBarStatusOtp.value =
                                            false;
                                      } else {
                                        Get.to(() => ResetPasswordView());
                                        controller.progressBarStatusOtp.value =
                                            false;
                                      }
                                    } else {
                                      final status = await controller
                                          .verifyOtpFromServer();

                                      if (!status) {
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
                                        controller.progressBarStatusOtp.value =
                                            false;
                                      } else {
                                        Get.to(() => UsernameView());
                                        controller.progressBarStatusOtp.value =
                                            false;
                                      }
                                    }
                                  }
                                : () {},
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          Center(
                              child: Center(
                                  child: Text('Didnt receive the OTP?',
                                      style: kThemeData.textTheme.bodyLarge))),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              GestureDetector(
                                  onTap: () async {
                                    if (stopWatchTimer.isRunning) {
                                      showTopSnackBar(
                                        Overlay.of(context)!,
                                        CustomSnackBar.info(
                                          message:
                                          'Please wait for 1 minute',
                                        ),
                                        displayDuration: const Duration(
                                          seconds: 3,
                                        ),
                                      );
                                    } else {
                                      stopWatchTimer.onExecute
                                          .add(StopWatchExecute.reset);
                                      stopWatchTimer.onExecute
                                          .add(StopWatchExecute.start);
                                      if (controller.resetPassword.value) {
                                        await controller
                                            .requestResetPassword();
                                        showTopSnackBar(
                                          Overlay.of(context)!,
                                          CustomSnackBar.success(
                                            message:
                                            'Otp sent',
                                          ),
                                          displayDuration: const Duration(
                                            seconds: 3,
                                          ),
                                        );
                                      } else {
                                        await controller
                                            .requestOtpFromServer();
                                        showTopSnackBar(
                                          Overlay.of(context)!,
                                          CustomSnackBar.success(
                                            message:
                                            'Otp sent',
                                          ),
                                          displayDuration: const Duration(
                                            seconds: 3,
                                          ),
                                        );
                                      }
                                    }
                                  },
                                  child: Text(
                                    "Resend ",
                                    style: kThemeData.textTheme.bodyMedium
                                        ?.copyWith(color: AppColors.primary600),
                                  )),
                              StreamBuilder<int>(
                                stream: stopWatchTimer.rawTime,
                                initialData: stopWatchTimer.rawTime.value,
                                builder: (context, snap) {
                                  final value = snap.data!;
                                  final displayTime =
                                      StopWatchTimer.getDisplayTime(value,
                                          minute: true,
                                          hours: false,
                                          milliSecond: false);
                                  return Text(
                                    ' in $displayTime',
                                    style: const TextStyle(
                                        fontSize: 16,
                                        color: Colors.black,
                                        fontFamily: 'lato',
                                        fontWeight: FontWeight.w400),
                                  );
                                },
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              Obx(() => controller.progressBarStatusOtp.value
                  ? CustomProgressBar()
                  : Container())
            ],
          ),
        ),
      ),
    );
  }
}
