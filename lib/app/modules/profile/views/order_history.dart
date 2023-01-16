import 'dart:developer';

import 'package:adora_baby/app/modules/profile/controllers/profile_controller.dart';
import 'package:adora_baby/app/modules/profile/views/order_history_detail.dart';
import 'package:adora_baby/app/widgets/custom_progress_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../config/app_colors.dart';
import '../../../config/app_theme.dart';
import '../../../enums/progress_status.dart';
import '../../../routes/app_pages.dart';
import '../../../utils/date_time_converter.dart';
import '../../../widgets/buttons.dart';
import '../../../widgets/gradient_icon.dart';

class OrderHistoryView extends GetView<ProfileController> {
  OrderHistoryView({Key? key}) : super(key: key);

  final RefreshController _refreshControllerOrderHistory =
      RefreshController(initialRefresh: false);

  void _onRefresh() async {
    await controller
        .getOrderList(isRefresh: true, isInitial: false)
        .then((value) => _refreshControllerOrderHistory.refreshCompleted())
        .catchError((error) async {
      _refreshControllerOrderHistory.refreshFailed();
      await Future.delayed(const Duration(milliseconds: 0000))
          .then((value) => _refreshControllerOrderHistory.refreshToIdle());
    });
  }

  void _onLoading() async {
    await controller
        .getOrderList(isRefresh: false, isInitial: false)
        .then((value) => _refreshControllerOrderHistory.loadComplete())
        .catchError((error) async {
      _refreshControllerOrderHistory.loadNoData();
      await Future.delayed(Duration(milliseconds: 0000))
          .then((value) => _refreshControllerOrderHistory.refreshToIdle());
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        // controller.selectedStages.value = 10;
        // controller.selectedFilter.value = 0;
        // controller.searchController.text = "";
        // return true;
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
                                // controller.selectedStages.value = 10;
                                // controller.selectedFilter.value = 0;
                                // controller.searchController.text = "";
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
                            "Order History",
                            style: kThemeData.textTheme.displaySmall
                                ?.copyWith(color: DarkTheme.dark),
                          ),
                        ),
                        Expanded(flex: 3, child: SizedBox()),
                      ],
                    ),
                  ),
                  Container(
                    height: Get.height * 0.02,
                    color: Color.fromRGBO(
                      250,
                      245,
                      252,
                      1,
                    ),
                  ),
                  Container(
                    height: Get.height * 0.015,
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
                          controller: _refreshControllerOrderHistory,
                          onRefresh: _onRefresh,
                          onLoading: _onLoading,
                          child: Container(
                            color: Colors.white,
                            padding: EdgeInsets.only(top: 16),
                            child: SingleChildScrollView(
                              physics: NeverScrollableScrollPhysics(),
                              child: Obx(() =>
                                  controller.orderHistoryList.isNotEmpty
                                      ? ListView.builder(
                                          physics:
                                              NeverScrollableScrollPhysics(),
                                          shrinkWrap: true,
                                          itemCount: controller
                                              .orderHistoryList.length,
                                          itemBuilder:
                                              (BuildContext context,
                                                      int index) =>
                                                  GestureDetector(
                                                    onTap: () {
                                                      controller.selectedOrders
                                                          .value = controller
                                                              .orderHistoryList[
                                                          index];
                                                      Get.to(
                                                          OrderHistoryDetail());
                                                    },
                                                    child: Container(
                                                      padding: const EdgeInsets
                                                          .symmetric(
                                                        horizontal: 28,
                                                        vertical: 18,
                                                      ),
                                                      margin: EdgeInsets.only(
                                                          left: 52,
                                                          right: 52,
                                                          bottom: 16),
                                                      alignment:
                                                          Alignment.center,
                                                      decoration: BoxDecoration(
                                                          color: Colors.white,
                                                          border: Border.all(
                                                              color: const Color
                                                                      .fromRGBO(
                                                                  192,
                                                                  144,
                                                                  254,
                                                                  0.25)),
                                                          boxShadow: [
                                                            BoxShadow(
                                                              color: Colors.grey
                                                                  .withOpacity(
                                                                      0.5),
                                                              spreadRadius: 1,
                                                              blurRadius: 1,
                                                              offset: Offset(0,
                                                                  1), // changes position of shadow
                                                            ),
                                                          ],
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      20)),
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .start,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          SizedBox(
                                                            height: Get.height *
                                                                0.06,
                                                            width: Get.height *
                                                                0.06,
                                                            // width: Get.height * 0.055,
                                                            child: controller
                                                                    .ordersList[
                                                                        index]
                                                                    .status
                                                                    .toString()
                                                                    .toLowerCase()
                                                                    .contains(
                                                                        'order')
                                                                ? SvgPicture.asset(
                                                                    "assets/images/order_placed.svg")
                                                                : controller
                                                                        .ordersList[
                                                                            index]
                                                                        .status
                                                                        .toString()
                                                                        .toLowerCase()
                                                                        .contains(
                                                                            'package')
                                                                    ? SvgPicture
                                                                        .asset(
                                                                            "assets/images/package_created.svg")
                                                                    : controller
                                                                            .ordersList[
                                                                                index]
                                                                            .status
                                                                            .toString()
                                                                            .toLowerCase()
                                                                            .contains(
                                                                                'shipped')
                                                                        ? SvgPicture.asset(
                                                                            "assets/images/shipped.svg")
                                                                        : controller.ordersList[index].status.toString().toLowerCase().contains('delivered')
                                                                            ? SvgPicture.asset("assets/images/shipped.svg")
                                                                            : SvgPicture.asset("assets/images/canceled.svg"),
                                                          ),
                                                          SizedBox(
                                                            width: 28,
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
                                                                  'Order #${controller.orderHistoryList[index].trackingCode}',
                                                                  maxLines: 1,
                                                                  style: kThemeData
                                                                      .textTheme
                                                                      .titleMedium
                                                                      ?.copyWith(
                                                                          color:
                                                                              DarkTheme.dark),
                                                                ),
                                                                controller
                                                                        .orderHistoryList[
                                                                            index]
                                                                        .status
                                                                        .toString()
                                                                        .toLowerCase()
                                                                        .contains(
                                                                            'order')
                                                                    ? Container(
                                                                        padding:
                                                                            EdgeInsets.only(top: 8),
                                                                        child:
                                                                            Text(
                                                                          'Order Placed',
                                                                          maxLines:
                                                                              1,
                                                                          style: kThemeData
                                                                              .textTheme
                                                                              .bodyLarge
                                                                              ?.copyWith(
                                                                            color:
                                                                                AppColors.warning500,
                                                                          ),
                                                                        ),
                                                                      )
                                                                    : controller
                                                                            .ordersList[index]
                                                                            .status
                                                                            .toString()
                                                                            .toLowerCase()
                                                                            .contains('package')
                                                                        ? Container(
                                                                            padding:
                                                                                EdgeInsets.only(top: 8),
                                                                            child:
                                                                                Text(
                                                                              'Package Created',
                                                                              maxLines: 1,
                                                                              style: kThemeData.textTheme.bodyLarge?.copyWith(
                                                                                color: AppColors.warning500,
                                                                              ),
                                                                            ),
                                                                          )
                                                                        : controller.ordersList[index].status.toString().toLowerCase().contains('shipped')
                                                                            ? Container(
                                                                                padding: EdgeInsets.only(top: 8),
                                                                                child: Text(
                                                                                  'Shipped',
                                                                                  maxLines: 1,
                                                                                  style: kThemeData.textTheme.bodyLarge?.copyWith(
                                                                                    color: AppColors.success800,
                                                                                  ),
                                                                                ),
                                                                              )
                                                                            : controller.orderHistoryList[index].status.toString().toLowerCase().contains('delivered')
                                                                                ? Container(
                                                                                    padding: EdgeInsets.only(top: 8),
                                                                                    child: Text(
                                                                                      'Delivered',
                                                                                      maxLines: 1,
                                                                                      style: kThemeData.textTheme.bodyLarge?.copyWith(
                                                                                        color: DarkTheme.darkActive,
                                                                                      ),
                                                                                    ),
                                                                                  )
                                                                                : controller.orderHistoryList[index].status.toString().toLowerCase().contains('canceled')
                                                                                    ? Container(
                                                                                        padding: EdgeInsets.only(top: 8),
                                                                                        child: Text(
                                                                                          'Canceled',
                                                                                          maxLines: 1,
                                                                                          style: kThemeData.textTheme.bodyLarge?.copyWith(
                                                                                            color: AppColors.error500,
                                                                                          ),
                                                                                        ),
                                                                                      )
                                                                                    : Container(),
                                                                controller
                                                                            .ordersList[
                                                                                index]
                                                                            .status
                                                                            .toString()
                                                                            .toLowerCase()
                                                                            .contains(
                                                                                'order') ||
                                                                        controller
                                                                            .ordersList[
                                                                                index]
                                                                            .status
                                                                            .toString()
                                                                            .toLowerCase()
                                                                            .contains(
                                                                                'package') ||
                                                                        controller
                                                                            .ordersList[
                                                                                index]
                                                                            .status
                                                                            .toString()
                                                                            .toLowerCase()
                                                                            .contains(
                                                                                'shipped')
                                                                    ? Container(
                                                                        padding:
                                                                            EdgeInsets.only(top: 8),
                                                                        child:
                                                                            Text(
                                                                          'Arriving ${DateTimeConverter.notificationDate(
                                                                            controller.ordersList[index].estimatedTime,
                                                                          )}',
                                                                          maxLines:
                                                                              1,
                                                                          style: kThemeData
                                                                              .textTheme
                                                                              .labelSmall
                                                                              ?.copyWith(
                                                                            color:
                                                                                DarkTheme.dark,
                                                                          ),
                                                                        ),
                                                                      )
                                                                    : controller
                                                                            .ordersList[index]
                                                                            .status
                                                                            .toString()
                                                                            .toLowerCase()
                                                                            .contains('delivered')
                                                                        ? Container(
                                                                            padding:
                                                                                EdgeInsets.only(top: 8),
                                                                            child:
                                                                                Text(
                                                                              'Arrived ${DateTimeConverter.notificationDate(
                                                                                controller.orderHistoryList[index].estimatedTime,
                                                                              )}',
                                                                              maxLines: 1,
                                                                              style: kThemeData.textTheme.labelSmall?.copyWith(
                                                                                color: DarkTheme.dark,
                                                                              ),
                                                                            ),
                                                                          )
                                                                        : Container(),
                                                              ],
                                                            ),
                                                          )
                                                        ],
                                                      ),
                                                    ),
                                                  ))
                                      : Container()),
                            ),
                          ),
                        ),
                        Obx(() => controller.progressStatus.value ==
                                ProgressStatus.SEARCHING
                            ? CustomProgressBar()
                            : Container()),
                      ],
                    ),
                  )
                ]),
          )),
    );
  }
}
