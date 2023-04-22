
import 'package:adora_baby/app/widgets/buttons.dart';
import 'package:chips_choice/chips_choice.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../config/app_colors.dart';
import '../../../../config/app_theme.dart';
import '../../../../widgets/custom_progress_bar.dart';
import '../../controllers/profile_controller.dart';
import '../edit_child_profile.dart';

class EditMedicalCondition extends StatefulWidget {
  const EditMedicalCondition({Key? key}) : super(key: key);

  @override
  State<EditMedicalCondition> createState() => _EditMedicalConditionState();
}

class _EditMedicalConditionState extends State<EditMedicalCondition> {
  final ProfileController controller = Get.find();

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
                      child: FutureBuilder<List>(
                        future: controller.getMedicalCategories(),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            if (snapshot.data != null &&
                                snapshot.data!.isNotEmpty) {
                              return ListView.builder(
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  padding: EdgeInsets.zero,
                                  itemCount:
                                      controller.babyMedicalCondition.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          controller.babyMedicalCondition[index]
                                              [0][0],
                                          style: kThemeData
                                              .textTheme.titleMedium
                                              ?.copyWith(
                                            color: DarkTheme.darkNormal,
                                          ),
                                        ),
                                        ChipsChoice<dynamic>.multiple(
                                          value: controller.selectedTags,
                                          onChanged: (val) {
                                            setState(() {});
                                            controller.selectedTags.value = val;
                                          },
                                          choiceItems: C2Choice.listFrom<String,
                                              dynamic>(
                                            source: controller
                                                .babyMedicalCondition[index][2],
                                            value: (i, v) => v,
                                            label: (i, optionsId) => controller
                                                    .babyMedicalCondition[index]
                                                [1][i],
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
                                                    color: DarkTheme.lighter),
                                            borderColor: DarkTheme.lighter,
                                            backgroundColor: Colors.white,
                                            selectedStyle: C2ChipStyle.filled(
                                                color: AppColors.primary500,
                                                foregroundStyle: kThemeData
                                                    .textTheme.bodyLarge
                                                    ?.copyWith(
                                                        color: Colors.white)),
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
                          return buildShimmerEdit();
                        },
                      ),
                    ),
                    Expanded(child: Container()),
                    Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 32,
                        ),
                        child: ButtonsWidget(
                            name: 'Save',
                            onPressed: () async {
                              final status = await controller.addMedicalCondition();
                              if (status) {
                                var snackBar = const SnackBar(
                                  elevation: 0,
                                  behavior: SnackBarBehavior.floating,
                                  backgroundColor: AppColors.success500,
                                  duration: Duration(milliseconds: 2000),
                                  content: Text("Successfully updated."),
                                );
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(snackBar);
                                Get.back();
                              } else {
                                var snackBar = SnackBar(
                                  elevation: 0,
                                  behavior: SnackBarBehavior.floating,
                                  backgroundColor: AppColors.error500,
                                  duration: const Duration(milliseconds: 2000),
                                  content: Text(
                                      controller.authError.toUpperCase()),
                                );
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(snackBar);
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
