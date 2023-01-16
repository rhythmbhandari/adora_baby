import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../config/app_colors.dart';
import '../../../config/app_theme.dart';
import '../controllers/profile_controller.dart';

Widget babyProfile(ProfileController controller, BuildContext context) {
  return Obx(() => Container(
      decoration: BoxDecoration(
          color: LightTheme.white, borderRadius: BorderRadius.circular(20)),
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 0),
      padding: EdgeInsets.symmetric(horizontal: 33, vertical: 34),
      child: Stack(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'My Child',
                style: kThemeData.textTheme.displaySmall
                    ?.copyWith(color: DarkTheme.normal),
              ),
              SizedBox(
                height: 30,
              ),
              Center(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(100.0),
                  child: CachedNetworkImage(
                    fit: BoxFit.cover,
                    height: Get.height * 0.10,
                    width: Get.height * 0.10,
                    imageUrl:
                    'https://anaphotography.co.uk/wp-content/uploads/2022/03/Newborn-Baby-Photography-Cornwall-400x267.jpg',
                    placeholder: (context, url) =>
                    const Center(child: CircularProgressIndicator()),
                    errorWidget: (context, url, error) =>
                    const Icon(Icons.error),
                  ),
                ),
              ),
              Text(
                '${controller.user.value.babyName}',
                style: kThemeData.textTheme.displaySmall
                    ?.copyWith(color: DarkTheme.dark),
              ),
              SizedBox(
                height: 4,
              ),
              Text(
                '${DateTime.now().difference(controller.user.value.babyDob != null ? controller.user.value.babyDob! : DateTime.now()).inDays} Months',
                style: kThemeData.textTheme.bodyLarge
                    ?.copyWith(color: DarkTheme.dark),
              ),
              SizedBox(
                height: 4,
              ),
              Text(
                'No Allergies, No Difficulties',
                style: kThemeData.textTheme.bodyLarge
                    ?.copyWith(color: DarkTheme.normal),
              ),
              SizedBox(
                height: 12,
              ),
            ],
          ),
          Positioned(
            child: SvgPicture.asset(
              "assets/images/profile_edit.svg",
              height: 0.027 * Get.height,
            ),
            right: 0,
          )
        ],
      )));
}
