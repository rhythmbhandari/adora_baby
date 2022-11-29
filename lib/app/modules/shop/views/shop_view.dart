import 'package:adora_baby/app/config/app_theme.dart';
import 'package:adora_baby/models/stages_brands.dart' as a;
import 'package:adora_baby/repositories/shop_respository.dart';
import 'package:adora_baby/widgets/all_brands.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';

import '../../../../widgets/custom_progress_bar.dart';
import '../../../../widgets/hot_sales.dart';
import '../../../config/app_colors.dart';
import '../controllers/shop_controller.dart';

class ShopView extends GetView<ShopController> {
  const ShopView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(250, 245, 252, 1),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 30.0),
                child: Container(
                  padding: const EdgeInsets.only(bottom: 20),
                  color: Colors.white,
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 20,
                      ),
                      Text(
                        "Shop",
                        style: kThemeData.textTheme.displaySmall,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 20.0, right: 20, top: 20),
                        child: TextField(
                          cursorColor: AppColors.mainColor,
                          // focusNode: searchNode,
                          autofocus: false,
                          decoration: InputDecoration(
                            hintText: 'Search',
                            hintStyle: kThemeData.textTheme.bodyLarge,
                            contentPadding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 12),
                            suffixIcon: Image.asset(
                              'assets/images/search-normal.png',
                              color: const Color.fromRGBO(84, 104, 129, 1),
                            ),
                            fillColor: Colors.white,
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                                borderSide: const BorderSide(
                                    width: 1,
                                    color: Color.fromRGBO(175, 152, 168, 1))),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                                borderSide: const BorderSide(
                                    width: 1,
                                    color: Color.fromRGBO(175, 152, 168, 1))),
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                                borderSide: const BorderSide(
                                    width: 1,
                                    color: Color.fromRGBO(175, 152, 168, 1))),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 40.0, right: 40),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            GestureDetector(
                              onTap: () {
                                controller.showAlertDialog(context);
                              },
                              child: Row(
                                children: [
                                  SvgPicture.asset(
                                      "assets/images/filter-search.svg"),
                                  const Text(
                                    "All Stages",
                                    style: TextStyle(
                                      color: Color.fromRGBO(241, 149, 157, 1),
                                      //styleName: Button Text;
                                      fontFamily: "Poppins",
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                controller.isSelected.value = true;
                             ShopRepository.brands();
                              },
                              child: Row(
                                children: [
                                  SvgPicture.asset("assets/images/tag.svg"),
                                  const Text(
                                    "All Brands",
                                    style: TextStyle(
                                      color: Color.fromRGBO(241, 149, 157, 1),
                                      //styleName: Button Text;
                                      fontFamily: "Poppins",
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
              const HotSale(),
              controller.isSelected.value? const AllBrands():Container()

            ],
          ),
        ),
      ),
    );
  }
}
