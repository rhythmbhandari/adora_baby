import 'dart:developer';

import 'package:adora_baby/app/modules/shop/controllers/shop_controller.dart';
import 'package:adora_baby/app/modules/shop/views/all_tips_page.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

import '../config/app_colors.dart';
import '../config/app_theme.dart';
import '../modules/shop/views/all_products_page.dart';
import '../routes/app_pages.dart';
import 'gradient_icon.dart';

Widget tips(ShopController controller, BuildContext context) {
  return Padding(
    padding: const EdgeInsets.only(left: 30.0, right: 30, top: 10, bottom: 15),
    child: Container(
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(20)),
      child: Column(
        children: [
          const SizedBox(
            height: 32,
          ),
          const Center(
            child: Text(
              "Tip of the Day",
              style: TextStyle(
                color: AppColors.primary500,
                fontFamily: "PLayfair",
                fontSize: 24,
                fontWeight: FontWeight.w600,
                letterSpacing: -0.01,
              ),
            ),
          ),
          Padding(
              padding: const EdgeInsets.all(26.0),
              child: Obx(() => controller.tipsList.isNotEmpty
                  ? Container(
                      // padding: const EdgeInsets.only(top: 10),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(
                              color: const Color.fromRGBO(192, 144, 254, 0.25)),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 1,
                              blurRadius: 2,
                              offset:
                                  Offset(0, 2), // changes position of shadow
                            ),
                          ],
                          borderRadius: BorderRadius.circular(30)),
                      child: Container(
                        // padding: EdgeInsets.symmetric(horizontal: 18),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(30.0),
                          child: Container(
                            height: Get.height * 0.4,
                            width: Get.width,
                            child: CachedNetworkImage(
                              fit: BoxFit.fill,
                              imageUrl: '${controller.tipsList[0].picture}',
                              placeholder: (context, url) => Container(
                                  height: Get.height * 0.4,
                                  child: Center(
                                      child: CircularProgressIndicator())),
                              errorWidget: (context, url, error) =>
                                  Icon(Icons.error),
                            ),
                          ),
                        ),
                      ),
                    )
                  : Shimmer.fromColors(
                      baseColor: Colors.white,
                      highlightColor: LightTheme.lightActive,
                      enabled: true,
                      child: _buildImage()))),
          GestureDetector(
            onTap: () {
              Get.to(() => MoreTips(),
                  arguments: controller.tipsList);
            },
            child: Align(
              alignment: Alignment.centerRight,
              child: Container(
                padding: EdgeInsets.only(right: 18, bottom: 19),
                child: Text(
                  'See All',
                  style: kThemeData.textTheme.labelMedium
                      ?.copyWith(color: AppColors.primary700, fontSize: 16),
                ),
              ),
            ),
          )
        ],
      ),
    ),
  );
}

Widget _buildImage() {
  return Container(
    // padding: const EdgeInsets.only(top: 10),
    alignment: Alignment.center,
    decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: const Color.fromRGBO(192, 144, 254, 0.25)),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 1,
            blurRadius: 2,
            offset: Offset(0, 2), // changes position of shadow
          ),
        ],
        borderRadius: BorderRadius.circular(30)),
    child: Container(
      // padding: EdgeInsets.symmetric(horizontal: 18),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(30.0),
        child: Container(
          height: Get.height * 0.4,
          // color: Colors.white,
        ),
      ),
    ),
  );
}
