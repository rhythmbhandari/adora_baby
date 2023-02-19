import 'dart:developer';

import 'package:adora_baby/app/data/repositories/session_manager.dart';
import 'package:adora_baby/app/modules/cart/widgets/item_card.dart';
import 'package:adora_baby/app/routes/app_pages.dart';
import 'package:adora_baby/app/widgets/buttons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

import '../../../config/app_colors.dart';
import '../../../config/app_theme.dart';
import '../../../enums/progress_status.dart';
import '../../shop/widgets/auth_progress_indicator.dart';
import '../controllers/cart_controller.dart';
import '../widgets/custom_error_widget.dart';
import '../widgets/empty_widget.dart';
import '../widgets/internet_error_widget.dart';
import 'cart_shimmer.dart';

class CartLoadedWidget extends StatelessWidget {
  const CartLoadedWidget({
    Key? key,
    required this.controller,
  }) : super(key: key);

  final CartController controller;

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: const BoxDecoration(
          color: LightTheme.white,
        ),
        margin: const EdgeInsets.symmetric(vertical: 10),
        // padding: const EdgeInsets.symmetric(
        //     horizontal: 22, vertical: 34),
        child: Obx(() => controller.cartList.isNotEmpty
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 16,
                      left: 36,
                    ),
                    child: Text(
                      "${controller.cartList.length} items in your cart",
                      style: kThemeData.textTheme.labelLarge,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 22,
                      right: 38,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GetBuilder<CartController>(
                          id: 'mainCheckbox',
                          builder: (myController) => GestureDetector(
                            onTap: () async {
                              myController.mainCheckboxPressed(
                                  !myController.mainCheckbox.value);
                            },
                            child: Row(
                              children: [
                                Transform.scale(
                                  scale: 1.2,
                                  child: Checkbox(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(4),
                                      ),
                                      side: const BorderSide(
                                          width: 1,
                                          color: DarkTheme.darkLightActive),
                                      focusColor: AppColors.primary500,
                                      value: myController.mainCheckbox.value,
                                      onChanged: (bool? val) async =>
                                          myController
                                              .mainCheckboxPressed(val)),
                                  // onChanged: (value) => onChanged,
                                ),
                                Text(
                                  "Select All",
                                  style: kThemeData.textTheme.bodyLarge,
                                ),
                              ],
                            ),
                          ),
                        ),
                        GestureDetector(
                            onTap: () async {
                              try {
                                if (controller.priceCart.value != 0.0) {
                                  controller.showLoading(
                                      controller.progressBarStatusCart);
                                  var carIdList = [];
                                  for (final cart in controller.cartList) {
                                    if (cart.checkBox) {
                                      carIdList.add(cart.id);
                                    }
                                  }

                                  final removalStatus = await controller
                                      .requestToDeleteCart(carIdList);
                                  log('Removal status $removalStatus');
                                  if (!removalStatus) {
                                    var snackBar = SnackBar(
                                      elevation: 0,
                                      behavior: SnackBarBehavior.floating,
                                      backgroundColor: Colors.red,
                                      duration:
                                          const Duration(milliseconds: 2000),
                                      content: Text(
                                          'Could not remove all items from cart.'),
                                    );

                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(snackBar);
                                  } else {
                                    var snackBar = SnackBar(
                                      elevation: 0,
                                      behavior: SnackBarBehavior.floating,
                                      backgroundColor: AppColors.success500,
                                      duration:
                                          const Duration(milliseconds: 2000),
                                      content: Text(
                                          'Successfully removed items from cart.'),
                                    );

                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(snackBar);
                                  }
                                  await controller.cart();
                                  controller.priceCart.value = 0.0;
                                  controller.completeLoading(
                                    controller.progressBarStatusCart,
                                    controller.cartList.isNotEmpty
                                        ? false
                                        : true,
                                  );
                                } else {
                                  var snackBar = SnackBar(
                                    elevation: 0,
                                    behavior: SnackBarBehavior.floating,
                                    backgroundColor: AppColors.secondary500,
                                    duration:
                                        const Duration(milliseconds: 2000),
                                    content: Text(
                                        'Please select an item to remove.'),
                                  );

                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(snackBar);
                                }
                              } catch (e) {
                                controller.completeLoading(
                                    controller.progressBarStatusCart, false);
                              }
                            },
                            child: const Text(
                              "Remove Selected",
                              style: TextStyle(
                                color: Colors.black,
                                fontFamily: "Poppins",
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ))
                      ],
                    ),
                  ),
                  ListView.builder(
                    itemCount: controller.cartList.length,
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    padding: const EdgeInsets.only(
                      top: 20,
                      left: 22,
                      right: 22,
                    ),
                    itemBuilder: (BuildContext context, int index) =>
                        CartCardWidget(
                      index,
                      controller,
                    ),
                  ),
                  Container(
                    color: LightTheme.whiteActive,
                    margin: EdgeInsets.only(
                      bottom: Get.height * 0.02,
                    ),
                    child: Center(
                      child: Text(
                        '',
                        style: kThemeData.textTheme.displaySmall
                            ?.copyWith(color: DarkTheme.normal, fontSize: 10),
                      ),
                    ),
                  ),
                  Container(
                      color: Colors.white,
                      padding: const EdgeInsets.symmetric(horizontal: 56.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Sub Total",
                            style: kThemeData.textTheme.bodyLarge?.copyWith(
                              fontSize: 16,
                            ),
                          ),
                          Obx(() => Text(
                                "Rs. ${controller.priceCart.value}",
                                style:
                                    kThemeData.textTheme.titleMedium?.copyWith(
                                  color: DarkTheme.dark,
                                  fontSize: 16,
                                ),
                              )),
                        ],
                      )),
                  const SizedBox(
                    height: 30,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 30.0, right: 30),
                    child: ButtonsWidget(
                        name: "Proceed",
                        onPressed: () {
                          if (controller.priceCart.value == 0.0) {
                            var snackBar = SnackBar(
                              elevation: 0,
                              behavior: SnackBarBehavior.floating,
                              backgroundColor: Colors.red,
                              duration: Duration(milliseconds: 2000),
                              content:
                                  Text("Please select an item to checkout."),
                            );
                            ScaffoldMessenger.of(context)
                                .showSnackBar(snackBar);
                          } else {
                            controller.cartMap.clear();
                            for (final cart in controller.cartList) {
                              if (cart.checkBox) {
                                controller.cartMap[cart.id] = {
                                  'id': cart.id,
                                  'quantity': cart.quantity
                                };
                              }
                            }
                            if (SessionManager.instance.user != null) {
                              controller.fNameController.text =
                                  SessionManager.instance.user?.fullName ?? '';
                              controller.phoneController.text =
                                  SessionManager.instance.user?.phoneNumber ??
                                      '';
                            }
                            log('Cart is ${controller.cartMap}');
                            Get.toNamed(Routes.PERSONAL_INFORMATION);
                          }
                        }),
                  ),
                  SizedBox(
                    height: Get.height * 0.1,
                  ),
                ],
              )
            : const CartShimmer()));
  }
}
