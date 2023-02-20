import 'dart:developer';

import 'package:adora_baby/app/widgets/custom_progress_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../config/app_colors.dart';
import '../../../config/app_theme.dart';
import '../../../data/repositories/shop_respository.dart';
import '../../../enums/progress_status.dart';
import '../../../routes/app_pages.dart';
import '../../../widgets/buttons.dart';
import '../../../widgets/gradient_icon.dart';
import '../../cart/widgets/empty_widget.dart';
import '../controllers/shop_controller.dart';

class HotSalesView extends GetView<ShopController> {
  HotSalesView({Key? key}) : super(key: key);

  final RefreshController _refreshControllerHotSales =
      RefreshController(initialRefresh: false);

  void _onRefresh() async {
    // monitor network fetch
    try {
      controller.selectedStages.value = 10;
      controller.selectedFilter.value = 0;
      controller.searchController.text = "";
      await controller
          .getHotSalesFiltered(true)
          .then((value) => _refreshControllerHotSales.refreshCompleted());
    } catch (error) {
      _refreshControllerHotSales.refreshFailed();
      await Future.delayed(Duration(milliseconds: 0000))
          .then((value) => _refreshControllerHotSales.refreshToIdle());
    }
  }

  void _onLoading() async {
    // monitor network fetch
    try {
      await controller
          .getHotSalesFiltered(false)
          .then((value) => _refreshControllerHotSales.loadComplete());
    } catch (error) {
      _refreshControllerHotSales.loadFailed();
      await Future.delayed(Duration(milliseconds: 0000))
          .then((value) => _refreshControllerHotSales.refreshToIdle());
    }
  }

  @override
  Widget build(BuildContext context) {
    if (Get.arguments != null) {
      controller.hotSalesFiltered.value = Get.arguments;
    }
    return WillPopScope(
      onWillPop: () async {
        controller.selectedStages.value = 10;
        controller.selectedFilter.value = 0;
        controller.searchController.text = "";
        return true;
      },
      child: Scaffold(
          backgroundColor: Colors.white,
          body: SafeArea(
            bottom: false,
            child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
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
                                controller.selectedStages.value = 10;
                                controller.selectedFilter.value = 0;
                                controller.searchController.text = "";
                                Get.back();
                              },
                              child: const Icon(
                                Icons.arrow_back_ios,
                                color: Colors.black,
                              )),
                        ),
                        Expanded(flex: 2, child: SizedBox()),
                        Container(
                          alignment: Alignment.center,
                          child: Text(
                            "Hot Sales",
                            style: kThemeData.textTheme.displaySmall
                                ?.copyWith(color: DarkTheme.dark),
                          ),
                        ),
                        Expanded(flex: 3, child: SizedBox()),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Expanded(
                    child: Stack(
                      children: [
                        SmartRefresher(
                          physics: AlwaysScrollableScrollPhysics(),
                          enablePullDown: true,
                          enablePullUp: true,
                          header: ClassicHeader(
                            refreshStyle: RefreshStyle.Follow,
                            releaseIcon: SizedBox(
                                width: 25.0,
                                height: 25.0,
                                child: const CupertinoActivityIndicator()),
                            failedIcon: Icon(Icons.error, color: Colors.grey),
                            idleIcon: SizedBox(
                                width: 25.0,
                                height: 25.0,
                                child: CupertinoActivityIndicator
                                    .partiallyRevealed(
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
                            refreshingIcon: SizedBox(
                                width: 25.0,
                                height: 25.0,
                                child: const CupertinoActivityIndicator()),
                          ),
                          footer: ClassicFooter(
                            // refreshStyle: RefreshStyle.Follow,
                            canLoadingText: '',
                            loadStyle: LoadStyle.ShowWhenLoading,
                            noDataText: '',
                            noMoreIcon: SizedBox(
                                width: 25.0,
                                height: 25.0,
                                child: Icon(Icons.expand_circle_down,
                                    color: Colors.red)),
                            canLoadingIcon: SizedBox(
                                width: 25.0,
                                height: 25.0,
                                child: const CupertinoActivityIndicator()),
                            failedIcon: Icon(Icons.error, color: Colors.grey),
                            idleIcon: SizedBox(
                                width: 25.0,
                                height: 25.0,
                                child: CupertinoActivityIndicator
                                    .partiallyRevealed(
                                  progress: 0.4,
                                )),
                            textStyle: Get.textTheme.headline5!.copyWith(
                                fontFamily: 'Roboto',
                                color: Get.theme.primaryColor,
                                fontWeight: FontWeight.w500),
                            idleText: '',
                            failedText: '',
                            loadingText: '',
                            loadingIcon: SizedBox(
                                width: 25.0,
                                height: 25.0,
                                child: const CupertinoActivityIndicator()),
                          ),
                          controller: _refreshControllerHotSales,
                          onRefresh: _onRefresh,
                          onLoading: _onLoading,
                          child: Container(
                            color: Color.fromRGBO(
                              250,
                              245,
                              252,
                              1,
                            ),
                            child: SingleChildScrollView(
                              physics: NeverScrollableScrollPhysics(),
                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 32.0, right: 32, top: 33),
                                    child: TextField(
                                      cursorColor: AppColors.mainColor,
                                      autofocus: false,
                                      controller: controller.searchController,
                                      style: kThemeData.textTheme.bodyLarge
                                          ?.copyWith(color: DarkTheme.dark),
                                      onSubmitted: (_) =>
                                          filterPressed(context),
                                      decoration: InputDecoration(
                                        hintText: 'Search for Items',
                                        filled: true,
                                        hintStyle: kThemeData
                                            .textTheme.bodyLarge
                                            ?.copyWith(
                                                color: Color(0xffAF98A8)),
                                        contentPadding:
                                            const EdgeInsets.symmetric(
                                                horizontal: 24, vertical: 18),
                                        suffixIcon: GestureDetector(
                                          onTap: () => filterPressed(context),
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                top: 8.0, right: 23, bottom: 8),
                                            child: SvgPicture.asset(
                                                "assets/images/search-normal.svg"),
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
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 40.0, right: 40),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        GestureDetector(
                                          onTap: () => allStages(context),
                                          child: Row(
                                            children: [
                                              SvgPicture.asset(
                                                  "assets/images/filter-search.svg"),
                                              SizedBox(
                                                width: 11,
                                              ),
                                              const Text(
                                                "All Stages",
                                                style: TextStyle(
                                                  color: Color.fromRGBO(
                                                      241, 149, 157, 1),
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
                                            onTap: () =>
                                                mostRecentPressed(context),
                                            child: Row(
                                              children: [
                                                SvgPicture.asset(
                                                    "assets/images/sort.svg"),
                                                SizedBox(
                                                  width: 11,
                                                ),
                                                const Text(
                                                  "Most Recent",
                                                  style: TextStyle(
                                                    color: Color.fromRGBO(
                                                        241, 149, 157, 1),
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
                                  ),
                                  SizedBox(
                                    height: 18,
                                  ),
                                  Obx(() => controller
                                          .hotSalesFiltered.isNotEmpty
                                      ? ListView.builder(
                                          physics:
                                              NeverScrollableScrollPhysics(),
                                          shrinkWrap: true,
                                          itemCount: controller
                                              .hotSalesFiltered.length,
                                          itemBuilder: (BuildContext context,
                                                  int index) =>
                                              GestureDetector(
                                                onTap: () {
                                                  controller.productSelected
                                                          .value =
                                                      controller
                                                              .hotSalesFiltered[
                                                          index];
                                                  Get.toNamed(
                                                    Routes.PRODUCT_DETAILS,
                                                  );
                                                },
                                                child: Container(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 10),
                                                  margin: EdgeInsets.only(
                                                      left: 36,
                                                      right: 36,
                                                      bottom: 16),
                                                  alignment: Alignment.center,
                                                  decoration: BoxDecoration(
                                                      color: Colors.white,
                                                      border: Border.all(
                                                          color: const Color
                                                                  .fromRGBO(192,
                                                              144, 254, 0.25)),
                                                      boxShadow: [
                                                        BoxShadow(
                                                          color: Colors.grey
                                                              .withOpacity(0.5),
                                                          spreadRadius: 1,
                                                          blurRadius: 2,
                                                          offset: Offset(0,
                                                              2), // changes position of shadow
                                                        ),
                                                      ],
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              15)),
                                                  child: Column(
                                                    children: [
                                                      Stack(
                                                        children: [
                                                          Container(
                                                            margin:
                                                                EdgeInsets.only(
                                                                    top: 12,
                                                                    bottom: 8),
                                                            child: Center(
                                                              child:
                                                                  Image.network(
                                                                controller
                                                                    .hotSalesFiltered[
                                                                        index]
                                                                    .productImages[
                                                                        0]
                                                                    .name,
                                                                height:
                                                                    Get.height *
                                                                        0.25,
                                                              ),
                                                            ),
                                                          ),
                                                          Container(
                                                            padding:
                                                                const EdgeInsets
                                                                        .only(
                                                                    top: 2,
                                                                    bottom: 2,
                                                                    left: 6,
                                                                    right: 6),
                                                            margin: EdgeInsets
                                                                .symmetric(
                                                                    horizontal:
                                                                        8),
                                                            decoration:
                                                                BoxDecoration(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          20),
                                                              gradient:
                                                                  const LinearGradient(
                                                                begin: Alignment
                                                                    .topRight,
                                                                end: Alignment
                                                                    .bottomLeft,
                                                                colors: [
                                                                  AppColors
                                                                      .linear2,
                                                                  AppColors
                                                                      .linear1,
                                                                ],
                                                              ),
                                                            ),
                                                            child: const Text(
                                                              "Sale!",
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .white,
                                                                  fontFamily:
                                                                      "Poppins",
                                                                  fontSize: 16,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w400,
                                                                  fontStyle:
                                                                      FontStyle
                                                                          .normal,
                                                                  letterSpacing:
                                                                      0.04),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      Container(
                                                        padding:
                                                            const EdgeInsets
                                                                    .only(
                                                                left: 13,
                                                                right: 13),
                                                        width: Get.width,
                                                        decoration: const BoxDecoration(
                                                            color: Color
                                                                .fromRGBO(
                                                                    243,
                                                                    234,
                                                                    249,
                                                                    1),
                                                            borderRadius: BorderRadius.only(
                                                                bottomRight:
                                                                    Radius
                                                                        .circular(
                                                                            15),
                                                                bottomLeft: Radius
                                                                    .circular(
                                                                        15))),
                                                        child: Column(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .start,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            SizedBox(
                                                              height: 8,
                                                            ),
                                                            Text(
                                                              controller
                                                                  .hotSalesFiltered[
                                                                      index]
                                                                  .shortName,
                                                              maxLines: 1,
                                                              style: kThemeData
                                                                  .textTheme
                                                                  .labelSmall
                                                                  ?.copyWith(
                                                                      color: AppColors
                                                                          .secondary700,
                                                                      fontSize:
                                                                          12),
                                                            ),
                                                            SizedBox(
                                                              height: 4,
                                                            ),
                                                            Text(
                                                              controller
                                                                  .hotSalesFiltered[
                                                                      index]
                                                                  .name,
                                                              maxLines: 2,
                                                              style: kThemeData
                                                                  .textTheme
                                                                  .bodyMedium
                                                                  ?.copyWith(
                                                                      color: AppColors
                                                                          .primary700,
                                                                      fontSize:
                                                                          14),
                                                            ),
                                                            SizedBox(
                                                              height: 8,
                                                            ),
                                                            RatingBar.builder(
                                                              initialRating:
                                                                  controller
                                                                      .hotSalesFiltered[
                                                                          index]
                                                                      .rating
                                                                      .gradeAvg,
                                                              ignoreGestures:
                                                                  true,
                                                              itemSize: 12,
                                                              direction: Axis
                                                                  .horizontal,
                                                              allowHalfRating:
                                                                  true,
                                                              glow: false,
                                                              itemCount: 5,
                                                              itemPadding: EdgeInsets
                                                                  .symmetric(
                                                                      horizontal:
                                                                          0.0),
                                                              itemBuilder:
                                                                  (context,
                                                                          _) =>
                                                                      GradientIcon(
                                                                Icons.star,
                                                                10.0,
                                                                LinearGradient(
                                                                  colors: <
                                                                      Color>[
                                                                    Color
                                                                        .fromRGBO(
                                                                            127,
                                                                            0,
                                                                            255,
                                                                            1),
                                                                    Color
                                                                        .fromRGBO(
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
                                                                print(rating);
                                                              },
                                                            ),
                                                            SizedBox(
                                                              height: 8,
                                                            ),
                                                            controller
                                                                        .hotSalesFiltered[
                                                                            index]
                                                                        .salePrice !=
                                                                    0
                                                                ? Row(
                                                                    children: [
                                                                      Expanded(
                                                                        child:
                                                                            Text(
                                                                          "Rs. ${controller.hotSalesFiltered[index].regularPrice}",
                                                                          maxLines:
                                                                              2,
                                                                          style: kThemeData
                                                                              .textTheme
                                                                              .bodyMedium
                                                                              ?.copyWith(color: DarkTheme.lightActive, decoration: TextDecoration.lineThrough),
                                                                        ),
                                                                      ),
                                                                      Text(
                                                                        "Rs. ${controller.hotSalesFiltered[index].salePrice}",
                                                                        maxLines:
                                                                            2,
                                                                        style: kThemeData
                                                                            .textTheme
                                                                            .bodyMedium
                                                                            ?.copyWith(color: DarkTheme.normal),
                                                                      ),
                                                                      SizedBox(
                                                                        width:
                                                                            20,
                                                                      )
                                                                    ],
                                                                  )
                                                                : Text(
                                                                    "Rs. ${controller.hotSalesFiltered[index].regularPrice}",
                                                                    maxLines: 2,
                                                                    style: kThemeData
                                                                        .textTheme
                                                                        .bodyMedium
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
                                              ))
                                      :  EmptyWidget(
                                      isSearched: true))
                                ],
                              ),
                            ),
                          ),
                        ),
                        Obx(() => controller.progressStatus.value ==
                                ProgressStatus.searching
                            ? CustomProgressBar()
                            : Container()),
                      ],
                    ),
                  )
                ]),
          )),
    );
  }

  void mostRecentPressed(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return ListView.builder(
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  controller.selectedFilter.value = index;
                },
                child: Container(
                  padding: EdgeInsets.only(
                    left: 32,
                    right: 32,
                    top: 24,
                    bottom: 24,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (index == 0) ...[
                        Center(
                          child: Text(
                            'Filters',
                            style: kThemeData.textTheme.displaySmall
                                ?.copyWith(color: DarkTheme.dark),
                          ),
                        ),
                        SizedBox(
                          height: 32,
                        ),
                      ] else
                        ...[],
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              controller.filtersList[index],
                              style: kThemeData.textTheme.bodyLarge
                                  ?.copyWith(color: DarkTheme.dark),
                            ),
                          ),
                          Stack(
                            children: [
                              Container(
                                height: 35,
                                width: 35,
                                decoration: BoxDecoration(
                                    color: Color.fromRGBO(
                                      243,
                                      234,
                                      249,
                                      1,
                                    ),
                                    shape: BoxShape.circle),
                              ),
                              Obx(
                                () => controller.selectedFilter.value == index
                                    ? Positioned(
                                        left: 0,
                                        right: 0,
                                        bottom: 0,
                                        top: 0,
                                        child: Center(
                                          child: Container(
                                            height: 20,
                                            width: 20,
                                            decoration: BoxDecoration(
                                                color: AppColors.primary500,
                                                shape: BoxShape.circle),
                                          ),
                                        ),
                                      )
                                    : Container(),
                              ),
                            ],
                          )
                        ],
                      ),
                      if (controller.filtersList.length == index + 1) ...[
                        SizedBox(
                          height: 32,
                        ),
                        ButtonsWidget(
                            name: 'Apply Filter',
                            onPressed: () {
                              filterPressed(context);
                              Navigator.pop(context);
                            })
                      ]
                    ],
                  ),
                ),
              );
            },
            itemCount: controller.filtersList.length,
          );
        });
  }

  void allStages(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return ListView.builder(
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  controller.selectedStages.value = index;
                },
                child: Container(
                  padding: EdgeInsets.only(
                    left: 32,
                    right: 32,
                    top: 24,
                    bottom: 24,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (index == 0) ...[
                        Center(
                          child: Text(
                            'Stages',
                            style: kThemeData.textTheme.displaySmall
                                ?.copyWith(color: DarkTheme.dark),
                          ),
                        ),
                        SizedBox(
                          height: 32,
                        ),
                      ] else
                        ...[],
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              '${controller.stagesList[index].name}',
                              style: kThemeData.textTheme.bodyLarge
                                  ?.copyWith(color: DarkTheme.dark),
                            ),
                          ),
                          Stack(
                            children: [
                              Container(
                                height: 35,
                                width: 35,
                                decoration: BoxDecoration(
                                    color: Color.fromRGBO(
                                      243,
                                      234,
                                      249,
                                      1,
                                    ),
                                    shape: BoxShape.circle),
                              ),
                              Obx(
                                () => controller.selectedStages.value == index
                                    ? Positioned(
                                        left: 0,
                                        right: 0,
                                        bottom: 0,
                                        top: 0,
                                        child: Center(
                                          child: Container(
                                            height: 20,
                                            width: 20,
                                            decoration: BoxDecoration(
                                                color: AppColors.primary500,
                                                shape: BoxShape.circle),
                                          ),
                                        ),
                                      )
                                    : Container(),
                              ),
                            ],
                          )
                        ],
                      ),
                      if (controller.stagesList.length == index + 1) ...[
                        SizedBox(
                          height: 32,
                        ),
                        ButtonsWidget(
                            name: 'Apply Filter',
                            onPressed: () {
                              stagesPressed(context);
                              Navigator.pop(context);
                            })
                      ]
                    ],
                  ),
                ),
              );
            },
            itemCount: controller.stagesList.length,
          );
        });
  }

  void stagesPressed(BuildContext context) {
    controller.getHotSalesFiltered(
      true,
      isFilter: true,
      filterId: controller.stagesList[controller.selectedStages.value].id,
      isOrdered: true,
      isSearch: true,
      searchKeyword: controller.searchController.text.trim(),
      ordering: controller.selectedFilter.value == 1
          ? 'regular_price'
          : '-regular_price',
    );
  }

  void filterPressed(BuildContext context) {
    if (controller.selectedStages.value == 10) {
      controller.getHotSalesFiltered(true,
          isOrdered: true,
          ordering: controller.selectedFilter.value == 1
              ? 'regular_price'
              : '-regular_price',
          isSearch: true,
          searchKeyword: controller.searchController.text.trim());
    } else {
      controller.getHotSalesFiltered(
        true,
        isOrdered: true,
        ordering: controller.selectedFilter.value == 1
            ? 'regular_price'
            : '-regular_price',
        isSearch: true,
        searchKeyword: controller.searchController.text.trim(),
        isFilter: true,
        filterId: controller.stagesList[controller.selectedStages.value].id,
      );
    }
  }
}
