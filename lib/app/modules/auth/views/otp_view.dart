import 'package:adora_baby/app/config/app_theme.dart';
import 'package:adora_baby/app/modules/auth/views/username_view.dart';
import 'package:adora_baby/app/routes/app_pages.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../../widgets/buttons.dart';
import '../../../../widgets/custom_progress_bar.dart';
import '../../../../widgets/stop_watcher.dart';
import '../../../config/app_colors.dart';
import '../controllers/auth_controllers.dart';

class OtpView extends GetView<AuthController> {
  const OtpView({super.key});

  @override
  Widget build(BuildContext context) {
    final StopWatchTimer stopWatchTimer = StopWatchTimer(
      mode: StopWatchMode.countDown,
      presetMillisecond: StopWatchTimer.getMilliSecFromSecond(60),
    );
    TextEditingController otpController = TextEditingController();
    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          children: [
            SafeArea(
              child: Column(
                children: [
                  Hero(
                    tag: 'progress',
                    child: LinearProgressIndicator(
                      backgroundColor: Colors.transparent,
                      valueColor: AlwaysStoppedAnimation(AppColors.primary300),
                      value: 0.45,
                      minHeight: 7,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 32.0, right: 32, top: 12),
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
                        SizedBox(
                          height: 350,
                          width: double.infinity,
                          child: SvgPicture.asset("assets/images/Group 740.svg"),
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
                        Container(
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey.shade300, width: 2),
                              borderRadius: BorderRadius.circular(20)),
                          child: TextField(
                              controller: controller.otpController,
                              inputFormatters: [
                                LengthLimitingTextInputFormatter(6),
                                FilteringTextInputFormatter.digitsOnly
                              ],
                              keyboardType: TextInputType.number,
                              cursorColor: AppColors.mainColor,
                              style: kThemeData.textTheme.bodyLarge,
                              decoration: const InputDecoration(
                                  border: InputBorder.none,
                                  hintText: 'OTP',
                                  contentPadding: EdgeInsets.symmetric(horizontal: 24),
                                  hintStyle: TextStyle(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 16,
                                      fontFamily: 'Poppins',
                                      color: Color.fromRGBO(178, 187, 198, 1),
                                      letterSpacing: 0.04))),
                        ),
                        const SizedBox(
                          height: 36,
                        ),
                        ButtonsWidget(
                          name: 'Submit',
                          onPressed:controller.progressBarStatusOtp.value == false? () async {
                            controller.progressBarStatusOtp.value = true;
                            final status = await controller.verifyOtpController();
                            if (!status) {
                              var snackBar = const SnackBar(
                                elevation: 0,
                                behavior: SnackBarBehavior.floating,
                                backgroundColor: Colors.red,
                                duration: Duration(milliseconds: 2000),
                                content: Text("Failed"),
                              );
                              ScaffoldMessenger.of(context).showSnackBar(snackBar);
                              controller.progressBarStatusOtp.value = false;
                            } else {
                              Get.to(const UsernameView());
                              controller.progressBarStatusOtp.value = false;
                            }
                          }: (){

                          },
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
                                onTap: () {
                                  if (stopWatchTimer.isRunning) {
                                    var snackBar = SnackBar(
                                      elevation: 0,
                                      behavior: SnackBarBehavior.fixed,
                                      backgroundColor: AppColors.mainColor,
                                      duration: const Duration(milliseconds: 2000),
                                      content: const Text('Please wait for 1 minute'),
                                      margin: EdgeInsets.only(
                                          top:
                                              MediaQuery.of(context).size.height - 180),
                                    );
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(snackBar);
                                  } else {
                                    stopWatchTimer.onExecute
                                        .add(StopWatchExecute.reset);
                                    stopWatchTimer.onExecute
                                        .add(StopWatchExecute.start);
                                  }
                                },
                                child: Text(
                                  "Resend ",
                                  style: kThemeData.textTheme.bodyMedium?.copyWith(color: AppColors.primary600),
                                )),
                            StreamBuilder<int>(
                              stream: stopWatchTimer.rawTime,
                              initialData: stopWatchTimer.rawTime.value,
                              builder: (context, snap) {
                                final value = snap.data!;
                                final displayTime = StopWatchTimer.getDisplayTime(value,
                                    minute: true, hours: false, milliSecond: false);
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
    );
  }
}
