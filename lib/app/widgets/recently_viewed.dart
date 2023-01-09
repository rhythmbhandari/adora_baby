import 'package:adora_baby/app/modules/auth/controllers/auth_controllers.dart';
import 'package:adora_baby/app/data/repositories/shop_respository.dart';
import 'package:adora_baby/app/routes/app_pages.dart';
import 'package:adora_baby/app/modules/shop/widgets/hot_sales.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

import '../config/app_colors.dart';
import '../config/app_theme.dart';
import '../data/models/hot_sales_model.dart';
import 'custom_progress_bar.dart';
import 'gradient_icon.dart';

class RecentlyViewed extends StatelessWidget {
  final dynamic recentlyViewed;

  const RecentlyViewed({required this.recentlyViewed, super.key});

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
            const Center(
              child: Text(
                "Recently Viewed",
                style: TextStyle(
                  color: AppColors.primary500,
                  fontFamily: "PLayfair",
                  fontSize: 24,
                  fontWeight: FontWeight.w600,
                  letterSpacing: -0.01,
                ),
              ),
            ),
            FutureBuilder<List<List<HotSales>>>(
                future: recentlyViewed,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    if (snapshot.data != null &&
                        snapshot.data!.isNotEmpty &&
                        snapshot.data!.length > index) {
                      return _buildFeaturedCards(snapshot);
                    }
                  } else if (snapshot.hasError) {
                    print(snapshot.error);
                    return const Center(
                      child: Text("Sorry,not found!"),
                    );
                  }

                  return Shimmer.fromColors(
                      baseColor: Colors.white,
                      highlightColor: LightTheme.lightActive,
                      enabled: true,
                      child: _buildImage());
                }),
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

Widget _buildFeaturedCards(AsyncSnapshot<List<List<HotSales>>> product) {
  final cards = <Widget>[];
  Widget FeaturedCard;

  if (product != null) {
    for (int i = 0; i < product.data![0].length; i++) {
      cards.add(RecentlyViewedProducts(snapshot: product, index: i));
      print(product.data![0].length);
    }
    FeaturedCard = Container(
      padding: EdgeInsets.only(top: 16, bottom: 16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(children: cards),
          ),
        ],
      ),
    );
  } else {
    FeaturedCard = Container();
  }
  return FeaturedCard;
}

class RecentlyViewedProducts extends StatelessWidget {
  int index;
  AsyncSnapshot<List<List<HotSales>>> snapshot;

  RecentlyViewedProducts(
      {super.key, required this.index, required this.snapshot});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        print("Data is ${snapshot.data![0][index].name}");
        Get.toNamed(Routes.PRODUCT_DETAILS, arguments: snapshot.data![0][index]);
      },
      child: Container(
        padding: const EdgeInsets.only(top: 10),
        margin: const EdgeInsets.only(right: 0, bottom: 10, left: 19),
        width: Get.width * 0.35,
        alignment: Alignment.center,
        decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: const Color.fromRGBO(192, 144, 254, 0.25)),
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
                      '${snapshot.data![0][index].productImages![0]?.name}',
                      height: Get.height * 0.16,
                    ),
                  ),
                ),
                snapshot.data![0][index].salePrice == 0
                    ? Container()
                    : Container(
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
                    '${snapshot.data![0][index].shortName}',
                    maxLines: 1,
                    style: kThemeData.textTheme.labelSmall
                        ?.copyWith(color: AppColors.secondary700, fontSize: 12),
                  ),
                  SizedBox(
                    height: 4,
                  ),
                  Text(
                    '${snapshot.data![0][index].name}',
                    maxLines: 2,
                    style: kThemeData.textTheme.bodyMedium
                        ?.copyWith(color: AppColors.primary700, fontSize: 14),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  RatingBar.builder(
                    initialRating: snapshot.data![0][index].rating == null ? 0.0: snapshot.data![0][index].rating!.gradeAvg,
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
                  snapshot.data![0][index]
                      .salePrice != 0?  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Rs. ${snapshot.data![0][index].regularPrice}",
                        maxLines: 2,
                        style: kThemeData
                            .textTheme.bodyMedium
                            ?.copyWith(
                            color:
                            DarkTheme.lightActive,
                            decoration: TextDecoration
                                .lineThrough),
                      ),
                      Text(
                        "Rs. ${snapshot.data![0][index].salePrice}",
                        maxLines: 2,
                        style: kThemeData
                            .textTheme.bodyMedium
                            ?.copyWith(
                            color:
                            DarkTheme.normal),
                      ),
                    ],
                  ): Text(
                    "Rs. ${snapshot.data![0][index].regularPrice}",
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
  }
}
