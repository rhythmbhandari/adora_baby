import 'package:adora_baby/app/modules/home/controllers/home_controller.dart';
import 'package:adora_baby/app/widgets/buttons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../config/app_colors.dart';
import '../../../config/app_theme.dart';

class ChangePassword extends GetView<HomeController> {
  const ChangePassword({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
            bottom: false,
            child: Column(
              children: [
                Container(
                  width: double.infinity,
                  height: 88,
                  color: Colors.white,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 33.0),
                        child: GestureDetector(
                            onTap: () {
                              Get.back();
                            },
                            child: SvgPicture.asset(
                              "assets/images/arrow-left.svg",
                              height: 26,
                              width: 26,
                              color: DarkTheme.darkNormal,
                            )),
                      ),
                      SizedBox(),
                    ],
                  ),
                ),
                SizedBox(
                  height: Get.height * 0.03,
                ),
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 32,
                  ),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SvgPicture.asset(
                          "assets/images/change_pass.svg",
                          height: Get.height * 0.38,
                          width: 26,
                        )
                      ]),
                ),
                Expanded(child: Container()),
                Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 32,
                    ),
                    child: ButtonsWidget(
                        name: 'Reset',
                        onPressed: () {
                          Get.back();
                        })),
                SizedBox(
                  height: Get.height * 0.06,
                ),
              ],
            )));
  }
}
