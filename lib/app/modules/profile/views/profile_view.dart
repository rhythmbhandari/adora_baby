import 'package:adora_baby/app/config/app_colors.dart';
import 'package:adora_baby/app/config/app_theme.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';

import 'package:get/get.dart';

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
                UserProfile(),
                BabyProfile(),
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

class UserProfile extends StatelessWidget {
  const UserProfile({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                Text(
                  'Shilin Koirala',
                  style: kThemeData.textTheme.displaySmall
                      ?.copyWith(color: DarkTheme.dark),
                ),
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
                    Expanded(
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
                      "assets/images/profile_briefcase.svg",
                      height: 0.027 * Get.height,
                    ),
                    SizedBox(
                      width: 16,
                    ),
                    Expanded(
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
                        child: RichText(
                      text: TextSpan(
                        text: '98082776689',
                        style: kThemeData.textTheme.bodyLarge
                            ?.copyWith(color: DarkTheme.normal),
                        children: <TextSpan>[
                          TextSpan(
                              text: '\n9808677447',
                              style: kThemeData.textTheme.bodyLarge
                                  ?.copyWith(color: DarkTheme.normal)),
                        ],
                      ),
                    )),
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
}

class BabyProfile extends StatelessWidget {
  const BabyProfile({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                  'Misha Koirala',
                  style: kThemeData.textTheme.displaySmall
                      ?.copyWith(color: DarkTheme.dark),
                ),
                SizedBox(
                  height: 4,
                ),
                Text(
                  '7 Months',
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
}
