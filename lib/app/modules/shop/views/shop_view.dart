import 'package:adora_baby/app/config/app_theme.dart';
import 'package:adora_baby/app/data/models/stages_brands.dart' as a;
import 'package:adora_baby/app/data/repositories/shop_respository.dart';
import 'package:adora_baby/app/widgets/all_brands.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

import '../../../widgets/hot_sales.dart';
import '../../../config/app_colors.dart';
import '../../../enums/progress_status.dart';
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
                        GestureDetector(
                          onTap: () {
                            controller.getTrendingImages();
                          },
                          child: Text(
                            "Shop",
                            style: kThemeData.textTheme.displaySmall,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 20.0, right: 20, top: 20),
                          child: TextField(
                            cursorColor: AppColors.mainColor,
                            // focusNode: searchNode,
                            autofocus: false,
                            decoration: InputDecoration(
                              hintText: 'Search for Items',
                              hintStyle: kThemeData.textTheme.bodyLarge
                                  ?.copyWith(color: Color(0xffAF98A8)),
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
                                          color:
                                              Color.fromRGBO(241, 149, 157, 1),
                                          //styleName: Button Text;
                                          fontFamily: "Poppins",
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ],
                                  ))
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 23,
                ),
                FutureBuilder<List>(
                  future: controller.getTrendingImages(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      if (snapshot.data != null && snapshot.data!.isNotEmpty) {
                        return CarouselSlider(
                          options: CarouselOptions(
                            height: Get.height * 0.22,
                            autoPlay: true,
                            autoPlayInterval: Duration(seconds: 3),
                            autoPlayAnimationDuration:
                                Duration(milliseconds: 800),
                            autoPlayCurve: Curves.fastOutSlowIn,
                            enlargeCenterPage: true,
                            viewportFraction: 1,
                            aspectRatio: 2.0,
                            padEnds: false,
                            // clipBehavior: Clip.antiAlias,
                            // onPageChanged: callbackFunction,
                            scrollDirection: Axis.horizontal,
                          ),
                          items: controller.trendingImagesList.map((i) {
                            return Container(
                              padding: EdgeInsets.symmetric(horizontal: 18),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(20.0),
                                child: CachedNetworkImage(
                                  fit: BoxFit.cover,
                                  imageUrl: '${i.name}',
                                  placeholder: (context, url) => Center(
                                      child: CircularProgressIndicator()),
                                  errorWidget: (context, url, error) =>
                                      Icon(Icons.error),
                                ),
                              ),
                            );
                          }).toList(),
                        );
                      } else {
                        return Container(
                          height: Get.height * 0.22,
                          margin: EdgeInsets.symmetric(horizontal: 18),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Colors.white),
                          child: Center(
                            child: Text(
                              "No Trending Images Available",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 16,
                                  fontFamily: 'Graphik',
                                  color: Colors.red.withOpacity(0.67),
                                  letterSpacing: 1.25,
                                  fontWeight: FontWeight.w300),
                            ),
                          ),
                        );
                      }
                    } else if (snapshot.hasError) {
                      return const Center(
                        child: Text("Sorry,not found!"),
                      );
                    }
                    return Container(
                      padding: EdgeInsets.symmetric(horizontal: 18),
                      child: Shimmer.fromColors(
                          baseColor: Colors.white,
                          highlightColor: LightTheme.lightActive,
                          child: Container(
                            height: Get.height * 0.22,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: Colors.white),
                          )),
                    );
                  },
                ),
                HotSale(),
                Obx(() => controller.isSelected.value
                    ? const AllBrands()
                    : Container()),
                Container(
                  height: Get.height * 0.1,
                )
              ],
            ),
          ),
        ));
  }
}
