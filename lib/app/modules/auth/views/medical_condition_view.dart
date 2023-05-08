import 'package:chips_choice/chips_choice.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
import '../../../../main.dart';
import '../../../config/app_colors.dart';
import '../../../config/app_theme.dart';
import '../../../config/constants.dart';
import '../../../routes/app_pages.dart';
import '../../../widgets/awesome_snackbar/custom_snack_bar.dart';
import '../../../widgets/awesome_snackbar/top_snack_bar.dart';
import '../../../widgets/buttons.dart';
import '../../../widgets/custom_progress_bar.dart';
import '../controllers/auth_controllers.dart';

class MedicalCondition extends StatefulWidget {
  const MedicalCondition({Key? key}) : super(key: key);

  @override
  State<MedicalCondition> createState() => _MedicalConditionState();
}

class _MedicalConditionState extends State<MedicalCondition> {
  final AuthController controller = Get.find();
  List<String> selectedTags = [];

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        storage.writeData(Constants.LOGGED_IN_STATUS, 'yes');
        Get.offNamed(Routes.HOME);
        return false;
      },
      child: Scaffold(
        body: SafeArea(
          child: Stack(
            children: [
              SingleChildScrollView(
                child: Column(
                  children: [
                    const Hero(
                      tag: 'progress',
                      child: LinearProgressIndicator(
                        backgroundColor: Colors.transparent,
                        valueColor:
                            AlwaysStoppedAnimation(AppColors.primary300),
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
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              GestureDetector(
                                onTap: () async {
                                  storage.writeData(
                                      Constants.LOGGED_IN_STATUS, 'yes');
                                  Get.offNamed(Routes.HOME);
                                },
                                child: SvgPicture.asset(
                                    "assets/images/arrow-left.svg",
                                    height: 22,
                                    color: const Color(0xff667080)),
                              ),
                              GestureDetector(
                                onTap: () async {
                                  storage.writeData(
                                      Constants.LOGGED_IN_STATUS, 'yes');
                                  Get.offNamed(Routes.HOME);
                                },
                                child: Text(
                                  'Skip',
                                  style:
                                      kThemeData.textTheme.bodyMedium?.copyWith(
                                    color: const Color.fromRGBO(102, 112, 128, 1),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 28,
                          ),
                          GestureDetector(
                            onTap: () {
                              controller.getMedicalCategories();
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
                          FutureBuilder<List>(
                            future: controller.getMedicalCategories(),
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                if (snapshot.data != null &&
                                    snapshot.data!.isNotEmpty) {
                                  return ListView.builder(
                                      shrinkWrap: true,
                                      physics: const NeverScrollableScrollPhysics(),
                                      itemCount: controller
                                          .babyMedicalCondition.length,
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        return Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                                controller.babyMedicalCondition[
                                                    index][0][0],
                                                style: kThemeData
                                                    .textTheme.titleMedium
                                                    ?.copyWith(
                                                        color: AppColors
                                                            .primary700)),
                                            ChipsChoice<dynamic>.multiple(
                                              value: controller.selectedTags,
                                              onChanged: (val) {
                                                setState(() {});
                                                controller.selectedTags.value =
                                                    val;
                                              },
                                              choiceItems: C2Choice.listFrom<
                                                  String, dynamic>(
                                                source: controller
                                                        .babyMedicalCondition[
                                                    index][2],
                                                value: (i, v) => v,
                                                label: (i, optionsId) =>
                                                    controller
                                                            .babyMedicalCondition[
                                                        index][1][i],
                                                tooltip: (i, v) => v,
                                              ),
                                              choiceStyle: C2ChipStyle.toned(
                                                borderRadius:
                                                    const BorderRadius.all(
                                                  Radius.circular(20),
                                                ),
                                                borderStyle: BorderStyle.solid,
                                                borderWidth: 0.8,
                                                foregroundColor: Colors.green,
                                                foregroundStyle: kThemeData
                                                    .textTheme.bodyLarge
                                                    ?.copyWith(
                                                        color:
                                                            DarkTheme.lighter),
                                                borderColor: DarkTheme.lighter,
                                                backgroundColor: Colors.white,
                                                selectedStyle: C2ChipStyle.filled(
                                                    color: AppColors.primary500,
                                                    foregroundStyle: kThemeData
                                                        .textTheme.bodyLarge
                                                        ?.copyWith(
                                                            color:
                                                                Colors.white)),
                                              ),
                                              choiceCheckmark: false,
                                              textDirection: TextDirection.ltr,
                                              wrapped: true,
                                            ),
                                            const SizedBox(height: 10),
                                          ],
                                        );
                                      });
                                } else {
                                  return Center(
                                    child: Text(
                                      "No Medical Categories Available",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontFamily: 'Graphik',
                                          color: Colors.red.withOpacity(0.67),
                                          letterSpacing: 1.25,
                                          fontWeight: FontWeight.w300),
                                    ),
                                  );
                                }
                              } else if (snapshot.hasError) {
                                return const Center(
                                  child: Text("Sorry,not found!"),
                                );
                              }
                              return _buildImage();
                            },
                          ),
                          const SizedBox(
                            height: 8,
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
                                        color:
                                            DarkTheme.normal.withOpacity(0.7),
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
                                        .progressBarStatusCompleteProfile
                                        .value ==
                                    false
                                ? () async {
                                    controller.progressBarStatusCompleteProfile
                                        .value = true;
                                    final status =
                                        controller.validateMedicalCondition();
                                    if (status) {
                                      final response = await controller
                                          .addMedicalCondition();
                                      if (response) {
                                        controller
                                            .progressBarStatusCompleteProfile
                                            .value = false;
                                        storage.writeData(
                                            Constants.LOGGED_IN_STATUS, 'yes');
                                        Get.offNamed(Routes.HOME);
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
                                        controller
                                            .progressBarStatusCompleteProfile
                                            .value = false;
                                      }
                                    } else {
                                      controller
                                          .progressBarStatusCompleteProfile
                                          .value = false;
                                      storage.writeData(
                                          Constants.LOGGED_IN_STATUS, 'yes');

                                      Get.offNamed(Routes.HOME);
                                    }

                                    // controller.progressBarStatusUsername.value =
                                    //     false;
                                  }
                                : () {},
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Obx(() => controller.progressBarStatusCompleteProfile.value
                  ? GestureDetector(
                      onTap: () {
                        controller.progressBarStatusCompleteProfile.value =
                            false;
                      },
                      child: CustomProgressBar())
                  : Container())
            ],
          ),
        ),
      ),
    );
  }
}

Widget _buildImage() {
  return Shimmer.fromColors(
    baseColor: Colors.white,
    highlightColor: LightTheme.lightActive,
    enabled: true,
    child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 20,
          width: 100,
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(33)),
        ),
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const SizedBox(width: 20),
            Expanded(
              child: Container(
                height: 30,
                width: 100,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(33)),
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            Expanded(
              child: Container(
                height: 30,
                width: 120,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(33)),
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            Expanded(
              child: Container(
                height: 30,
                width: 150,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(33)),
              ),
            ),
            const Expanded(
                child: SizedBox(
              width: 10,
            )),
          ],
        ),
        const SizedBox(height: 16),
        Container(
          height: 20,
          width: 150,
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(33)),
        ),
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const SizedBox(width: 20),
            Expanded(
              child: Container(
                height: 30,
                width: 100,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(33)),
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            Expanded(
              flex: 2,
              child: Container(
                height: 30,
                width: 120,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(33)),
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            Expanded(
              flex: 2,
              child: Container(
                height: 30,
                width: 150,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(33)),
              ),
            ),
            const Expanded(
                child: SizedBox(
              width: 10,
            )),
          ],
        ),
      ],
    ),
  );
}
