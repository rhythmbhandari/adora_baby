import 'dart:developer';

import 'package:adora_baby/app/config/app_theme.dart';
import 'package:adora_baby/app/data/models/stages_brands.dart' as a;
import 'package:adora_baby/app/data/repositories/shop_respository.dart';
import 'package:adora_baby/app/modules/profile/controllers/profile_controller.dart';
import 'package:adora_baby/app/modules/shop/widgets/all_brands.dart';
import 'package:adora_baby/app/modules/shop/widgets/auth_progress_indicator.dart';
import 'package:adora_baby/app/widgets/tips_widget.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../main.dart';
import '../../../widgets/gradient_icon.dart';

import '../../search/views/search_view.dart';
import '../widgets/all_products.dart';
import '../widgets/hot_sales.dart';

import '../../../config/app_colors.dart';
import '../../../enums/progress_status.dart';
import '../../../widgets/shimmer_widget.dart';
import '../../../widgets/recently_viewed.dart';
import '../controllers/shop_controller.dart';
import '../widgets/trending_images.dart';

class ShopView extends GetView<ShopController> {
  ShopView({Key? key}) : super(key: key);

  final ProfileController profileController = Get.find();

  @override
  Widget build(BuildContext context) {
    return progressWrap(
        Scaffold(
            backgroundColor: LightTheme.white,
            body: NewShopViewBody(
              controller: controller,
              profileController: profileController,
            )),
        controller.progressStatus);
  }
}

class NewShopViewBody extends StatelessWidget {
  const NewShopViewBody({
    Key? key,
    required this.controller,
    required this.profileController,
  }) : super(key: key);

  final ShopController controller;
  final ProfileController profileController;

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
                  height: 40,
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 41),
                  child: GetBuilder<ProfileController>(
                    builder: (value) => Row(
                      children: [
                        Center(
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(100.0),
                            child: CachedNetworkImage(
                              fit: BoxFit.cover,
                              height: Get.height * 0.06,
                              width: Get.height * 0.06,
                              imageUrl: value.user.value.photos != null &&
                                      value.user.value.photos!.isNotEmpty
                                  ? value.user.value.photos!.length > 1
                                      ? '${value.user.value.photos?[1]?.name}'
                                      : 'https://sternbergclinic.com.au/wp-content/uploads/2020/03/placeholder.png'
                                  : 'https://sternbergclinic.com.au/wp-content/uploads/2020/03/placeholder.png',
                              placeholder: (context, url) => const Center(
                                  child: CircularProgressIndicator()),
                              errorWidget: (context, url, error) =>
                                  const Icon(Icons.error),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 8,
                        ),
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                value.user.value.babyName ?? '',
                                style: kThemeData.textTheme.labelMedium
                                    ?.copyWith(color: DarkTheme.darkNormal),
                              ),
                              Text(
                                '${(DateTime.now().difference(value.user.value.babyDob != null ? value.user.value.babyDob! : DateTime.now()).inDays / 30).floor()} Months',
                                style: kThemeData.textTheme.labelMedium
                                    ?.copyWith(color: DarkTheme.darkNormal),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Get.to(() => SearchView(),
                        arguments: controller.allProducts);
                  },
                  child: Hero(
                    tag: 'search',
                    child: Material(
                      type: MaterialType.transparency,
                      child: Padding(
                        padding: const EdgeInsets.only(
                            left: 31.0, right: 31, top: 20),
                        child: TextField(
                          cursorColor: AppColors.mainColor,
                          // focusNode: searchNode,
                          autofocus: false,
                          enabled: false,
                          readOnly: true,
                          decoration: InputDecoration(
                            hintText: 'Search for Items',
                            hintStyle: kThemeData.textTheme.bodyLarge
                                ?.copyWith(color: Color(0xffAF98A8)),
                            contentPadding: const EdgeInsets.symmetric(
                                horizontal: 24, vertical: 18),
                            suffixIcon: Padding(
                              padding: const EdgeInsets.only(
                                  top: 8.0, right: 23, bottom: 8),
                              child: SvgPicture.asset(
                                  "assets/images/search-normal.svg"),
                            ),
                            fillColor: Colors.white,
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(33),
                                borderSide: const BorderSide(
                                    width: 1,
                                    color: Color.fromRGBO(175, 152, 168, 1))),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(33),
                                borderSide: const BorderSide(
                                    width: 1,
                                    color: Color.fromRGBO(175, 152, 168, 1))),
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(33),
                                borderSide: const BorderSide(
                                    width: 1,
                                    color: Color.fromRGBO(175, 152, 168, 1))),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
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
                TrendingImages(controller: controller),
                HotSale(
                  controller: controller,
                ),
                tips(controller, context),
                AllProducts(controller: controller),
                Container(
                  height: Get.height * 0.1,
                )
              ],
            ),
          )
        ],
      ),
    ));
  }
}

Widget shimmerHomePage() {
  return Column(
    children: [
      ShimmerHotSales(),
      SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            for (int i = 0; i < 4; i++)
              Container(
                padding: const EdgeInsets.only(top: 10),
                height: 286,
                margin: const EdgeInsets.only(right: 0, bottom: 10, left: 19),
                width: Get.width * 0.35,
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
                        offset: Offset(0, 2), // changes position of shadow
                      ),
                    ],
                    borderRadius: BorderRadius.circular(15)),
                child: Column(
                  children: [
                    Stack(
                      children: [
                        Container(
                          margin: EdgeInsets.only(top: 12, bottom: 8),
                          child: Center(
                            child: Image.network(
                              "snapshot.data![0][index].productImages[0].name",
                              height: Get.height * 0.16,
                            ),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.only(
                              top: 2, bottom: 2, left: 6, right: 6),
                        )
                      ],
                    ),
                    Container(
                      padding: const EdgeInsets.only(left: 13, right: 13),
                      width: Get.width,
                      decoration: const BoxDecoration(
                          color: Color.fromRGBO(243, 234, 249, 1),
                          borderRadius: BorderRadius.only(
                              bottomRight: Radius.circular(15),
                              bottomLeft: Radius.circular(15))),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 8,
                          ),
                          Text(
                            "test",
                            maxLines: 1,
                            style: kThemeData.textTheme.labelSmall?.copyWith(
                                color: AppColors.secondary700, fontSize: 12),
                          ),
                          SizedBox(
                            height: 4,
                          ),
                          Text(
                            "Test",
                            maxLines: 2,
                            style: kThemeData.textTheme.bodyMedium?.copyWith(
                                color: AppColors.primary700, fontSize: 14),
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          RatingBar.builder(
                            initialRating: 4,
                            ignoreGestures: true,
                            itemSize: 12,
                            direction: Axis.horizontal,
                            allowHalfRating: true,
                            glow: false,
                            itemCount: 5,
                            itemPadding: EdgeInsets.symmetric(horizontal: 0.0),
                            itemBuilder: (context, _) => GradientIcon(
                              Icons.star,
                              10.0,
                              LinearGradient(
                                colors: <Color>[
                                  Color.fromRGBO(127, 0, 255, 1),
                                  Color.fromRGBO(255, 0, 255, 1)
                                ],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              ),
                            ),
                            onRatingUpdate: (rating) {
                              print(rating);
                            },
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Rs. ",
                                maxLines: 2,
                                style: kThemeData.textTheme.bodyMedium
                                    ?.copyWith(
                                        color: DarkTheme.lightActive,
                                        decoration: TextDecoration.lineThrough),
                              ),
                              Text(
                                "Rs. ",
                                maxLines: 2,
                                style: kThemeData.textTheme.bodyMedium
                                    ?.copyWith(color: DarkTheme.normal),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 8,
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
          ],
        ),
      ),
      Container(
        height: Get.height * 0.1,
      )
    ],
  );
}

class ShimmerHotSales extends StatelessWidget {
  const ShimmerHotSales({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 20, bottom: 15, left: 18, right: 18),
      decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.3),
          borderRadius: BorderRadius.circular(20)),
      child: Column(
        children: [
          const SizedBox(
            height: 20,
          ),
          Center(
            child: Container(
              height: 21,
              width: 100,
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(40)),
            ),
          ),
          Center(
            child: Container(
              height: 21,
              width: 100,
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(40)),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 18),
            child: GridView.count(
              childAspectRatio: 0.6,
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              crossAxisCount: 2,
              children: List.generate(
                4,
                (index) => Container(
                  padding: const EdgeInsets.only(top: 10),
                  margin: EdgeInsets.only(right: 18, bottom: 20),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.8),
                      border: Border.all(
                          color: const Color.fromRGBO(192, 144, 254, 0.25)),
                      borderRadius: BorderRadius.circular(15)),
                ),
              ),
            ),
          ),
          Center(
            child: Container(
              height: 21,
              width: 100,
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(40)),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                alignment: Alignment.bottomRight,
                height: 21,
                width: 100,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(40)),
              ),
              SizedBox(
                width: 20,
              ),
            ],
          ),
          Center(
            child: Container(
              height: 21,
              width: 100,
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(40)),
            ),
          ),
        ],
      ),
    );
  }
}

class ShimmerRecentlyViewed extends StatelessWidget {
  const ShimmerRecentlyViewed({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 20, bottom: 15, left: 18, right: 18),
      decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.3),
          borderRadius: BorderRadius.circular(20)),
      child: Column(
        children: [
          const SizedBox(
            height: 20,
          ),
          Center(
            child: Container(
              height: 21,
              width: 100,
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(40)),
            ),
          ),
          Center(
            child: Container(
              height: 21,
              width: 100,
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(40)),
            ),
          ),
          Row(
            children: [
              Container(
                padding: const EdgeInsets.only(top: 10),
                margin: EdgeInsets.only(right: 18, bottom: 20),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.8),
                    border: Border.all(
                        color: const Color.fromRGBO(192, 144, 254, 0.25)),
                    borderRadius: BorderRadius.circular(15)),
              )
            ],
          ),
          Center(
            child: Container(
              height: 21,
              width: 100,
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(40)),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                alignment: Alignment.bottomRight,
                height: 21,
                width: 100,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(40)),
              ),
              SizedBox(
                width: 20,
              ),
            ],
          ),
          Center(
            child: Container(
              height: 21,
              width: 100,
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(40)),
            ),
          ),
        ],
      ),
    );
  }
}
