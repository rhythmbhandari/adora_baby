import 'package:adora_baby/app/config/app_theme.dart';
import 'package:adora_baby/app/modules/auth/views/medical_condition_view.dart';
import 'package:adora_baby/app/modules/auth/views/username_view.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../config/app_colors.dart';
import '../../../widgets/buttons.dart';
import '../../../widgets/custom_progress_bar.dart';
import '../controllers/auth_controllers.dart';

class BabyDetails extends GetView<AuthController> {
  BabyDetails({Key? key}) : super(key: key);
  final FocusNode dobNode = FocusNode();

  @override
  Widget build(BuildContext context) {
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
                      value: 0.85,
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
                              color: Color(0xff667080)),
                        ),
                        const SizedBox(
                          height: 13,
                        ),
                        Text(
                          "Your Baby’s Detail",
                          style: kThemeData.textTheme.displayMedium,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Text(
                          'We need this information to better understand your baby’s need and give custom recommendations.',
                          style: kThemeData.textTheme.bodyLarge,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        SizedBox(
                          height: 282,
                          width: double.infinity,
                          child: SvgPicture.asset(
                              "assets/images/breastfeeding-mother.svg"),
                        ),
                        const SizedBox(
                          height: 40,
                        ),
                        TextField(
                            controller: controller.babyNameController,
                            // inputFormatters: [
                            //   LengthLimitingTextInputFormatter(6),
                            //   FilteringTextInputFormatter.name
                            // ],
                            keyboardType: TextInputType.name,
                            cursorColor: AppColors.mainColor,
                            style: kThemeData.textTheme.bodyLarge,
                            decoration: InputDecoration(
                                hintText: "Baby's Name",
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(33),
                                ),
                                focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      width: 1,
                                      color: DarkTheme.normal.withOpacity(0.7),
                                    ),
                                    borderRadius: BorderRadius.circular(33)),
                                contentPadding:
                                    EdgeInsets.symmetric(horizontal: 24),
                                hintStyle: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 16,
                                    fontFamily: 'Poppins',
                                    color: Color.fromRGBO(178, 187, 198, 1),
                                    letterSpacing: 0.04))),
                        const SizedBox(
                          height: 20,
                        ),
                        TextField(
                            keyboardType: TextInputType.datetime,
                            controller: controller.dobController,
                            focusNode: dobNode,
                            autofocus: false,
                            readOnly: true,
                            style: kThemeData.textTheme.bodyLarge,
                            onTap: () {
                              DatePicker.showDatePicker(
                                context,
                                theme: DatePickerTheme(
                                  cancelStyle: Get.textTheme.bodyMedium!
                                      .copyWith(color: AppColors.error500),
                                  doneStyle: Get.textTheme.bodyMedium!
                                      .copyWith(color: AppColors.success500),
                                  containerHeight: Get.height * 0.2,
                                  itemHeight: 40,
                                  itemStyle: Get.textTheme.bodyMedium!
                                      .copyWith(color: Colors.black),
                                ),
                                showTitleActions: true,
                                maxTime: DateTime.now(),
                                minTime: DateTime.now()
                                    .subtract(Duration(days: 365 * 18)),
                                onConfirm: (date) {
                                  String formattedDate =
                                      DateFormat('yyyy-MM-dd').format(date);
                                  controller.dobController.text = formattedDate;
                                  controller.setDate(
                                      controller.dobController.text.toString());
                                },
                                currentTime: DateTime.now(),
                              );
                            },
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.symmetric(
                                  horizontal: 24, vertical: 12),
                              hintStyle: Get.textTheme.bodyLarge?.copyWith(
                                  color: Color.fromRGBO(178, 187, 198, 1)),
                              labelStyle: Get.textTheme.bodyLarge?.copyWith(
                                  color: Color.fromRGBO(178, 187, 198, 1)),
                              // floatingLabelBehavior: FloatingLabelBehavior
                              //     .never,
                              hintText: "Date of Birth",
                              suffix: SvgPicture.asset(
                                  "assets/images/calendar.svg",
                                  fit: BoxFit.contain,
                                  height: 20,
                                  color: DarkTheme.dark),
                              focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    width: 1,
                                    color: DarkTheme.normal.withOpacity(0.7),
                                  ),
                                  borderRadius: BorderRadius.circular(33)),
                              border: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Color(0xff828282)),
                                borderRadius: BorderRadius.circular(33),
                              ),
                              disabledBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Color(0xff828282)),
                                borderRadius: BorderRadius.circular(33),
                              ),
                            )),
                        const SizedBox(
                          height: 36,
                        ),
                        ButtonsWidget(
                          name: 'Submit',
                          onPressed: controller.progressBarBabyDetail.value ==
                                  false
                              ? () async {
                                  controller.progressBarBabyDetail.value = true;
                                  final status =
                                      await controller.validateBabyDetail();
                                  if (!status) {
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
                                    controller.progressBarBabyDetail.value =
                                        false;
                                  } else {
                                    final status =
                                        await controller.getMedicalCategories();
                                    if (status) {
                                      Get.to(MedicalCondition());
                                    } else {
                                      var snackBar = SnackBar(
                                        elevation: 0,
                                        behavior: SnackBarBehavior.floating,
                                        backgroundColor: Colors.red,
                                        duration: Duration(milliseconds: 2000),
                                        content: Text("Please try again!"),
                                      );
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(snackBar);
                                    }
                                    controller.progressBarBabyDetail.value =
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
            Obx(() => controller.progressBarStatusOtp.value
                ? CustomProgressBar()
                : Container())
          ],
        ),
      ),
    );
  }
}
