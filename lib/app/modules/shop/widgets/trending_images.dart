import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

import '../../../config/app_colors.dart';
import '../controllers/shop_controller.dart';

class TrendingImages extends StatelessWidget {
  const TrendingImages({
    Key? key,
    required this.controller,
  }) : super(key: key);

  final ShopController controller;

  @override
  Widget build(BuildContext context) {
    return Obx(() => controller.trendingImagesList.isNotEmpty
        ? CarouselSlider(
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
                    fit: BoxFit.fill,
                    imageUrl: '${i.name}',
                    placeholder: (context, url) =>
                        Center(child: CircularProgressIndicator()),
                    errorWidget: (context, url, error) => Icon(Icons.error),
                  ),
                ),
              );
            }).toList(),
          )
        : Container(
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
          ));
  }
}
