import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../config/app_colors.dart';
import '../../../config/app_theme.dart';
import '../controllers/profile_controller.dart';

Widget userProfile(ProfileController controller, BuildContext context) {
  return Obx(() => Container(
      decoration: BoxDecoration(
          color: LightTheme.white, borderRadius: BorderRadius.circular(20)),
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 18),
      padding: EdgeInsets.symmetric(horizontal: 33, vertical: 34),
      child: Stack(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Center(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(100.0),
                  child: CachedNetworkImage(
                    fit: BoxFit.cover,
                    height: Get.height * 0.14,
                    width: Get.height * 0.14,
                    imageUrl:
                        'https://expertphotography.b-cdn.net/wp-content/uploads/2018/10/cool-profile-pictures-aperture.jpg',
                    placeholder: (context, url) =>
                        const Center(child: CircularProgressIndicator()),
                    errorWidget: (context, url, error) =>
                        const Icon(Icons.error),
                  ),
                ),
              ),
              Obx(() => Text(
                    '${controller.user.value.fullName}',
                    style: kThemeData.textTheme.displaySmall
                        ?.copyWith(color: DarkTheme.dark),
                  )),
              SizedBox(
                height: 16,
              ),
              Container(
                padding:
                    EdgeInsets.only(top: 10, bottom: 10, left: 6, right: 6),
                margin: EdgeInsets.symmetric(horizontal: Get.width * 0.3),
                // width: Get.width * 0.23,
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          Color.fromRGBO(127, 0, 255, 1),
                          Color.fromRGBO(255, 0, 255, 0.5),
                        ]),
                    borderRadius: BorderRadius.circular(25)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SvgPicture.asset(
                              "assets/images/profile_diamonds.svg",
                              // height: 0.022 * Get.height,
                            ),
                            SizedBox(
                              width: 4,
                            ),
                            Text(
                              '${controller.user.value.diamond}',
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: kThemeData.textTheme.labelSmall
                                  ?.copyWith(color: LightTheme.white),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 16,
              ),
              Row(
                children: [
                  SvgPicture.asset(
                    "assets/images/profile_home.svg",
                    height: 0.027 * Get.height,
                  ),
                  SizedBox(
                    width: 16,
                  ),
                  controller.user.value.accountAddress == null ||
                          controller.user.value.accountAddress!.isEmpty
                      ? Expanded(
                          child: Text(
                            'Set your Home Address.',
                            maxLines: 2,
                            style: kThemeData.textTheme.bodyLarge
                                ?.copyWith(color: DarkTheme.normal),
                          ),
                        )
                      : Expanded(
                          child: Text(
                            'KL Tower, Baneshwor, Kathmandu',
                            maxLines: 2,
                            style: kThemeData.textTheme.bodyLarge
                                ?.copyWith(color: DarkTheme.normal),
                          ),
                        ),
                ],
              ),
              SizedBox(
                height: 16,
              ),
              Row(
                children: [
                  SvgPicture.asset(
                    "assets/images/profile_call.svg",
                    height: 0.027 * Get.height,
                  ),
                  SizedBox(
                    width: 16,
                  ),
                  Expanded(
                    child: Text(
                      '${controller.user.value.phoneNumber}',
                      style: kThemeData.textTheme.bodyLarge?.copyWith(
                        color: DarkTheme.normal,
                      ),
                    ),
                  ),
                ],
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
