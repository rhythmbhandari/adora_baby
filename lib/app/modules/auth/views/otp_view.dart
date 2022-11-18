import 'package:adora_baby/app/config/app_theme.dart';
import 'package:adora_baby/app/routes/app_pages.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../../widgets/buttons.dart';
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
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(left: 32.0, right: 32, top: 30),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 350,
                  width: double.infinity,
                  child: SvgPicture.asset("assets/images/Group 740.svg"),
                ),
                Text(
                  'Enter OTP',
                  style:  kThemeData.textTheme.displayMedium,
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  'An 4 digit code has been sent to your number, please enter it below.',
                  style: kThemeData.textTheme.bodyLarge,
                ),
                const SizedBox(
                  height: 36,
                ),
                Container(
                  decoration: BoxDecoration(
                    border:  Border.all(color: Colors.grey.shade300,width: 2) ,

                    borderRadius: BorderRadius.circular(20)),
                  child: TextField(
                      inputFormatters: [
                        LengthLimitingTextInputFormatter(4),
                      ],
                      keyboardType: TextInputType.number,
                      cursorColor: AppColors.mainColor,
                      decoration: const InputDecoration(
                          border: InputBorder.none,

                          hintText: 'OTP',
                          contentPadding: EdgeInsets.symmetric(horizontal: 10),
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
                  onPressed: () {
                    if (kDebugMode) {
                      print('abc');
                      Get.offAllNamed(Routes.HOME);


                    }
                  },
                ),
                const SizedBox(
                  height: 30,
                ),
                Center(
                    child: Center(
                        child: Text(
                  'Didnt receive the OTP?',
                  style: kThemeData.textTheme.bodyLarge
                ))),
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
                          "RESEND ",
                          style: kThemeData.textTheme.bodyMedium,
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
        ),
      ),
    );
  }
}
