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

import '../../../widgets/all_products.dart';
import '../../../widgets/hot_sales.dart';
import '../../../config/app_colors.dart';
import '../../../enums/progress_status.dart';
import '../../../widgets/shimmer_widget.dart';
import '../../../widgets/recently_viewed.dart';
import '../controllers/shop_controller.dart';

class ShopView extends GetView<ShopController> {
  const ShopView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: LightTheme.white,
        body: NewShopViewBody(controller: controller));
  }
}

class NewShopViewBody extends StatelessWidget {
  const NewShopViewBody({
    Key? key,
    required this.controller,
  }) : super(key: key);

  final ShopController controller;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: SingleChildScrollView(
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.only(bottom: 20, top: 30),
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
                  padding:
                      const EdgeInsets.only(left: 20.0, right: 20, top: 20),
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
                          // controller.showAlertDialog(context);
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
                          ))
                    ],
                  ),
                )
              ],
            ),
          ),
          Container(
            color: LightTheme.lightActive,
            child: Column(
              children: [

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
                            autoPlayAnimationDuration: Duration(milliseconds: 800),
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
                                  placeholder: (context, url) =>
                                      Center(child: CircularProgressIndicator()),
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
                    // return const CircleListItem();
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
                Obx(() {
                  switch (controller.progressStatus.value) {
                    case ProgressStatus.LOADING:
                      return Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16),
                        child: Shimmer.fromColors(
                            baseColor: Colors.white,
                            highlightColor: LightTheme.lightActive,
                            enabled: true,
                            child: shimmerHomePage()),
                      );

                    case ProgressStatus.ERROR:
                      return Container();
                    case ProgressStatus.IDLE:
                      break;
                    case ProgressStatus.SUCCESS:
                      break;
                    case ProgressStatus.INTERNET_ERROR:
                      break;
                  }
                  return Container();
                })
              ],
            ),
          )
        ],
      ),
    ));
  }
}

class OldShopViewBody extends StatelessWidget {
  const OldShopViewBody({
    Key? key,
    required this.controller,
  }) : super(key: key);

  final ShopController controller;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
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
                      padding:
                          const EdgeInsets.only(left: 20.0, right: 20, top: 20),
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
                                      color: Color.fromRGBO(241, 149, 157, 1),
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
                        autoPlayAnimationDuration: Duration(milliseconds: 800),
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
                              placeholder: (context, url) =>
                                  Center(child: CircularProgressIndicator()),
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
                // return const CircleListItem();
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
            RecentlyViewed(),
            AllProducts(),
            Obx(() =>
                controller.isSelected.value ? const AllBrands() : Container()),
            Container(
              height: Get.height * 0.1,
            )
          ],
        ),
      ),
    );
  }
}

Widget shimmerHomePage() {
  return Column(
    children: [
      Container(
        margin:
            const EdgeInsets.only(left: 23.0, right: 23, top: 20, bottom: 15),
        decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.3), borderRadius: BorderRadius.circular(20)),
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            const Center(
              child: Text(
                "Hot Sales",
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
              padding: const EdgeInsets.all(19.0),
              child: GridView.count(
                childAspectRatio: 0.6,
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                crossAxisCount: 2,
                children: List.generate(
                  4,
                  (index) => Container(
                    padding: const EdgeInsets.only(top: 10),
                    margin: EdgeInsets.all(10),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(
                            color: const Color.fromRGBO(192, 144, 254, 0.25)),
                        borderRadius: BorderRadius.circular(15)),
                    child: Container(
                        padding: const EdgeInsets.only(left: 5, right: 5),
                        decoration: const BoxDecoration(
                            color: Color.fromRGBO(243, 234, 249, 1),
                            borderRadius: BorderRadius.only(
                                bottomRight: Radius.circular(15),
                                bottomLeft: Radius.circular(15))),
                        child: Text(
                          "snapshot.data![index].name",
                          style: kThemeData.textTheme.bodyMedium,
                        )),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    ],
  );
}
