import 'package:adora_baby/app/modules/auth/views/baby_detail_view.dart';
import 'package:adora_baby/app/modules/home/views/home_view.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../config/app_colors.dart';
import '../../../config/app_theme.dart';
import '../../../widgets/buttons.dart';
import '../../../widgets/custom_progress_bar.dart';
import '../../../widgets/filter_chip.dart';
import '../controllers/auth_controllers.dart';

class MedicalCondition extends GetView<AuthController> {
  const MedicalCondition({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                      value: 1,
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
                          onTap: () {
                            Get.back();
                          },
                          child: SvgPicture.asset(
                              "assets/images/arrow-left.svg",
                              height: 22,
                              color: const Color(0xff667080)),
                        ),
                        const SizedBox(
                          height: 28,
                        ),
                        GestureDetector(
                          onTap: () {
                            controller.getMedicalCategories();
                            if (kDebugMode) {
                              print('Started');
                            }
                          },
                          child: Text(
                            'Baby’s Medical Condition',
                            style: kThemeData.textTheme.displayMedium,
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Text(
                          'Select all that applies. You can always change your answer from Profile.',
                          style: kThemeData.textTheme.bodyLarge,
                        ),

                        const SizedBox(
                          height: 32,
                        ),
                        Text(
                          'Allergies',
                          style: kThemeData.textTheme.titleMedium
                              ?.copyWith(color: AppColors.primary700),
                        ),
                        const SizedBox(
                          height: 10,
                        ),

                        Wrap(
                            spacing: 5.0,
                            runSpacing: 5.0,
                            direction: Axis.horizontal,
                            children: <Widget>[
                              for (int i = 0;
                                  i < controller.chipList.length;
                                  i++)
                                Obx(() => FilterChipWidget(
                                      chipName: controller.chipList[i],
                                      chipType: '1',
                                      index: i,
                                    )),
                            ]),
                        const SizedBox(
                          height: 16,
                        ),
                        // Wrap(
                        //     spacing: 5.0,
                        //     runSpacing: 5.0,
                        //     direction: Axis.horizontal,
                        //     children: <Widget>[
                        //       for (int i = 0;
                        //       i < controller.chipList.length;
                        //       i++)
                        //         Obx(() => FilterChipWidget(
                        //           chipName: controller.chipList[i],
                        //           index: i,
                        //         )),
                        //     ]),
                        Text(
                          'Frequent Difficulties',
                          style: kThemeData.textTheme.titleMedium
                              ?.copyWith(color: AppColors.primary700),
                        ),
                        const SizedBox(
                          height: 10,
                        ),

                        Wrap(
                            spacing: 5.0,
                            runSpacing: 5.0,
                            direction: Axis.horizontal,
                            children: <Widget>[
                              for (int i = 0;
                              i < controller.chipList1.length;
                              i++)
                                Obx(() => FilterChipWidget(
                                  chipName: controller.chipList1[i],
                                  chipType: '2',
                                  index: i,
                                )),
                            ]),
                        const SizedBox(
                          height: 16,
                        ),
                        Text(
                          'Special Note',
                          style: kThemeData.textTheme.titleMedium
                              ?.copyWith(color: AppColors.primary700),
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        TextField(
                            controller: controller.specialNoteController,
                            // inputFormatters: [
                            //   LengthLimitingTextInputFormatter(6),
                            //   FilteringTextInputFormatter.digitsOnly
                            // ],
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
                                      color: DarkTheme.normal.withOpacity(0.7),
                                    ),
                                    borderRadius: BorderRadius.circular(33)),
                                hintText:
                                    'Type anything specific to your child...',
                                contentPadding: const EdgeInsets.symmetric(
                                    horizontal: 24, vertical: 14),
                                hintStyle: const TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 16,
                                    fontFamily: 'Poppins',
                                    color: Color.fromRGBO(178, 187, 198, 1),
                                    letterSpacing: 0.04))),
                        const SizedBox(
                          height: 24,
                        ),
                        ButtonsWidget(
                          name: 'Complete Profile',
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
                                      duration: const Duration(milliseconds: 2000),
                                      content: Text("${controller.authError}"),
                                    );
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(snackBar);
                                    controller.progressBarStatusUsername.value =
                                        false;
                                  } else {
                                    Get.to(const HomeView());
                                    controller.progressBarStatusUsername.value =
                                        false;
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
    );
  }
}
