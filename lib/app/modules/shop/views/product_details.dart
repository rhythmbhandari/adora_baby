import 'dart:developer';

import 'package:adora_baby/app/config/app_colors.dart';
import 'package:adora_baby/app/data/models/hot_sales_model.dart';
import 'package:adora_baby/app/data/repositories/cart_repository.dart';
import 'package:adora_baby/app/modules/cart/controllers/cart_controller.dart';
import 'package:adora_baby/app/modules/shop/controllers/shop_controller.dart';
import 'package:adora_baby/app/widgets/buttons.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';

import 'package:get/get.dart';
import 'package:html/parser.dart';
import 'package:share_plus/share_plus.dart';

import '../../../../main.dart';
import '../../../config/app_theme.dart';
import '../../../config/constants.dart';
import '../../../data/models/reviews.dart';
import '../../../routes/app_pages.dart';
import '../../../widgets/bottom_nav_bar.dart';
import '../../../widgets/gradient_icon.dart';
import '../../home/controllers/home_controller.dart';
import '../widgets/auth_progress_indicator.dart';
import 'getBrandName.dart';
import 'review_add.dart';
import 'package:url_launcher/url_launcher.dart';

class ProductDetails extends StatefulWidget {
  const ProductDetails({Key? key}) : super(key: key);

  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails>
    with SingleTickerProviderStateMixin {
  final ShopController controller = Get.find();
  CarouselController carouselController = CarouselController();

  TabController? _controller;
  int _selectedTabbar = 0;

  @override
  void initState() {
    super.initState();
    _controller = TabController(length: 3, vsync: this);
    _controller?.addListener(_handleTabSelection);
    controller.counter.value = 1;
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
    return progressWrap(
      Scaffold(
        backgroundColor: LightTheme.white,
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
                            child: GestureDetector(
                              onTap: () {
                                log('it is ${controller.productSelected.value.id}');
                              },
                              child: Text(
                                "Product Detail",
                                style: kThemeData.textTheme.displaySmall,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      height: 10,
                      color: LightTheme.whiteActive,
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 30, vertical: 30),
                      color: Colors.white,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            getBrandName(
                                controller.productSelected.value.categories),
                            maxLines: 1,
                            style: kThemeData.textTheme.labelSmall?.copyWith(
                                color: AppColors.secondary700, fontSize: 12),
                          ),
                          Text(
                            '${controller.productSelected.value.name}',
                            style: kThemeData.textTheme.displaySmall
                                ?.copyWith(color: AppColors.primary700),
                          ),
                          const SizedBox(
                            height: 17.39,
                          ),
                          RatingBar.builder(
                            initialRating:
                                controller.productSelected.value.rating == null
                                    ? 0.0
                                    : controller
                                        .productSelected.value.rating!.gradeAvg,
                            ignoreGestures: true,
                            itemSize: 17,
                            direction: Axis.horizontal,
                            allowHalfRating: true,
                            glow: false,
                            itemCount: 5,
                            itemPadding:
                                const EdgeInsets.symmetric(horizontal: 0.0),
                            itemBuilder: (context, _) => GradientIcon(
                              Icons.star,
                              10.0,
                              const LinearGradient(
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
                                    color: const Color.fromRGBO(
                                        229, 159, 164, 1))),
                            child: Text(
                              "${controller.productSelected.value.categories![0]?.name}",
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
                          controller.productSelected.value.productImages
                                      ?.isEmpty ??
                                  false
                              ? Container(
                                  height: Get.height * 0.32,
                                  margin: EdgeInsets.symmetric(
                                    vertical: 20,
                                  ),
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 18),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(20.0),
                                    child: CachedNetworkImage(
                                      fit: BoxFit.cover,
                                      imageUrl:
                                          'https://sternbergclinic.com.au/wp-content/uploads/2020/03/placeholder.png',
                                      placeholder: (context, url) =>
                                          const Center(
                                              child:
                                                  CircularProgressIndicator()),
                                      errorWidget: (context, url, error) =>
                                          const Icon(Icons.error),
                                    ),
                                  ),
                                )
                              : CarouselSlider(
                                  options: CarouselOptions(
                                    height: Get.height * 0.32,
                                    autoPlay: true,
                                    autoPlayInterval:
                                        const Duration(seconds: 3),
                                    autoPlayAnimationDuration:
                                        const Duration(milliseconds: 800),
                                    autoPlayCurve: Curves.fastOutSlowIn,
                                    enlargeCenterPage: true,
                                    viewportFraction: 1,
                                    aspectRatio: 2.0,
                                    enableInfiniteScroll: false,
                                    padEnds: false,
                                    onPageChanged: (val, _) {
                                      // setState(() {
                                      //   print("new index $val");
                                      //   carouselController.jumpToPage(val);
                                      // });
                                    },
                                    // clipBehavior: Clip.antiAlias,
                                    // onPageChanged: callbackFunction,
                                    scrollDirection: Axis.horizontal,
                                  ),
                                  items: controller
                                      .productSelected.value.productImages
                                      ?.map((i) {
                                    return Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 18),
                                      child: ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(20.0),
                                        child: CachedNetworkImage(
                                          fit: BoxFit.cover,
                                          imageUrl: i?.name == null
                                              ? 'https://sternbergclinic.com.au/wp-content/uploads/2020/03/placeholder.png'
                                              : '${i?.name}',
                                          placeholder: (context, url) =>
                                              const Center(
                                                  child:
                                                      CircularProgressIndicator()),
                                          errorWidget: (context, url, error) =>
                                              const Icon(Icons.error),
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
                              controller.productSelected.value.stockAvailable ==
                                      true
                                  ? Text(
                                      "In Stock",
                                      style: kThemeData.textTheme.titleMedium
                                          ?.copyWith(
                                              color: AppColors.success800,
                                              fontSize: 16),
                                    )
                                  : const Text(
                                      "Out of Stock",
                                      style: TextStyle(
                                        color: AppColors.error500,
                                        fontFamily: "Poppins",
                                        fontSize: 16,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                              GestureDetector(
                                  onTap: () {
                                    Share.share(
                                        'Check out Adora Baby ${controller.productSelected.value.permalink}',
                                        subject: 'Look at this product!');
                                  },
                                  child: SvgPicture.asset(
                                      "assets/images/send.svg"))
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          controller.productSelected.value.salePrice == 0 ||
                                  controller.productSelected.value.salePrice ==
                                      null
                              ? Text(
                                  "Rs. ${controller.productSelected.value.regularPrice}",
                                  style: kThemeData.textTheme.titleLarge,
                                )
                              : Row(
                                  children: [
                                    Text(
                                      "Rs. ${controller.productSelected.value.regularPrice}",
                                      style: kThemeData.textTheme.titleLarge
                                          ?.copyWith(
                                              color: DarkTheme.lightActive,
                                              decoration:
                                                  TextDecoration.lineThrough),
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    controller.productSelected.value
                                                .salePrice !=
                                            null
                                        ? Text(
                                            "Rs. ${controller.productSelected.value.salePrice}",
                                            style:
                                                kThemeData.textTheme.titleLarge,
                                          )
                                        : const Text("N/A")
                                  ],
                                ),
                          const SizedBox(
                            height: 14,
                          ),
                          controller.productSelected.value.weightInGrams != null
                              ? Text(
                                  'Weight: ' +
                                      controller
                                          .productSelected.value.weightInGrams
                                          .toString() +
                                      ' grams',
                                  style: const TextStyle(
                                    color: Colors.grey,
                                    fontFamily: "Poppins",
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                  ))
                              : const Text("Weight: N/A",
                                  style: TextStyle(
                                    color: Colors.grey,
                                    fontFamily: "Poppins",
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                  )),
                          const SizedBox(
                            height: 8,
                          ),
                          Text(
                              "Best by: ${controller.productSelected.value.bestBy?.year}/${controller.productSelected.value.bestBy?.month}/${controller.productSelected.value.bestBy?.day}",
                              style: const TextStyle(
                                color: Colors.black,
                                fontFamily: "Poppins",
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                              )),
                          const SizedBox(
                            height: 8,
                          ),
                          const Text("Delivered within: 2-3 business days.",
                              style: TextStyle(
                                color: Colors.grey,
                                fontFamily: "Poppins",
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                              ))
                        ],
                      ),
                    ),
                    Container(
                      height: 10,
                      color: LightTheme.whiteActive,
                    ),
                    Container(
                      color: Colors.white,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 43, vertical: 10),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Quantity",
                            style: kThemeData.textTheme.titleLarge?.copyWith(
                                color: DarkTheme.normal, fontSize: 28),
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          GetBuilder<ShopController>(
                            id: 'shopIncremenet',
                            builder: (myController) => Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    myController.decrementCounter();
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.all(12),
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        border: Border.all(
                                            color: DarkTheme.normal)),
                                    child: const Icon(
                                      Icons.remove,
                                      color: DarkTheme.normal,
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  width: 14,
                                ),
                                Expanded(
                                  flex: 3,
                                  child: Container(
                                      padding: const EdgeInsets.only(
                                          left: 30,
                                          right: 30,
                                          top: 5,
                                          bottom: 5),
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          border: Border.all(
                                              color: DarkTheme.normal)),
                                      child: Center(
                                        child: Text(
                                          myController.counter.value.toString(),
                                          style: const TextStyle(
                                              color: DarkTheme.darkNormal,
                                              fontFamily: 'Poppins',
                                              fontWeight: FontWeight.w700,
                                              fontSize: 28),
                                        ),
                                      )),
                                ),
                                const SizedBox(
                                  width: 14,
                                ),
                                GestureDetector(
                                  onTap: () {
                                    log(controller
                                        .productSelected.value.stockQuantity
                                        .toString());
                                    if (myController.counter.value ==
                                        (controller.productSelected.value
                                                .stockQuantity ??
                                            1)) {
                                      var snackBar = SnackBar(
                                        elevation: 0,
                                        behavior: SnackBarBehavior.floating,
                                        backgroundColor: AppColors.secondary500,
                                        duration:
                                            const Duration(milliseconds: 2000),
                                        content:
                                            Text("No more stock available."),
                                      );
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(snackBar);
                                    } else {
                                      myController.incrementCounter(controller
                                              .productSelected
                                              .value
                                              .stockQuantity ??
                                          1);
                                    }
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.all(12),
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        border: Border.all(
                                            color: DarkTheme.normal)),
                                    child: const Icon(
                                      Icons.add,
                                      color: DarkTheme.normal,
                                    ),
                                  ),
                                ),
                                const Expanded(
                                  flex: 4,
                                  child: SizedBox(),
                                )
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                        ],
                      ),
                    ),
                    Container(
                      height: 10,
                      color: LightTheme.whiteActive,
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
                          indicatorSize: TabBarIndicatorSize.label,
                          labelColor: Colors.black,
                          labelStyle: kThemeData.textTheme.labelMedium
                              ?.copyWith(color: DarkTheme.normal),
                          tabs: [
                            const Tab(
                              text: "Overview",
                            ),
                            const Tab(
                              text: "Details",
                            ),
                            const Tab(
                              text: "Reviews",
                            ),
                          ],
                        ),
                        Builder(builder: (_) {
                          if (_selectedTabbar == 0) {
                            return Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 46, vertical: 20),
                              child: HtmlWidget(
                                controller.productSelected.value
                                        .shortDescription ??
                                    '',
                                enableCaching: true,
                                textStyle: kThemeData.textTheme.bodyLarge,
                              ),
                            ); //1st custom tabBarView
                          } else if (_selectedTabbar == 1) {
                            return Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 46, vertical: 20),
                              child: HtmlWidget(
                                controller.productSelected.value
                                        .longDescription ??
                                    '',
                                enableCaching: true,
                                onTapUrl: (urlLauncher) async {
                                  Uri url = Uri.parse(urlLauncher);
                                  if (await canLaunchUrl(url)) {
                                    await launchUrl(url);
                                    return true;
                                  } else {
                                    throw 'Could not launch $url';
                                  }
                                },
                                textStyle: kThemeData.textTheme.bodyLarge,
                              ),
                            ); //1st/2nd tabView
                          } else {
                            return Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 46, vertical: 20),
                              child: Column(
                                children: [
                                  TextField(
                                    cursorColor: AppColors.mainColor,
                                    onTap: () {
                                      Get.to(() => AddReview(),
                                          arguments:
                                              controller.productSelected.value);
                                    },
                                    // focusNode: searchNode,
                                    autofocus: false,
                                    enabled: true,
                                    readOnly: true,
                                    decoration: InputDecoration(
                                      hintText: 'Add Review',
                                      hintStyle: kThemeData.textTheme.bodyLarge
                                          ?.copyWith(
                                              color: Color.fromRGBO(
                                        175,
                                        152,
                                        168,
                                        1,
                                      )),
                                      contentPadding:
                                          const EdgeInsets.symmetric(
                                              horizontal: 24, vertical: 18),
                                      suffixIcon: Padding(
                                        padding: const EdgeInsets.only(
                                            top: 8.0, right: 23, bottom: 8),
                                        child: Icon(
                                          Icons.arrow_forward_ios,
                                          color: DarkTheme.darkNormal
                                              .withOpacity(0.8),
                                        ),
                                      ),
                                      fillColor: Colors.white,
                                      focusedBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(33),
                                          borderSide: const BorderSide(
                                              width: 1,
                                              color: Color.fromRGBO(
                                                  175, 152, 168, 1))),
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(33),
                                          borderSide: const BorderSide(
                                              width: 1,
                                              color: Color.fromRGBO(
                                                  175, 152, 168, 1))),
                                      enabledBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(33),
                                          borderSide: const BorderSide(
                                              width: 1,
                                              color: Color.fromRGBO(
                                                  175, 152, 168, 1))),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 23,
                                  ),
                                  GetBuilder<ShopController>(
                                    id: 'reviewId',
                                    builder: (myController) =>
                                        FutureBuilder<List<Reviews>>(
                                      future: myController.initiateGetReviews(
                                          myController.countingReview.value),
                                      builder: (context, snapshot) {
                                        if (snapshot.hasData) {
                                          if (snapshot.data != null &&
                                              snapshot.data!.isNotEmpty) {
                                            return ListView.builder(
                                                shrinkWrap: true,
                                                physics:
                                                    const NeverScrollableScrollPhysics(),
                                                itemCount:
                                                    snapshot.data?.length ?? 0,
                                                itemBuilder:
                                                    (BuildContext context,
                                                        int index) {
                                                  return Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .start,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Container(
                                                            height: 40,
                                                            width: 40,
                                                            decoration:
                                                                const BoxDecoration(
                                                              shape: BoxShape
                                                                  .circle,
                                                              color: Color(
                                                                  0xff000000),
                                                            ),
                                                            child: snapshot.data !=
                                                                        null &&
                                                                    snapshot
                                                                        .data?[
                                                                            index]
                                                                        .createdBy
                                                                        ?.profilePhoto
                                                                        .isNotEmpty
                                                                ? ClipRRect(
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            100.0),
                                                                    child:
                                                                        CachedNetworkImage(
                                                                      fit: BoxFit
                                                                          .cover,
                                                                      height: Get
                                                                              .height *
                                                                          0.06,
                                                                      width: Get
                                                                              .height *
                                                                          0.06,
                                                                      imageUrl:
                                                                          '${snapshot.data?[index].createdBy?.profilePhoto['name']}' ??
                                                                              'https://sternbergclinic.com.au/wp-content/uploads/2020/03/placeholder.png',
                                                                      placeholder: (context,
                                                                              url) =>
                                                                          const Center(
                                                                              child: CircularProgressIndicator()),
                                                                      errorWidget: (context,
                                                                              url,
                                                                              error) =>
                                                                          const Icon(
                                                                              Icons.error),
                                                                    ),
                                                                  )
                                                                : Container(),
                                                          ),
                                                          const SizedBox(
                                                            width: 16,
                                                          ),
                                                          Expanded(
                                                            child: Column(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .start,
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              children: [
                                                                Text(
                                                                  '${snapshot.data?[index].createdBy?.fullName}',
                                                                  style: kThemeData
                                                                      .textTheme
                                                                      .titleMedium
                                                                      ?.copyWith(
                                                                          color:
                                                                              DarkTheme.dark),
                                                                ),
                                                                RatingBar
                                                                    .builder(
                                                                  initialRating:
                                                                      double.parse(
                                                                          '${snapshot.data?[index].grade}'),
                                                                  ignoreGestures:
                                                                      true,
                                                                  itemSize: 17,
                                                                  direction: Axis
                                                                      .horizontal,
                                                                  allowHalfRating:
                                                                      true,
                                                                  glow: false,
                                                                  itemCount: 5,
                                                                  itemPadding: const EdgeInsets
                                                                          .symmetric(
                                                                      horizontal:
                                                                          0.0),
                                                                  itemBuilder:
                                                                      (context,
                                                                              _) =>
                                                                          GradientIcon(
                                                                    Icons.star,
                                                                    10.0,
                                                                    const LinearGradient(
                                                                      colors: <
                                                                          Color>[
                                                                        Color.fromRGBO(
                                                                            127,
                                                                            0,
                                                                            255,
                                                                            1),
                                                                        Color.fromRGBO(
                                                                            255,
                                                                            0,
                                                                            255,
                                                                            1)
                                                                      ],
                                                                      begin: Alignment
                                                                          .topLeft,
                                                                      end: Alignment
                                                                          .bottomRight,
                                                                    ),
                                                                  ),
                                                                  onRatingUpdate:
                                                                      (rating) {
                                                                    print(
                                                                        rating);
                                                                  },
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      const SizedBox(
                                                          height: 11),
                                                      Text(
                                                        '${snapshot.data?[index].review}',
                                                        style: kThemeData
                                                            .textTheme.bodyLarge
                                                            ?.copyWith(
                                                                color: DarkTheme
                                                                    .darkNormal),
                                                      ),
                                                      const SizedBox(
                                                          height: 20),
                                                    ],
                                                  );
                                                });
                                          } else {
                                            return Container();
                                          }
                                        } else if (snapshot.hasError) {
                                          return Container();
                                        }
                                        return Container();
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ); //3rd tabView
                          }
                        }),
                        const SizedBox(
                          height: 100,
                        )
                      ]),
                    )
                  ],
                ),
              ),
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  color: const Color.fromRGBO(243, 234, 249, 1),
                  padding: const EdgeInsets.only(
                      left: 30.0, top: 21, bottom: 21, right: 30),
                  child: GestureDetector(
                    onTap: () async {
                      controller.showProgressBarDetail();
                      final status = await controller.requestAddToCart(
                          '${controller.productSelected.value.id}');
                      if (status) {
                        const snackBar = SnackBar(
                          backgroundColor: Colors.green,
                          content: Text(
                            'Added to the cart successfully!',
                            style: TextStyle(color: Colors.white),
                          ),
                        );
                        try {
                          final CartController cartController = Get.find();
                          cartController.cart();

                          // final HomeController homeController = Get.find();
                          //
                          // homeController.isRedirected.value = 1;
                          // Get.until(
                          //   (route) => route.settings.name == Routes.HOME,
                          // );

                        } catch (e) {}
                        // Find the ScaffoldMessenger in the widget tree
                        // and use it to show a SnackBar.
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      } else {
                        final snackBar = SnackBar(
                          backgroundColor: Colors.red,
                          content: Text(
                            controller.authError.value,
                            style: TextStyle(color: Colors.white),
                          ),
                        );

                        // Find the ScaffoldMessenger in the widget tree
                        // and use it to show a SnackBar.
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      }

                      controller.hideProgressBarDetail();
                    },
                    child: Container(
                      padding: const EdgeInsets.only(
                          top: 20, bottom: 20, left: 90, right: 90),
                      decoration: BoxDecoration(
                        color: AppColors.primary500,
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Center(
                        child: Text("Add to Cart",
                            style: kThemeData.textTheme.labelMedium),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      controller.productDetailProgress,
    );
  }
}
