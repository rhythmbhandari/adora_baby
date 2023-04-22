import 'package:adora_baby/app/config/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:get/get.dart';

import '../../../routes/app_pages.dart';
import '../controllers/walkthrough_controller.dart';
import 'page_view_content.dart';
import 'three_dot_indicator.dart';

class WalkthroughView extends GetView<WalkthroughController> {
  final PageController _pageController = PageController();

  WalkthroughView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 32),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SvgPicture.asset("assets/images/arrow-left.svg",
                      height: 22, color: const Color(0xff667080)),
                  Obx(() => controller.currentIndex != 2
                      ? GestureDetector(
                          onTap: () {
                            Get.offNamed(Routes.PHONE);
                          },
                          child: Text(
                            'Skip',
                            style: Get.textTheme.bodyMedium
                                ?.copyWith(color: const Color(0xff667080)),
                          ),
                        )
                      : Container()),
                ],
              ),
              Expanded(
                child: PageViewContent(
                  pageController: _pageController,
                  onPageChanged: controller.onPageChange,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                // crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // SizedBox(width: 0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      dotsIndicator(0),
                      const SizedBox(width: 10),
                      dotsIndicator(1),
                      const SizedBox(width: 10),
                      dotsIndicator(2),
                    ],
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 18),
                    decoration: const BoxDecoration(
                        shape: BoxShape.circle, color: AppColors.primary400),
                    child: Obx(() => controller.currentIndex != 2
                        ? GestureDetector(
                            onTap: () {
                              controller.callNextPage(_pageController);
                            },
                            child: Text(
                              'NEXT',
                              style: Get.textTheme.labelMedium
                                  ?.copyWith(fontSize: 12),
                            ),
                          )
                        : GestureDetector(
                            onTap: () {
                              Get.offNamed(Routes.PHONE);
                            },
                            child: Text(
                              'DONE',
                              style: Get.textTheme.labelMedium
                                  ?.copyWith(fontSize: 11),
                            ),
                          )),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Obx dotsIndicator(positionIndex) {
    return Obx(() {
      return ThreeDotIndicator(
        positionIndex: positionIndex,
        currentIndex: controller.currentIndex,
      );
    });
  }
}
