import 'package:adora_baby/app/config/app_theme.dart';
import 'package:adora_baby/app/data/models/stages_brands.dart' as a;
import 'package:adora_baby/app/data/repositories/shop_respository.dart';
import 'package:adora_baby/app/modules/shop/widgets/all_brands.dart';
import 'package:adora_baby/app/modules/shop/widgets/auth_progress_indicator.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

import '../../../widgets/gradient_icon.dart';

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

  @override
  Widget build(BuildContext context) {
    return progressWrap(
        Scaffold(
            backgroundColor: LightTheme.white,
            body: NewShopViewBody(controller: controller)),
        controller.progressStatus);
  }
}

class NewShopViewBody extends StatelessWidget {
  NewShopViewBody({
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
                            SvgPicture.asset("assets/images/filter-search.svg"),
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
                TrendingImages(controller: controller),
                HotSale(
                  controller: controller,
                ),
                AllProducts(controller: controller),
                // Obx(() => controller.isSelected.value
                //     ? const AllBrands()
                //     : Container()),
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

// class OldShopViewBody extends StatelessWidget {
//   const OldShopViewBody({
//     Key? key,
//     required this.controller,
//   }) : super(key: key);
//
//   final ShopController controller;
//
//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: SingleChildScrollView(
//         child: Column(
//           children: [
//             Padding(
//               padding: const EdgeInsets.only(top: 30.0),
//               child: Container(
//                 padding: const EdgeInsets.only(bottom: 20),
//                 color: Colors.white,
//                 child: Column(
//                   children: [
//                     const SizedBox(
//                       height: 20,
//                     ),
//                     GestureDetector(
//                       onTap: () {
//                         controller.getTrendingImages();
//                       },
//                       child: Text(
//                         "Shop",
//                         style: kThemeData.textTheme.displaySmall,
//                       ),
//                     ),
//                     Padding(
//                       padding:
//                           const EdgeInsets.only(left: 20.0, right: 20, top: 20),
//                       child: TextField(
//                         cursorColor: AppColors.mainColor,
//                         // focusNode: searchNode,
//                         autofocus: false,
//                         decoration: InputDecoration(
//                           hintText: 'Search for Items',
//                           hintStyle: kThemeData.textTheme.bodyLarge
//                               ?.copyWith(color: Color(0xffAF98A8)),
//                           contentPadding: const EdgeInsets.symmetric(
//                               horizontal: 16, vertical: 12),
//                           suffixIcon: Image.asset(
//                             'assets/images/search-normal.png',
//                             color: const Color.fromRGBO(84, 104, 129, 1),
//                           ),
//                           fillColor: Colors.white,
//                           focusedBorder: OutlineInputBorder(
//                               borderRadius: BorderRadius.circular(20),
//                               borderSide: const BorderSide(
//                                   width: 1,
//                                   color: Color.fromRGBO(175, 152, 168, 1))),
//                           border: OutlineInputBorder(
//                               borderRadius: BorderRadius.circular(20),
//                               borderSide: const BorderSide(
//                                   width: 1,
//                                   color: Color.fromRGBO(175, 152, 168, 1))),
//                           enabledBorder: OutlineInputBorder(
//                               borderRadius: BorderRadius.circular(20),
//                               borderSide: const BorderSide(
//                                   width: 1,
//                                   color: Color.fromRGBO(175, 152, 168, 1))),
//                         ),
//                       ),
//                     ),
//                     const SizedBox(
//                       height: 20,
//                     ),
//                     Padding(
//                       padding: const EdgeInsets.only(left: 40.0, right: 40),
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           GestureDetector(
//                             onTap: () {
//                               controller.showAlertDialog(context);
//                             },
//                             child: Row(
//                               children: [
//                                 SvgPicture.asset(
//                                     "assets/images/filter-search.svg"),
//                                 const Text(
//                                   "All Stages",
//                                   style: TextStyle(
//                                     color: Color.fromRGBO(241, 149, 157, 1),
//                                     //styleName: Button Text;
//                                     fontFamily: "Poppins",
//                                     fontSize: 16,
//                                     fontWeight: FontWeight.w600,
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                           GestureDetector(
//                               onTap: () {
//                                 controller.isSelected.value = true;
//                                 ShopRepository.brands();
//                               },
//                               child: Row(
//                                 children: [
//                                   SvgPicture.asset("assets/images/tag.svg"),
//                                   const Text(
//                                     "All Brands",
//                                     style: TextStyle(
//                                       color: Color.fromRGBO(241, 149, 157, 1),
//                                       //styleName: Button Text;
//                                       fontFamily: "Poppins",
//                                       fontSize: 16,
//                                       fontWeight: FontWeight.w600,
//                                     ),
//                                   ),
//                                 ],
//                               ))
//                         ],
//                       ),
//                     )
//                   ],
//                 ),
//               ),
//             ),
//             SizedBox(
//               height: 23,
//             ),
//             FutureBuilder<List>(
//               future: controller.getTrendingImages(),
//               builder: (context, snapshot) {
//                 if (snapshot.hasData) {
//                   if (snapshot.data != null && snapshot.data!.isNotEmpty) {
//                     return CarouselSlider(
//                       options: CarouselOptions(
//                         height: Get.height * 0.22,
//                         autoPlay: true,
//                         autoPlayInterval: Duration(seconds: 3),
//                         autoPlayAnimationDuration: Duration(milliseconds: 800),
//                         autoPlayCurve: Curves.fastOutSlowIn,
//                         enlargeCenterPage: true,
//                         viewportFraction: 1,
//                         aspectRatio: 2.0,
//                         padEnds: false,
//                         // clipBehavior: Clip.antiAlias,
//                         // onPageChanged: callbackFunction,
//                         scrollDirection: Axis.horizontal,
//                       ),
//                       items: controller.trendingImagesList.map((i) {
//                         return Container(
//                           padding: EdgeInsets.symmetric(horizontal: 18),
//                           child: ClipRRect(
//                             borderRadius: BorderRadius.circular(20.0),
//                             child: CachedNetworkImage(
//                               fit: BoxFit.cover,
//                               imageUrl: '${i.name}',
//                               placeholder: (context, url) =>
//                                   Center(child: CircularProgressIndicator()),
//                               errorWidget: (context, url, error) =>
//                                   Icon(Icons.error),
//                             ),
//                           ),
//                         );
//                       }).toList(),
//                     );
//                   } else {
//                     return Container(
//                       height: Get.height * 0.22,
//                       margin: EdgeInsets.symmetric(horizontal: 18),
//                       decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(20),
//                           color: Colors.white),
//                       child: Center(
//                         child: Text(
//                           "No Trending Images Available",
//                           textAlign: TextAlign.center,
//                           style: TextStyle(
//                               fontSize: 16,
//                               fontFamily: 'Graphik',
//                               color: Colors.red.withOpacity(0.67),
//                               letterSpacing: 1.25,
//                               fontWeight: FontWeight.w300),
//                         ),
//                       ),
//                     );
//                   }
//                 } else if (snapshot.hasError) {
//                   return const Center(
//                     child: Text("Sorry,not found!"),
//                   );
//                 }
//                 // return const CircleListItem();
//                 return Container(
//                   padding: EdgeInsets.symmetric(horizontal: 18),
//                   child: Shimmer.fromColors(
//                       baseColor: Colors.white,
//                       highlightColor: LightTheme.lightActive,
//                       child: Container(
//                         height: Get.height * 0.22,
//                         decoration: BoxDecoration(
//                             borderRadius: BorderRadius.circular(20),
//                             color: Colors.white),
//                       )),
//                 );
//               },
//             ),
//             HotSale(hotSales: ,),
//             RecentlyViewed(),
//             AllProducts(),
//             Obx(() =>
//                 controller.isSelected.value ? const AllBrands() : Container()),
//             Container(
//               height: Get.height * 0.1,
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }

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
