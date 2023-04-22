import 'package:adora_baby/app/modules/profile/views/edit_profile_individual/edit_baby_dob.dart';
import 'package:adora_baby/app/modules/profile/views/edit_profile_individual/edit_baby_name.dart';
import 'package:adora_baby/app/modules/profile/views/edit_profile_individual/edit_special_note.dart';
import 'package:adora_baby/app/widgets/buttons.dart';
import 'package:chips_choice/chips_choice.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

import '../../../config/app_colors.dart';
import '../../../config/app_theme.dart';
import '../controllers/profile_controller.dart';
import 'edit_profile_individual/edit_medical_condition.dart';

class EditChildProfile extends StatefulWidget {
  const EditChildProfile({Key? key}) : super(key: key);

  @override
  State<EditChildProfile> createState() => _EditChildProfileState();
}

class _EditChildProfileState extends State<EditChildProfile> {
  final ProfileController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
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
                          "My Child",
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
                Expanded(
                  child: SingleChildScrollView(
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 32,
                      ),
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Baby's Name",
                                  style: kThemeData.textTheme.titleMedium
                                      ?.copyWith(color: DarkTheme.dark),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    Get.to(() => const EditBabyName());
                                  },
                                  child: SvgPicture.asset(
                                    "assets/images/profile_edit.svg",
                                    height: 0.027 * Get.height,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: Get.height * 0.02,
                            ),
                            TextField(
                                controller: controller.babyNameController,
                                // inputFormatters: [
                                //   LengthLimitingTextInputFormatter(6),
                                //   FilteringTextInputFormatter.name
                                // ],
                                enabled: true,
                                readOnly: true,
                                keyboardType: TextInputType.name,
                                cursorColor: AppColors.mainColor,
                                style: kThemeData.textTheme.bodyLarge,
                                decoration: InputDecoration(
                                    hintText: "Fullname",
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(33),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          width: 1,
                                          color:
                                              DarkTheme.normal.withOpacity(0.7),
                                        ),
                                        borderRadius:
                                            BorderRadius.circular(33)),
                                    contentPadding:
                                        const EdgeInsets.symmetric(horizontal: 24),
                                    hintStyle: const TextStyle(
                                        fontWeight: FontWeight.w400,
                                        fontSize: 16,
                                        fontFamily: 'Poppins',
                                        color: Color.fromRGBO(178, 187, 198, 1),
                                        letterSpacing: 0.04))),
                            SizedBox(
                              height: Get.height * 0.04,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Baby's DOB",
                                  style: kThemeData.textTheme.titleMedium
                                      ?.copyWith(color: DarkTheme.dark),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    Get.to(() => const EditBabyDob());
                                  },
                                  child: SvgPicture.asset(
                                    "assets/images/profile_edit.svg",
                                    height: 0.027 * Get.height,
                                  ),
                                ),
                              ],
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
                                decoration: InputDecoration(
                                    hintText: "Date of Birth",
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(33),
                                    ),
                                    suffixIcon: Padding(
                                      padding: const EdgeInsets.all(14),
                                      child: SvgPicture.asset(
                                          "assets/images/calendar.svg",
                                          color: const Color(0xff667080)),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          width: 1,
                                          color:
                                              DarkTheme.normal.withOpacity(0.7),
                                        ),
                                        borderRadius:
                                            BorderRadius.circular(33)),
                                    contentPadding:
                                        const EdgeInsets.symmetric(horizontal: 24),
                                    hintStyle: const TextStyle(
                                        fontWeight: FontWeight.w400,
                                        fontSize: 16,
                                        fontFamily: 'Poppins',
                                        color: Color.fromRGBO(178, 187, 198, 1),
                                        letterSpacing: 0.04))),
                            SizedBox(
                              height: Get.height * 0.04,
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
                                        padding: EdgeInsets.zero,
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
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(
                                                    controller
                                                            .babyMedicalCondition[
                                                        index][0][0],
                                                    style: kThemeData
                                                        .textTheme.titleMedium
                                                        ?.copyWith(
                                                      color: DarkTheme.darkNormal,
                                                    ),
                                                  ),
                                                  GestureDetector(
                                                    onTap: () {
                                                      Get.to(() =>
                                                              const EditMedicalCondition())
                                                          ?.then((value) =>
                                                              setState(() {}));
                                                    },
                                                    child: SvgPicture.asset(
                                                      "assets/images/profile_edit.svg",
                                                      height:
                                                          0.027 * Get.height,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              IgnorePointer(
                                                child: ChipsChoice<
                                                    dynamic>.multiple(
                                                  value:
                                                      controller.selectedTags,
                                                  onChanged: (val) {
                                                    setState(() {});
                                                    controller.selectedTags
                                                        .value = val;
                                                  },
                                                  choiceItems:
                                                      C2Choice.listFrom<String,
                                                          dynamic>(
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
                                                  choiceStyle:
                                                      C2ChipStyle.toned(
                                                    borderRadius:
                                                        const BorderRadius.all(
                                                      Radius.circular(20),
                                                    ),
                                                    borderStyle:
                                                        BorderStyle.solid,
                                                    borderWidth: 0.8,
                                                    foregroundColor:
                                                        Colors.green,
                                                    foregroundStyle: kThemeData
                                                        .textTheme.bodyLarge
                                                        ?.copyWith(
                                                            color: DarkTheme
                                                                .lighter),
                                                    borderColor:
                                                        DarkTheme.lighter,
                                                    backgroundColor:
                                                        Colors.white,
                                                    selectedStyle: C2ChipStyle.filled(
                                                        color: AppColors
                                                            .primary500,
                                                        foregroundStyle:
                                                            kThemeData.textTheme
                                                                .bodyLarge
                                                                ?.copyWith(
                                                                    color: Colors
                                                                        .white)),
                                                  ),
                                                  choiceCheckmark: false,
                                                  textDirection:
                                                      TextDirection.ltr,
                                                  wrapped: true,
                                                ),
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
                                return buildShimmerEdit();
                              },
                            ),
                            SizedBox(
                              height: Get.height * 0.015,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Special Note",
                                  style: kThemeData.textTheme.titleMedium
                                      ?.copyWith(color: DarkTheme.dark),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    Get.to(() => const EditSpecialNotes(),);
                                  },
                                  child: SvgPicture.asset(
                                    "assets/images/profile_edit.svg",
                                    height: 0.027 * Get.height,
                                  ),
                                ),
                              ],
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
                                readOnly: true,
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
                                        borderRadius:
                                            BorderRadius.circular(33)),
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
                  ),
                ),
                Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 32,
                    ),
                    child: ButtonsWidget(
                        name: 'Save',
                        onPressed: () {
                          Get.back();
                        })),
                SizedBox(
                  height: Get.height * 0.06,
                ),
              ],
            )));
  }
}

Widget buildShimmerEdit() {
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
