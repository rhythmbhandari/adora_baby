import 'package:adora_baby/app/config/app_colors.dart';
import 'package:adora_baby/app/data/models/hot_sales_model.dart';
import 'package:adora_baby/app/data/repositories/cart_repository.dart';
import 'package:adora_baby/app/widgets/buttons.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';

import '../../../../main.dart';
import '../../../config/app_theme.dart';
import '../../../config/constants.dart';
import '../../../routes/app_pages.dart';
import '../../../widgets/bottom_nav_bar.dart';
import '../../../widgets/gradient_icon.dart';
import '../../../widgets/tab_bar.dart';
import '../controllers/cart_controller.dart';

class ProductDetails extends StatefulWidget {
  const ProductDetails({Key? key}) : super(key: key);

  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails>
    with SingleTickerProviderStateMixin {
  final CartController controller = Get.find();
  CarouselController carouselController = CarouselController();

  TabController? _controller;
  int _selectedTabbar = 0;

  @override
  void initState() {
    super.initState();
    _controller = TabController(length: 3, vsync: this);
    _controller?.addListener(_handleTabSelection);
  }

  void _handleTabSelection() {
    setState(() {});
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    HotSales product = Get.arguments;

    return Scaffold(
      backgroundColor: const Color.fromRGBO(250, 245, 252, 1),
      body: SafeArea(
        child: Stack(
          children: [
            SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    width: double.infinity,
                    height: 88,
                    color: Colors.white,
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 30.0),
                          child: GestureDetector(
                              onTap: () {
                                Get.back();
                              },
                              child: const Icon(
                                Icons.arrow_back_ios,
                                color: Colors.black,
                              )),
                        ),
                        const SizedBox(
                          width: 60,
                        ),
                        Center(
                          child: Text(
                            "Product Detail",
                            style: kThemeData.textTheme.displaySmall,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 30, vertical: 30),
                    color: Colors.white,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          product.shortName,
                          maxLines: 1,
                          style: kThemeData.textTheme.labelSmall?.copyWith(
                              color: AppColors.secondary700, fontSize: 12),
                        ),
                        Text(
                          product.name,
                          style: kThemeData.textTheme.displaySmall
                              ?.copyWith(color: AppColors.primary700),
                        ),
                        const SizedBox(
                          height: 17.39,
                        ),
                        RatingBar.builder(
                          initialRating: product.rating.gradeAvg,
                          ignoreGestures: true,
                          itemSize: 17,
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
                        const SizedBox(
                          height: 10,
                        ),
                        Container(
                          padding: const EdgeInsets.only(left: 10, right: 10),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                  color:
                                      const Color.fromRGBO(229, 159, 164, 1))),
                          child: const Text(
                            "Supported Sitter",
                            style: TextStyle(
                                fontFamily: "Poppins",
                                fontSize: 16,
                                fontStyle: FontStyle.italic,
                                fontWeight: FontWeight.w600,
                                color: Color.fromRGBO(151, 121, 142, 1)),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        CarouselSlider(
                          options: CarouselOptions(
                            height: Get.height * 0.32,
                            autoPlay: true,
                            autoPlayInterval: Duration(seconds: 3),
                            autoPlayAnimationDuration:
                                Duration(milliseconds: 800),
                            autoPlayCurve: Curves.fastOutSlowIn,
                            enlargeCenterPage: true,
                            viewportFraction: 1,
                            aspectRatio: 2.0,
                            enableInfiniteScroll: false,
                            padEnds: false,
                            onPageChanged: (val, _) {
                              setState(() {
                                print("new index $val");
                                carouselController.jumpToPage(val);
                              });
                            },
                            // clipBehavior: Clip.antiAlias,
                            // onPageChanged: callbackFunction,
                            scrollDirection: Axis.horizontal,
                          ),
                          items: product.productImages.map((i) {
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
                        ),
                        // InkWell(
                        //   onTap: () {
                        //     carouselController.nextPage(
                        //         duration: const Duration(milliseconds: 300), curve:   Curves.linear);
                        //   },
                        //   child: Container(
                        //     height: 40,
                        //     width: 40,
                        //     decoration: BoxDecoration(
                        //       shape: BoxShape.circle,
                        //       color: Color(0xff000000),
                        //     ),
                        //   ),
                        // ),
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            product.stockAvailable == true
                                ? const Text(
                                    "In Stock",
                                    style: TextStyle(
                                      color: Colors.green,
                                      fontFamily: "Poppins",
                                      fontSize: 16,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  )
                                : const Text(
                                    "Out of Stock",
                                    style: TextStyle(
                                      color: Colors.red,
                                      fontFamily: "Poppins",
                                      fontSize: 16,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                            SvgPicture.asset("assets/images/send.svg")
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        product.salePrice == 0
                            ? Text(
                                "Rs. ${product.regularPrice}",
                                style: kThemeData.textTheme.titleLarge,
                              )
                            : Row(
                                children: [
                                  Text(
                                    "Rs. ${product.regularPrice}",
                                    style: kThemeData.textTheme.titleLarge
                                        ?.copyWith(
                                            color: DarkTheme.lightActive,
                                            decoration:
                                                TextDecoration.lineThrough),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    "Rs. ${product.salePrice}",
                                    style: kThemeData.textTheme.titleLarge,
                                  ),
                                ],
                              ),
                        SizedBox(
                          height: 14,
                        ),
                        product.weightInGrams != null
                            ? Text(product.weightInGrams.toString(),
                                style: const TextStyle(
                                  color: Colors.grey,
                                  fontFamily: "Poppins",
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                ))
                            : const Text("Weight N/A",
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontFamily: "Poppins",
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                )),
                        SizedBox(
                          height: 8,
                        ),
                        Text("Best by: ${product.bestBy}",
                            style: const TextStyle(
                              color: Colors.black,
                              fontFamily: "Poppins",
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            )),
                        SizedBox(
                          height: 8,
                        ),
                        Text("Delivered within: 2-3 business days.",
                            style: TextStyle(
                              color: Colors.grey,
                              fontFamily: "Poppins",
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                            ))
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    color: Colors.white,
                    padding: EdgeInsets.symmetric(horizontal: 43, vertical: 10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Quantity",
                          style: kThemeData.textTheme.titleLarge,
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            GestureDetector(
                              onTap: () {
                                controller.decrementCounter();
                              },
                              child: Container(
                                padding: const EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border: Border.all(color: Colors.black)),
                                child: const Icon(
                                  Icons.remove,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 14,
                            ),
                            Container(
                                padding: const EdgeInsets.only(
                                    left: 40, right: 40, top: 5, bottom: 5),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(color: Colors.black)),
                                child: Obx(
                                  () => Text(
                                    controller.counter.value.toString(),
                                    style: const TextStyle(
                                        color: Colors.black,
                                        fontFamily: 'Poppins',
                                        fontWeight: FontWeight.w700,
                                        fontSize: 20),
                                  ),
                                )),
                            SizedBox(
                              width: 14,
                            ),
                            GestureDetector(
                              onTap: () {
                                controller.incrementCounter();
                              },
                              child: Container(
                                padding: const EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border: Border.all(color: Colors.black)),
                                child: const Icon(
                                  Icons.add,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 30,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    color: Colors.white,
                    child: Column(children: [
                      TabBar(
                        onTap: (index) {
                          print(index);
                          setState(() {
                            _selectedTabbar = index;
                          });
                        },
                        indicatorColor: Colors.black,
                        controller: _controller,
                        unselectedLabelColor: Colors.black,
                        labelColor: Colors.black,
                        tabs: [
                          Tab(
                            text: "Overview",
                          ),
                          Tab(
                            text: "Details",
                          ),
                          Tab(
                            text: "Reviews",
                          ),
                        ],
                      ),
                      Builder(builder: (_) {
                        if (_selectedTabbar == 0) {
                          return Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 46, vertical: 20),
                            child: Text(
                              product.shortDescription,
                              style: kThemeData.textTheme.bodyLarge,
                            ),
                          ); //1st custom tabBarView
                        } else if (_selectedTabbar == 1) {
                          return Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 46, vertical: 20),
                            child: Text(
                              product.longDescription,
                              style: kThemeData.textTheme.bodyLarge,
                            ),
                          ); //1st/2nd tabView
                        } else {
                          return Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 46, vertical: 20),
                            child: ListView.builder(
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                itemCount: product.reviews.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            height: 40,
                                            width: 40,
                                            decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: Color(0xff000000),
                                            ),
                                            // child: Image.network(
                                            //   product.reviews[index].product,
                                            //   height: 100,
                                            // ),
                                          ),
                                          SizedBox(
                                            width: 16,
                                          ),
                                          Expanded(
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  product.reviews[index]
                                                      .createdBy.fullName,
                                                  style: kThemeData
                                                      .textTheme.titleMedium
                                                      ?.copyWith(
                                                          color:
                                                              DarkTheme.dark),
                                                ),
                                                RatingBar.builder(
                                                  initialRating: double.parse(
                                                      product.reviews[index]
                                                          .grade),
                                                  ignoreGestures: true,
                                                  itemSize: 17,
                                                  direction: Axis.horizontal,
                                                  allowHalfRating: true,
                                                  glow: false,
                                                  itemCount: 5,
                                                  itemPadding:
                                                      EdgeInsets.symmetric(
                                                          horizontal: 0.0),
                                                  itemBuilder: (context, _) =>
                                                      GradientIcon(
                                                    Icons.star,
                                                    10.0,
                                                    LinearGradient(
                                                      colors: <Color>[
                                                        Color.fromRGBO(
                                                            127, 0, 255, 1),
                                                        Color.fromRGBO(
                                                            255, 0, 255, 1)
                                                      ],
                                                      begin: Alignment.topLeft,
                                                      end:
                                                          Alignment.bottomRight,
                                                    ),
                                                  ),
                                                  onRatingUpdate: (rating) {
                                                    print(rating);
                                                  },
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 11),
                                      Text(
                                        product.reviews[index].review,
                                        style: kThemeData.textTheme.bodyLarge
                                            ?.copyWith(color: DarkTheme.dark),
                                      ),
                                    ],
                                  );
                                }),
                          ); //3rd tabView
                        }
                      }),
                      SizedBox(
                        height: 100,
                      )
                    ]),
                  )
                ],
              ),
            ),
            Positioned(
              bottom: 0,
              child: Container(
                width: Get.width,
                color: const Color.fromRGBO(243, 234, 249, 1),
                padding: EdgeInsets.symmetric(vertical: 10),
                child: Center(
                    child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 30.0, top: 10, bottom: 7),
                      child: ButtonsWidget(
                        name: "ADD TO CART",
                        onPressed: () {
                          controller.requestAddToCart(product.id);
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 30),
                      child: SvgPicture.asset('assets/images/like.svg'),
                    )
                  ],
                )),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
