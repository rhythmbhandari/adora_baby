import 'dart:developer';

import 'package:adora_baby/app/modules/cart/widgets/item_card.dart';
import 'package:adora_baby/app/widgets/buttons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../main.dart';
import '../../../config/app_colors.dart';
import '../../../config/app_theme.dart';
import '../../../enums/progress_status.dart';
import '../../shop/widgets/auth_progress_indicator.dart';
import '../controllers/cart_controller.dart';
import '../widgets/cart_loaded_widget.dart';
import '../widgets/custom_error_widget.dart';
import '../widgets/empty_widget.dart';
import '../widgets/internet_error_widget.dart';

class CartView extends GetView<CartController> {
  const CartView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return progressWrap(
        Scaffold(
          backgroundColor: LightTheme.white,
          appBar: AppBar(
            backgroundColor: LightTheme.white,
            elevation: 0,
          ),
          body: SafeArea(
            child: SingleChildScrollView(
              child: Container(
                color: LightTheme.whiteActive,
                child: Column(
                  children: [
                    GestureDetector(
                      onTap: () async {
                        log((await storage.readAccessToken()).toString());
                      },
                      child: Container(
                        color: LightTheme.white,
                        padding: EdgeInsets.only(
                          bottom: Get.height * 0.02,
                          top: Get.height * 0.02,
                        ),
                        child: Center(
                          child: Text(
                            'Cart',
                            style: kThemeData.textTheme.displaySmall
                                ?.copyWith(color: DarkTheme.normal),
                          ),
                        ),
                      ),
                    ),
                    Obx(() {
                      switch (controller.progressBarStatusCart.value) {
                        case ProgressStatus.error:
                          return const CustomErrorWidget();
                        case ProgressStatus.internetError:
                          return const InternetErrorWidget();
                        case ProgressStatus.empty:
                          return const EmptyWidget();
                        case ProgressStatus.idle:
                        case ProgressStatus.loading:
                        case ProgressStatus.searching:
                        case ProgressStatus.success:
                          return CartLoadedWidget(
                            controller: controller,
                          );
                      }
                    }),
                  ],
                ),
              ),
            ),
          ),
        ),
        controller.progressBarStatusCart);
  }
}
