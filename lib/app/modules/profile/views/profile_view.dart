import 'package:adora_baby/app/config/app_colors.dart';
import 'package:adora_baby/app/config/app_theme.dart';
import 'package:adora_baby/app/widgets/recently_viewed.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:get/get.dart';

import '../../../../main.dart';
import '../../../config/constants.dart';
import '../controllers/profile_controller.dart';

class ProfileView extends GetView<ProfileController> {
  const ProfileView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                Container(
                  color: LightTheme.white,
                  padding: const EdgeInsets.only(bottom: 6.0),
                  child: Row(
                    children: [
                      SizedBox(
                        width: 35,
                      ),
                      Expanded(flex: 5, child: SizedBox()),
                      Text(
                        'Profile',
                        style: kThemeData.textTheme.displaySmall
                            ?.copyWith(color: DarkTheme.normal),
                      ),
                      Expanded(flex: 4, child: SizedBox()),
                      Icon(Icons.menu),
                      SizedBox(
                        width: 35,
                      )
                    ],
                  ),
                ),
                userProfile(
                  controller,
                  context,
                ),
                babyProfile(
                  controller,
                  context,
                ),
                // ordersWidget(
                //   controller,
                //   context,
                // ),
                RecentlyViewed(controller: controller),
                Center(
                  child: GestureDetector(
                    onTap: (){
                      storage.writeData(Constants.LOGGED_IN_STATUS, null);
                    },
                    child: Text(
                      'Click to remove logged in',
                      style: TextStyle(fontSize: 20, color: Colors.green),
                    ),
                  ),
                ),
                SizedBox(height: Get.height * 0.1)
              ],
            ),
          ),
        ))
        // Center(
        //   child: GestureDetector(
        //     onTap: (){
        //       storage.writeData(Constants.LOGGED_IN_STATUS, null);
        //     },
        //     child: Text(
        //       'Click to remove logged in',
        //       style: TextStyle(fontSize: 20, color: Colors.green),
        //     ),
        //   ),
        // ),
        );
  }
}

Widget userProfile(ProfileController controller, BuildContext context) {
  return Container(
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
                width: Get.width * 0.23,
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
                    SvgPicture.asset(
                      "assets/images/profile_diamonds.svg",
                      height: 0.022 * Get.height,
                    ),
                    SizedBox(
                      width: 4,
                    ),
                    Expanded(
                      child: Text(
                        '30000000',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: kThemeData.textTheme.labelSmall
                            ?.copyWith(color: LightTheme.white),
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
      ));
}

Widget babyProfile(ProfileController controller, BuildContext context) {
  return Container(
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
      ));
}

Widget ordersWidget(ProfileController controller, BuildContext context) {
  return Container(
      decoration: BoxDecoration(
          color: LightTheme.white, borderRadius: BorderRadius.circular(20)),
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 20),
      padding: EdgeInsets.symmetric(horizontal: 33, vertical: 34),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'My Orders',
            style: kThemeData.textTheme.displaySmall
                ?.copyWith(color: DarkTheme.normal),
          ),
          SizedBox(
            height: 30,
          ),
          ListView.builder(
            itemCount: 2,
            shrinkWrap: true,
            // padding:
            // EdgeInsets.only(top: 60, left: 32, bottom: 21),
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              return Container(
                width: 200,
                padding: EdgeInsets.only(right: 8),
                decoration: BoxDecoration(
                    color: AppColors.secondary500,
                    border:
                    Border.all(color: Colors.transparent)),
                child: Center(
                  child: Text(
                      'hshs',
                      style: kThemeData.textTheme.bodyLarge
                          ?.copyWith(color: Colors.red)),
                ),
              );
            },
          ),
          SizedBox(
            height: 12,
          ),
        ],
      ));
}
