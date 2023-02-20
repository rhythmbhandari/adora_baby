import 'package:adora_baby/app/data/repositories/checkout_repositories.dart';
import 'package:adora_baby/app/modules/cart/controllers/cart_controller.dart';
import 'package:adora_baby/app/widgets/buttons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:get/get.dart';

import '../../../config/app_colors.dart';
import '../../../config/app_theme.dart';
import '../../../data/models/get_address_model.dart';
import '../../../routes/app_pages.dart';
import '../../home/controllers/home_controller.dart';
import '../../profile/controllers/profile_controller.dart';

class OrderConfirmation extends GetView<CartController> {
  const OrderConfirmation({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        backgroundColor: LightTheme.whiteActive,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Center(
              child: Container(
                margin: EdgeInsets.symmetric(
                    horizontal: 32, vertical: Get.height * 0.1),
                padding: const EdgeInsets.only(
                    top: 60, bottom: 40, right: 30, left: 30),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(
                      30,
                    ),
                    boxShadow: [
                      const BoxShadow(
                        color: Color.fromRGBO(0, 0, 0, 0.1),
                        blurRadius: 0.2,
                        spreadRadius: 1,
                        offset: Offset(0, 2), // Shadow position
                      ),
                    ],
                    border: Border.all(color: Colors.grey.withOpacity(0.5))),
                child: Column(
                  children: [
                    SvgPicture.asset(
                      "assets/images/amico.svg",
                      width: Get.width * 0.9,
                      height: Get.height * 0.33,
                    ),
                    SizedBox(
                      height: 28,
                    ),
                    Text(
                      "WE ARE ON OUR WAY",
                      style: kThemeData.textTheme.displaySmall?.copyWith(
                        color: Color.fromRGBO(84, 104, 129, 1),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      "Hang Back and Relax!",
                      style: kThemeData.textTheme.bodyLarge?.copyWith(
                        color: Color.fromRGBO(84, 104, 129, 1),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      "Your order will be delivered within 2 business days.",
                      textAlign: TextAlign.center,
                      style: kThemeData.textTheme.bodyLarge?.copyWith(
                        color: Color.fromRGBO(84, 104, 129, 1),
                      ),
                    ),
                    SizedBox(
                      height: Get.height * 0.05,
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: ButtonsWidget(
                          name: "Track My Order",
                          onPressed: () {
                            controller.cart();
                            controller.mainCheckbox.value = false;
                            final HomeController homeController = Get.find();
                            final ProfileController profileController =
                                Get.find();
                            profileController.getOrderList(
                              isRefresh: true,
                              isInitial: true,
                              profileController.ordersList,
                              profileController.orderHistoryIndex,
                              profileController.progressStatusOrderProfile,
                              index: 0,
                            );
                            Get.until(
                                (route) => route.settings.name == Routes.HOME);
                            homeController.isRedirected.value = 2;

                          }),
                    ),
                    SizedBox(
                      height: Get.height * 0.05,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
