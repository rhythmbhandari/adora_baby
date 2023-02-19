import 'package:adora_baby/app/data/repositories/checkout_repositories.dart';
import 'package:adora_baby/app/modules/cart/controllers/cart_controller.dart';
import 'package:adora_baby/app/modules/shop/widgets/auth_progress_indicator.dart';
import 'package:adora_baby/app/widgets/buttons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:get/get.dart';

import '../../../config/app_colors.dart';
import '../../../config/app_theme.dart';
import '../../../data/models/get_address_model.dart';
import '../../../widgets/cities_dropdown.dart';

class AddAddressView extends GetView<CartController> {
  const AddAddressView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return progressWrap(
        Scaffold(
          backgroundColor: LightTheme.white,
          body: SingleChildScrollView(
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.only(left: 32.0, right: 32),
                child: Stack(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: EdgeInsets.only(
                            bottom: Get.height * 0.02,
                            top: Get.height * 0.01,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              GestureDetector(
                                  onTap: () {
                                    Get.back();
                                  },
                                  child: const Icon(
                                    Icons.arrow_back_ios,
                                    color: Colors.black,
                                  )),
                              Expanded(
                                child: Container(),
                              ),
                              Text(
                                "Address",
                                style: kThemeData.textTheme.displaySmall,
                              ),
                              Expanded(
                                child: Container(),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        TextField(
                            controller: controller.addNameController,
                            cursorColor: AppColors.mainColor,
                            style: kThemeData.textTheme.bodyLarge?.copyWith(
                                color: DarkTheme.normal.withOpacity(0.7)),
                            decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(33),
                                ),
                                contentPadding: EdgeInsets.symmetric(
                                  horizontal: 24,
                                  vertical: 20,
                                ),
                                focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      width: 1,
                                      color: DarkTheme.normal.withOpacity(0.7),
                                    ),
                                    borderRadius: BorderRadius.circular(33)),
                                hintText: 'Address Name',
                                hintStyle: const TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 16,
                                    fontFamily: 'Poppins',
                                    color: Color.fromRGBO(178, 187, 198, 1),
                                    letterSpacing: 0.04))),
                        const SizedBox(
                          height: 20,
                        ),
                        Obx(() => AddressDropDown(
                            onChanged: (value) {
                              // pController.updateProvince(value!);
                            },
                            label: "City",
                            isAddressSelected: true,
                            value: controller.selectedCity.value,
                            addressList: controller.citiesList)),
                        const SizedBox(
                          height: 20,
                        ),
                        TextField(
                            controller: controller.landMarkController,
                            cursorColor: AppColors.mainColor,
                            style: kThemeData.textTheme.bodyLarge?.copyWith(
                                color: DarkTheme.normal.withOpacity(0.7)),
                            decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(33),
                                ),
                                contentPadding: EdgeInsets.symmetric(
                                  horizontal: 24,
                                  vertical: 20,
                                ),
                                focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      width: 1,
                                      color: DarkTheme.normal.withOpacity(0.7),
                                    ),
                                    borderRadius: BorderRadius.circular(33)),
                                hintText: 'Nearest Landmark',
                                hintStyle: const TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 16,
                                    fontFamily: 'Poppins',
                                    color: Color.fromRGBO(178, 187, 198, 1),
                                    letterSpacing: 0.04))),
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Set as Primary Address",
                                style:
                                    kThemeData.textTheme.titleMedium?.copyWith(
                                  color: AppColors.secondary500,
                                )),
                            Obx(() => Card(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(50.0),
                                    side: BorderSide(
                                        color: Color.fromRGBO(0, 0, 0, 1),
                                        // strokeAlign: StrokeAlign.inside,
                                    ),
                                  ),
                                  borderOnForeground: false,
                                  elevation: 3,
                                  child: FlutterSwitch(
                                    activeColor: AppColors.secondary500,
                                    inactiveColor: LightTheme.lightNormalActive,
                                    width: 70.0,
                                    height: 35.0,
                                    valueFontSize: 25.0,
                                    toggleSize: 32.0,
                                    value: controller.isPrimaryAddAddress.value,
                                    borderRadius: 50,
                                    padding: 0.0,
                                    showOnOff: false,
                                    onToggle: (val) {
                                      controller.isPrimaryAddAddress.value =
                                          val;
                                    },
                                  ),
                                )),
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                      ],
                    ),
                    Container(
                      height: Get.height,
                    ),
                    Positioned(
                      bottom: 20,
                      right: 0,
                      left: 0,
                      child: ButtonsWidget(
                          name: "Save Address",
                          onPressed: () async {
                            try {
                              controller.showLoading(
                                  controller.progressBarStatusAddAddress);
                              final status = await controller.validateAddress();
                              if (status) {
                                controller.completeLoading(
                                    controller.progressBarStatusAddAddress,
                                    false);
                                var snackBar = SnackBar(
                                  elevation: 0,
                                  behavior: SnackBarBehavior.floating,
                                  backgroundColor: AppColors.success500,
                                  duration: const Duration(milliseconds: 2000),
                                  content:
                                      Text('Successfully added your address.'),
                                );
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(snackBar);
                                controller.cityController.text = '';
                                controller.addNameController.text = '';
                                controller.landMarkController.text = '';
                                controller.isPrimaryAddAddress.value = false;
                                Get.back();
                              } else {
                                controller.completeLoading(
                                    controller.progressBarStatusAddAddress,
                                    false);
                                var snackBar = SnackBar(
                                  elevation: 0,
                                  behavior: SnackBarBehavior.floating,
                                  backgroundColor: AppColors.warning500,
                                  duration: const Duration(milliseconds: 2000),
                                  content:
                                      Text(controller.authError.toUpperCase()),
                                );
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(snackBar);
                              }
                            } catch (e) {
                              controller.completeLoading(
                                  controller.progressBarStatusAddAddress,
                                  false);
                            }
                          }),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
        controller.progressBarStatusAddAddress);
  }
}
