
import 'package:adora_baby/app/config/app_theme.dart';
import 'package:adora_baby/app/modules/profile/controllers/profile_controller.dart';
import 'package:adora_baby/app/modules/shop/views/notifications_view.dart';
import 'package:adora_baby/app/modules/shop/widgets/auth_progress_indicator.dart';
import 'package:adora_baby/app/widgets/tips_widget.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../routes/app_pages.dart';
import '../../../widgets/gradient_icon.dart';

import '../../cart/controllers/cart_controller.dart';
import '../../profile/views/diamonds_view.dart';
import '../widgets/all_products.dart';
import '../widgets/hot_sales.dart';

import '../../../config/app_colors.dart';
import '../controllers/shop_controller.dart';
import '../widgets/trending_images.dart';

class ShopView extends GetView<ShopController> {
  ShopView({Key? key}) : super(key: key);

  final ProfileController profileController = Get.find();
  final CartController cartController = Get.find();

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
  NewShopViewBody({
    Key? key,
    required this.controller,
    required this.profileController,
  }) : super(key: key);

  final ShopController controller;
  final ProfileController profileController;

  final RefreshController _refreshControllerShop =
      RefreshController(initialRefresh: false);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: SmartRefresher(
      physics: const AlwaysScrollableScrollPhysics(),
      enablePullDown: true,
      enablePullUp: false,
      header: ClassicHeader(
        refreshStyle: RefreshStyle.Follow,
        releaseIcon: const SizedBox(
            width: 25.0, height: 25.0, child: CupertinoActivityIndicator()),
        failedIcon: const Icon(Icons.error, color: Colors.grey),
        idleIcon: const SizedBox(
            width: 25.0,
            height: 25.0,
            child: CupertinoActivityIndicator.partiallyRevealed(
              progress: 0.4,
            )),
        textStyle: Get.textTheme.headline5!.copyWith(
            fontFamily: 'Roboto',
            color: Get.theme.primaryColor,
            fontWeight: FontWeight.w500),
        releaseText: '',
        idleText: '',
        failedText: '',
        completeText: '',
        refreshingText: '',
        refreshingIcon: const SizedBox(
            width: 25.0, height: 25.0, child: CupertinoActivityIndicator()),
      ),
      footer: ClassicFooter(
        // refreshStyle: RefreshStyle.Follow,
        canLoadingText: '',
        loadStyle: LoadStyle.ShowWhenLoading,
        noDataText: '',
        noMoreIcon: const SizedBox(
            width: 25.0,
            height: 25.0,
            child: Icon(Icons.expand_circle_down, color: Colors.red)),
        canLoadingIcon: const SizedBox(
            width: 25.0, height: 25.0, child: CupertinoActivityIndicator()),
        failedIcon: const Icon(Icons.error, color: Colors.grey),
        idleIcon: const SizedBox(
            width: 25.0,
            height: 25.0,
            child: CupertinoActivityIndicator.partiallyRevealed(
              progress: 0.4,
            )),
        textStyle: Get.textTheme.headline5!.copyWith(
            fontFamily: 'Roboto',
            color: Get.theme.primaryColor,
            fontWeight: FontWeight.w500),
        idleText: '',
        failedText: '',
        loadingText: '',
        loadingIcon: const SizedBox(
            width: 25.0, height: 25.0, child: CupertinoActivityIndicator()),
      ),
      controller: _refreshControllerShop,
      onRefresh: () {
        controller
            .fetchData()
            .then((value) => _refreshControllerShop.refreshCompleted());
      },
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
                    padding: const EdgeInsets.symmetric(horizontal: 41),
                    child: GetBuilder<ProfileController>(
                      id: 'homePageProfile',
                      builder: (value) => Row(
                        children: [
                          Center(
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(100.0),
                              child: CachedNetworkImage(
                                fit: BoxFit.cover,
                                height: Get.height * 0.06,
                                width: Get.height * 0.06,
                                imageUrl: value.babyPhotoUrl.value,
                                placeholder: (context, url) => const Center(
                                    child: CircularProgressIndicator()),
                                errorWidget: (context, url, error) =>
                                    const Icon(Icons.error),
                              ),
                            ),
                          ),
                          const SizedBox(
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
                                Row(
                                  children: [
                                    Text(
                                      '${(DateTime.now().difference(value.user.value.babyDob != null ? value.user.value.babyDob! : DateTime.now()).inDays / 30).floor()} Months',
                                      style: kThemeData.textTheme.labelSmall
                                          ?.copyWith(
                                              color: DarkTheme.darkNormal),
                                    ),
                                    const SizedBox(
                                      width: 20,
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        value.fetchDiamonds();
                                        Get.to(() => const DiamondsView());
                                      },
                                      child: Container(
                                        padding: const EdgeInsets.only(
                                            top: 5,
                                            bottom: 5,
                                            left: 16,
                                            right: 16),
                                        // margin: EdgeInsets.symmetric(horizontal: Get.width * 0.3),
                                        // width: Get.width * 0.2,
                                        // height: 32,
                                        decoration: BoxDecoration(
                                            gradient: const LinearGradient(
                                                begin: Alignment.topLeft,
                                                end: Alignment.bottomRight,
                                                colors: [
                                                  Color.fromRGBO(
                                                      127, 0, 255, 1),
                                                  Color.fromRGBO(
                                                      255, 0, 255, 1),
                                                ]),
                                            borderRadius:
                                                BorderRadius.circular(25)),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            SvgPicture.asset(
                                              "assets/images/profile_diamonds.svg",
                                              // height: 0.022 * Get.height,
                                              height: 14,
                                            ),
                                            const SizedBox(
                                              width: 4,
                                            ),
                                            Text(
                                              '${value.user.value.diamond ?? 0}',
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                              style: kThemeData
                                                  .textTheme.labelSmall
                                                  ?.copyWith(
                                                      fontSize: 12,
                                                      color: LightTheme.white),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: Container(),
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        Get.to(() => NotificationsView());
                                      },
                                      child: SvgPicture.asset(
                                          "assets/images/message.svg",
                                          height: 30,
                                          color: const Color(0xff667080)),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            width: 16,
                          ),
                        ],
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Get.toNamed(Routes.ALLPRODUCTS,
                          arguments: {'title': 'Search Products', 'url': 'shops'});
                    },
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
                              ?.copyWith(color: const Color(0xffAF98A8)),
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
                ],
              ),
            ),
            Container(
              color: LightTheme.lightActive,
              child: Column(
                children: [
                  const SizedBox(
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
      ),
    ));
  }
}

Widget shimmerHomePage() {
  return Column(
    children: [
      const ShimmerHotSales(),
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
                        offset:
                            const Offset(0, 2), // changes position of shadow
                      ),
                    ],
                    borderRadius: BorderRadius.circular(15)),
                child: Column(
                  children: [
                    Stack(
                      children: [
                        Container(
                          margin: const EdgeInsets.only(top: 12, bottom: 8),
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
                          const SizedBox(
                            height: 8,
                          ),
                          Text(
                            "test",
                            maxLines: 1,
                            style: kThemeData.textTheme.labelSmall?.copyWith(
                                color: AppColors.secondary700, fontSize: 12),
                          ),
                          const SizedBox(
                            height: 4,
                          ),
                          Text(
                            "Test",
                            maxLines: 2,
                            style: kThemeData.textTheme.bodyMedium?.copyWith(
                                color: AppColors.primary700, fontSize: 14),
                          ),
                          const SizedBox(
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
                            },
                          ),
                          const SizedBox(
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
                          const SizedBox(
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
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              crossAxisCount: 2,
              children: List.generate(
                4,
                (index) => Container(
                  padding: const EdgeInsets.only(top: 10),
                  margin: const EdgeInsets.only(right: 18, bottom: 20),
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
              const SizedBox(
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
                margin: const EdgeInsets.only(right: 18, bottom: 20),
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
              const SizedBox(
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
