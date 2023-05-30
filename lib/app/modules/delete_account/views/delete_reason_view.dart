import 'package:adora_baby/app/modules/delete_account/controllers/delete_account_controllers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../config/app_colors.dart';
import '../../../config/app_theme.dart';
import '../../../widgets/awesome_snackbar/custom_snack_bar.dart';
import '../../../widgets/awesome_snackbar/top_snack_bar.dart';
import '../../../widgets/buttons.dart';
import 'delete_confirm_view.dart';

class DeleteReasonView extends GetView<DeleteAccountController> {
  const DeleteReasonView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(left: 32.0, right: 32, top: 30),
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
                Center(
                  child: SvgPicture.asset(
                    "assets/images/delete_reason.svg",
                    height: Get.height * 0.4,
                  ),
                ),
                const SizedBox(
                  height: 40,
                ),
                FittedBox(
                  child: Text('Are you sure?',
                      textAlign: TextAlign.start,
                      style: Get.theme.textTheme.titleMedium?.copyWith(
                          color: DarkTheme.darkNormal,
                          fontFamily: 'PLayfair',
                          fontSize: 35,
                          letterSpacing: -0.02,
                          height: 1.2,
                          fontWeight: FontWeight.w600)),
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                    'We will miss having you around. Let us know why you are leaving so we can improve our service.',
                    textAlign: TextAlign.left,
                    style: Get.theme.textTheme.titleMedium?.copyWith(
                        color: DarkTheme.darkNormal,
                        fontFamily: 'Poppins',
                        fontSize: 16,
                        letterSpacing: -0.02,
                        height: 1.5,
                        fontWeight: FontWeight.w400)),
                const SizedBox(
                  height: 20,
                ),
                TextField(
                  controller: controller.reasonController,
                  inputFormatters: [
                    LengthLimitingTextInputFormatter(255),
                  ],
                  keyboardType: TextInputType.name,
                  cursorColor: AppColors.mainColor,
                  maxLines: 7,
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
                          color: DarkTheme.darkLighter.withOpacity(0.7),
                        ),
                        borderRadius: BorderRadius.circular(33)),
                    hintText: 'Please Mention reason here',
                    contentPadding: const EdgeInsets.symmetric(
                        horizontal: 24, vertical: 14),
                    hintStyle: const TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 16,
                      fontFamily: 'Poppins',
                      color: Color.fromRGBO(178, 187, 198, 1),
                      letterSpacing: 0.04,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                ButtonsWidget(
                    name: 'Send',
                    onPressed: () async {
                      final status = await controller.validateReason();
                      if (!status) {
                        showTopSnackBar(
                          Overlay.of(context),
                          CustomSnackBar.warning(
                            message:
                                '${controller.authError.toUpperCase()}',
                          ),
                          displayDuration: const Duration(
                            seconds: 3,
                          ),
                        );
                      } else {
                        Get.to(() => DeleteConfirmView());
                      }
                    }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
