import 'dart:convert';

import 'package:adora_baby/app/widgets/buttons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../../config/app_colors.dart';
import '../../../../config/app_theme.dart';
import '../../../../widgets/awesome_snackbar/custom_snack_bar.dart';
import '../../../../widgets/awesome_snackbar/top_snack_bar.dart';
import '../../../../widgets/custom_progress_bar.dart';
import '../../controllers/profile_controller.dart';

class EditBabyDob extends GetView<ProfileController> {
  const EditBabyDob({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Get.back();

        Get.back();
        return false;
      },
      child: Scaffold(
          backgroundColor: Colors.white,
          body: Stack(
            children: [
              SafeArea(
                  bottom: false,
                  child: Column(
                    children: [
                      Container(
                        width: double.infinity,
                        height: 88,
                        color: Colors.white,
                        child: Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 30.0),
                              child: GestureDetector(
                                  onTap: () {
                                    // controller.selectedStages.value = 10;
                                    // controller.selectedFilter.value = 0;
                                    // controller.searchController.text = "";
                                    Get.back();
                                  },
                                  child: const Icon(
                                    Icons.arrow_back_ios,
                                    color: Colors.black,
                                  )),
                            ),
                            const Expanded(flex: 2, child: SizedBox()),
                            Container(
                              alignment: Alignment.center,
                              child: Text(
                                "Edit Profile",
                                style: kThemeData.textTheme.displaySmall
                                    ?.copyWith(color: DarkTheme.dark),
                              ),
                            ),
                            const Expanded(flex: 3, child: SizedBox()),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: Get.height * 0.03,
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 32,
                        ),
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Baby's DOB",
                                style: kThemeData.textTheme.titleMedium
                                    ?.copyWith(color: DarkTheme.dark),
                              ),
                              SizedBox(
                                height: Get.height * 0.02,
                              ),
                              TextField(
                                  controller: controller.babyDobController,
                                  // inputFormatters: [
                                  //   LengthLimitingTextInputFormatter(6),
                                  //   FilteringTextInputFormatter.name
                                  // ],
                                  enabled: true,
                                  readOnly: true,
                                  keyboardType: TextInputType.name,
                                  cursorColor: AppColors.mainColor,
                                  style: kThemeData.textTheme.bodyLarge,
                                  onTap: () {
                                    DatePicker.showDatePicker(
                                      context,
                                      theme: DatePickerTheme(
                                        cancelStyle: Get.textTheme.bodyMedium!
                                            .copyWith(
                                                color: AppColors.error500),
                                        doneStyle: Get.textTheme.bodyMedium!
                                            .copyWith(
                                                color: AppColors.success500),
                                        containerHeight: Get.height * 0.2,
                                        itemHeight: 40,
                                        itemStyle: Get.textTheme.bodyMedium!
                                            .copyWith(color: Colors.black),
                                      ),
                                      showTitleActions: true,
                                      maxTime: DateTime.now(),
                                      minTime: DateTime.now()
                                          .subtract(const Duration(days: 365 * 18)),
                                      onConfirm: (date) {
                                        String formattedDate =
                                            DateFormat('yyyy-MM-dd')
                                                .format(date);
                                        controller.babyDobController.text =
                                            formattedDate;
                                        controller.setDate(controller
                                            .babyDobController.text
                                            .toString());
                                      },
                                      currentTime:
                                          controller.user.value.babyDob ??
                                              DateTime.now(),
                                    );
                                  },
                                  decoration: InputDecoration(
                                      hintText: "Baby's name",
                                      border: OutlineInputBorder(
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
                                      suffixIcon: Padding(
                                        padding: const EdgeInsets.all(14),
                                        child: SvgPicture.asset(
                                            "assets/images/calendar.svg",
                                            color: const Color(0xff667080)),
                                      ),
                                      contentPadding:
                                          const EdgeInsets.symmetric(horizontal: 24),
                                      hintStyle: const TextStyle(
                                          fontWeight: FontWeight.w400,
                                          fontSize: 16,
                                          fontFamily: 'Poppins',
                                          color:
                                              Color.fromRGBO(178, 187, 198, 1),
                                          letterSpacing: 0.04))),
                              SizedBox(
                                height: Get.height * 0.04,
                              ),
                            ]),
                      ),
                      Expanded(child: Container()),
                      Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 32,
                          ),
                          child: ButtonsWidget(
                              name: 'Save',
                              onPressed: () async {
                                if (controller.babyDobController.text
                                        .trim()
                                        .length >
                                    3) {
                                  final status = await controller.editProfile(
                                      jsonEncode({
                                    'baby_dob':
                                        controller.babyDobController.text.trim()
                                  }));
                                  if (status) {
                                    showTopSnackBar(
                                      Overlay.of(context)!,
                                      CustomSnackBar.success(
                                        message:
                                        'Successfully updated.',
                                      ),
                                      displayDuration: const Duration(
                                        seconds: 3,
                                      ),
                                    );
                                    Get.back();
                                    Get.back();
                                  } else {
                                    showTopSnackBar(
                                      Overlay.of(context)!,
                                      CustomSnackBar.error(
                                        message:
                                        '${controller.authError.toUpperCase()}',
                                      ),
                                      displayDuration: const Duration(
                                        seconds: 3,
                                      ),
                                    );
                                  }
                                } else {
                                  showTopSnackBar(
                                    Overlay.of(context)!,
                                    CustomSnackBar.warning(
                                      message:
                                      'Please select date of birth.',
                                    ),
                                    displayDuration: const Duration(
                                      seconds: 3,
                                    ),
                                  );
                                }
                              })),
                      SizedBox(
                        height: Get.height * 0.06,
                      ),
                    ],
                  )),
              Obx(() => controller.progressBarStatus.value
                  ? Center(child: CustomProgressBar())
                  : Container())
            ],
          )),
    );
  }
}
