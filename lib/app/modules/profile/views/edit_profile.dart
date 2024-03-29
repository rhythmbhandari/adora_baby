import 'package:adora_baby/app/widgets/buttons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../config/app_colors.dart';
import '../../../config/app_theme.dart';
import '../../../routes/app_pages.dart';
import '../../../widgets/custom_progress_bar.dart';
import '../../cart/widgets/address_widget.dart';
import '../controllers/profile_controller.dart';
import 'edit_profile_individual/edit_identification.dart';

class EditProfile extends GetView<ProfileController> {
  const EditProfile({Key? key}) : super(key: key);

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
                      Expanded(flex: 2, child: SizedBox()),
                      Container(
                        alignment: Alignment.center,
                        child: Text(
                          "Edit Profile",
                          style: kThemeData.textTheme.displaySmall
                              ?.copyWith(color: DarkTheme.dark),
                        ),
                      ),
                      Expanded(flex: 3, child: SizedBox()),
                    ],
                  ),
                ),
                SizedBox(
                  height: Get.height * 0.03,
                ),
                Container(
                  padding: EdgeInsets.symmetric(
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
                              "Identification",
                              style: kThemeData.textTheme.titleMedium
                                  ?.copyWith(color: DarkTheme.dark),
                            ),
                            GestureDetector(
                              onTap: () {
                                Get.to(
                                  () => const EditIdentification(),
                                );
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
                            controller: controller.fullNameController,
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
                        SizedBox(
                          height: Get.height * 0.04,
                        ),
                        Text(
                          "Contact Information",
                          style: kThemeData.textTheme.titleMedium
                              ?.copyWith(color: DarkTheme.dark),
                        ),
                        SizedBox(
                          height: Get.height * 0.02,
                        ),
                        TextField(
                            controller: controller.contactInformationController,
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
                                hintText: "Primary Phone Number",
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
                        SizedBox(
                          height: Get.height * 0.04,
                        ),
                        Text(
                          "Home Address",
                          style: kThemeData.textTheme.titleMedium
                              ?.copyWith(color: DarkTheme.dark),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Row(
                          // mainAxisSize: MainAxisSize.max,
                          children: [
                            Obx(
                                  () => controller.addressList.isNotEmpty
                                  ? Expanded(
                                flex: 8,
                                child: SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: Row(
                                    children: [
                                      buildAddressWidget(
                                        controller,
                                      )
                                    ],
                                  ),
                                ),
                              )
                                  : Container(),
                            ),
                            Expanded(
                              flex: 3,
                              child: GestureDetector(
                                onTap: () {
                                  Get.toNamed(Routes.ADD_ADDRESS , arguments: [false, 0, true]);
                                },
                                child: Obx(
                                      () => Container(
                                    width: Get.width * 0.25,
                                    padding: EdgeInsets.only(
                                      left: 20,
                                      right: 20,
                                      top: 25,
                                      bottom: controller
                                          .addressList.isNotEmpty
                                          ? 25
                                          : 0,
                                    ),
                                    margin: EdgeInsets.only(
                                      top: controller
                                          .addressList.isNotEmpty
                                          ? 0
                                          : 15,
                                      bottom: controller
                                          .addressList.isNotEmpty
                                          ? 0
                                          : 25,
                                    ),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      border: Border.all(
                                          color: const Color.fromRGBO(
                                              192, 144, 254, 0.25)),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey.withOpacity(0.3),
                                          spreadRadius: 1,
                                          blurRadius: 1,
                                          offset: Offset(0,
                                              2), // changes position of shadow
                                        ),
                                      ],
                                      borderRadius: BorderRadius.circular(
                                        20,
                                      ),
                                    ),
                                    child: Column(
                                      children: [
                                        Image.asset(
                                            "assets/images/location-add.png"),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Text("Add New Address" + '\n',
                                            textAlign: TextAlign.center,
                                            maxLines: 2,
                                            style: kThemeData
                                                .textTheme.bodyMedium
                                                ?.copyWith(
                                                color: DarkTheme
                                                    .darkLightActive)),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ]),
                ),
                Expanded(child: Container()),
                Container(
                    padding: EdgeInsets.symmetric(
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
