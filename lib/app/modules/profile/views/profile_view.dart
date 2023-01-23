import 'dart:developer';

import 'package:adora_baby/app/config/app_colors.dart';
import 'package:adora_baby/app/config/app_theme.dart';
import 'package:adora_baby/app/widgets/recently_viewed.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../../main.dart';
import '../../../config/constants.dart';
import '../../../routes/app_pages.dart';
import '../../../utils/jwt_decoder.dart';
import '../controllers/profile_controller.dart';
import 'baby_profile_widget.dart';
import 'order_widget.dart';
import 'user_profile_widget.dart';

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
                      GestureDetector(
                        onTap: () async{
                          String? token = await storage.readRefreshToken();
                          String? token1 = await storage.readAccessToken();
                          log('${JwtDecoder.isExpired(token!)}');
                          log('${JwtDecoder.isExpired(token1!)}');
                        },
                        child: Text(
                          'Profile',
                          style: kThemeData.textTheme.displaySmall
                              ?.copyWith(color: DarkTheme.normal),
                        ),
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
                OrderWidget(
                  controller: controller,
                ),
                Center(
                  child: GestureDetector(
                    onTap: () async {
                      await storage.delete(
                        Constants.ACCESS_TOKEN,
                      );
                      await storage.delete(
                        Constants.LOGGED_IN_STATUS,
                      );
                      await storage.delete(
                        Constants.REFRESH_TOKEN,
                      );
                      Get.offAllNamed(Routes.PHONE);
                    },
                    child: Text(
                      'Logout',
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
