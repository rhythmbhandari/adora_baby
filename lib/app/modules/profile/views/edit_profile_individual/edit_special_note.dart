import 'dart:convert';

import 'package:adora_baby/app/widgets/buttons.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../config/app_colors.dart';
import '../../../../config/app_theme.dart';
import '../../../../widgets/awesome_snackbar/custom_snack_bar.dart';
import '../../../../widgets/awesome_snackbar/top_snack_bar.dart';
import '../../../../widgets/custom_progress_bar.dart';
import '../../controllers/profile_controller.dart';

class EditSpecialNotes extends GetView<ProfileController> {
  const EditSpecialNotes({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                              "Special Note",
                              style: kThemeData.textTheme.titleMedium
                                  ?.copyWith(color: DarkTheme.dark),
                            ),
                            SizedBox(
                              height: Get.height * 0.02,
                            ),

                            TextField(
                                controller: controller.specialNoteController,
                                // inputFormatters: [
                                //   LengthLimitingTextInputFormatter(6),
                                //   FilteringTextInputFormatter.digitsOnly
                                // ],
                                enabled: true,
                                readOnly: false,
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
                              if (controller.specialNoteController.text
                                  .trim()
                                  .length >
                                  3) {
                                final status = await controller.editProfile(
                                    jsonEncode({
                                      'special_note':
                                      controller.specialNoteController.text.trim()
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
                                  CustomSnackBar.info(
                                    message:
                                    'Please enter special note.',
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
        ));
  }
}
