import 'dart:developer';

import 'package:adora_baby/app/modules/auth/controllers/auth_controllers.dart';
import 'package:adora_baby/app/data/repositories/shop_respository.dart';
import 'package:adora_baby/app/modules/shop/views/all_products_page.dart';
import 'package:adora_baby/app/routes/app_pages.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

import '../../../config/app_colors.dart';
import '../../../config/app_theme.dart';
import '../../../data/models/hot_sales_model.dart';
import '../../../widgets/custom_progress_bar.dart';
import '../../../widgets/gradient_icon.dart';
import '../controllers/shop_controller.dart';
import '../views/getBrandName.dart';

class AllProducts extends StatelessWidget {
  final ShopController controller;

  const AllProducts({required this.controller, super.key});

  @override
  Widget build(BuildContext context) {
    var index = 0;
    return Padding(
      padding:
          const EdgeInsets.only(left: 30.0, right: 30, top: 10, bottom: 15),
      child: Container(
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(20)),
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            GestureDetector(
              onTap: () {
                log('Parsed is ${controller.allProducts}');
              },
              child: const Center(
                child: Text(
                  "All Products",
                  style: TextStyle(
                    color: AppColors.primary500,
                    fontFamily: "PLayfair",
                    fontSize: 24,
                    fontWeight: FontWeight.w600,
                    letterSpacing: -0.01,
                  ),
                ),
              ),
            ),
            Padding(
                padding: const EdgeInsets.all(19.0),
                child: Obx(() => controller.allProducts.isNotEmpty
                    ? AlignedGridView.count(
                        crossAxisCount: 2,
                        mainAxisSpacing: 20,
                        crossAxisSpacing: 20,
                        shrinkWrap: true,
                        itemCount: controller.allProducts.length,
                        physics: NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              controller.productSelected.value =
                                  controller.allProducts[index];
                              Get.toNamed(Routes.PRODUCT_DETAILS);
                            },
                            child: Container(
                              padding: const EdgeInsets.only(top: 10),
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  border: Border.all(
                                      color: const Color.fromRGBO(
                                          192, 144, 254, 0.25)),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.5),
                                      spreadRadius: 1,
                                      blurRadius: 2,
                                      offset: Offset(
                                          0, 2), // changes position of shadow
                                    ),
                                  ],
                                  borderRadius: BorderRadius.circular(15)),
                              child: Column(
                                children: [
                                  Stack(
                                    children: [
                                      Container(
                                        margin:
                                            EdgeInsets.only(top: 12, bottom: 8),
                                        child: Center(
                                          child: Image.network(
                                            controller.allProducts[index]
                                                    .productImages.isEmpty
                                                ? 'https://sternbergclinic.com.au/wp-content/uploads/2020/03/placeholder.png'
                                                : '${controller.allProducts[index].productImages?.firstWhere(
                                                      (image) =>
                                                          image?.isFeaturedImage !=
                                                              null &&
                                                          image?.isFeaturedImage ==
                                                              true,
                                                      orElse: () => ProductImage(
                                                          name:
                                                              'https://sternbergclinic.com.au/wp-content/uploads/2020/03/placeholder.png'),
                                                    ).name ?? ''}',
                                            height: Get.height * 0.16,
                                          ),
                                        ),
                                      ),
                                      controller.allProducts[index].salePrice ==
                                              0
                                          ? Container()
                                          : Container(
                                              padding: const EdgeInsets.only(
                                                  top: 2,
                                                  bottom: 2,
                                                  left: 6,
                                                  right: 6),
                                              margin: EdgeInsets.symmetric(
                                                  horizontal: 8),
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                                gradient: const LinearGradient(
                                                  begin: Alignment.topRight,
                                                  end: Alignment.bottomLeft,
                                                  colors: [
                                                    AppColors.linear2,
                                                    AppColors.linear1,
                                                  ],
                                                ),
                                              ),
                                              child: const Text(
                                                "Sale!",
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontFamily: "Poppins",
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.w400,
                                                    fontStyle: FontStyle.normal,
                                                    letterSpacing: 0.04),
                                              ),
                                            ),
                                    ],
                                  ),
                                  Container(
                                    padding: const EdgeInsets.only(
                                        left: 13, right: 13),
                                    width: Get.width,
                                    decoration: const BoxDecoration(
                                        color: Color.fromRGBO(243, 234, 249, 1),
                                        borderRadius: BorderRadius.only(
                                            bottomRight: Radius.circular(15),
                                            bottomLeft: Radius.circular(15))),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                          height: 8,
                                        ),
                                        Text(
                                          getBrandName(controller
                                                  .allProducts[index]
                                                  .categories ??
                                              []),
                                          maxLines: 1,
                                          style: kThemeData.textTheme.labelSmall
                                              ?.copyWith(
                                                  color: AppColors.secondary700,
                                                  fontSize: 12),
                                        ),
                                        SizedBox(
                                          height: 4,
                                        ),
                                        Text(
                                          '${controller.allProducts[index].name}',
                                          maxLines: 2,
                                          style: kThemeData.textTheme.bodyMedium
                                              ?.copyWith(
                                                  color: AppColors.primary700,
                                                  fontSize: 14),
                                        ),
                                        SizedBox(
                                          height: 8,
                                        ),
                                        RatingBar.builder(
                                          initialRating: controller
                                                      .allProducts[index]
                                                      .rating ==
                                                  null
                                              ? 0.0
                                              : controller.allProducts[index]
                                                  .rating!.gradeAvg,
                                          ignoreGestures: true,
                                          itemSize: 12,
                                          direction: Axis.horizontal,
                                          allowHalfRating: true,
                                          glow: false,
                                          itemCount: 5,
                                          itemPadding: EdgeInsets.symmetric(
                                              horizontal: 0.0),
                                          itemBuilder: (context, _) =>
                                              GradientIcon(
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
                                        controller.allProducts[index]
                                                    .salePrice !=
                                                0
                                            ? Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(
                                                    "Rs. ${controller.allProducts[index].regularPrice}",
                                                    maxLines: 2,
                                                    style: kThemeData
                                                        .textTheme.bodyMedium
                                                        ?.copyWith(
                                                            color: DarkTheme
                                                                .lightActive,
                                                            decoration:
                                                                TextDecoration
                                                                    .lineThrough),
                                                  ),
                                                  Text(
                                                    "Rs. ${controller.allProducts[index].salePrice}",
                                                    maxLines: 2,
                                                    style: kThemeData
                                                        .textTheme.bodyMedium
                                                        ?.copyWith(
                                                            color: DarkTheme
                                                                .normal),
                                                  ),
                                                ],
                                              )
                                            : Text(
                                                "Rs. ${controller.allProducts[index].regularPrice}",
                                                maxLines: 2,
                                                style: kThemeData
                                                    .textTheme.bodyMedium
                                                    ?.copyWith(
                                                        color:
                                                            DarkTheme.normal),
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
                          );
                        },
                      )
                    : Shimmer.fromColors(
                        baseColor: Colors.white,
                        highlightColor: LightTheme.lightActive,
                        enabled: true,
                        child: _buildImage()))),
            GestureDetector(
              onTap: () {
                Get.toNamed(Routes.ALLPRODUCTS, arguments: true);
              },
              child: Align(
                alignment: Alignment.centerRight,
                child: Container(
                  padding: EdgeInsets.only(right: 18, bottom: 19),
                  child: Text(
                    'See All',
                    style: kThemeData.textTheme.labelMedium
                        ?.copyWith(color: AppColors.primary700, fontSize: 16),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

Widget _buildImage() {
  return GridView.count(
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
            border:
                Border.all(color: const Color.fromRGBO(192, 144, 254, 0.25)),
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
  );
}
