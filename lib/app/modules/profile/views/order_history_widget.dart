import 'package:adora_baby/app/modules/profile/controllers/profile_controller.dart';
import 'package:adora_baby/app/modules/profile/views/order_history_detail.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../config/app_colors.dart';
import '../../../config/app_theme.dart';
import '../../../utils/date_time_converter.dart';

class OrderHistoryWidgets extends StatelessWidget {
  final ProfileController controller = Get.find();

  final RefreshController refreshController;

  final RxList list;

  final int indexAPI;

  final RxInt pageIndex;

  OrderHistoryWidgets({
    super.key,
    required this.refreshController,
    required this.list,
    required this.indexAPI,
    required this.pageIndex,
  });

  void _onRefresh() async {
    await controller
        .getOrderList(isRefresh: true, isInitial: false, list, pageIndex, index: indexAPI)
        .then((value) => refreshController.refreshCompleted())
        .catchError(
      (error) async {
        refreshController.refreshFailed();
        await Future.delayed(const Duration(milliseconds: 0000))
            .then((value) => refreshController.refreshToIdle());
      },
    );
  }

  void _onLoading() async {
    await controller
        .getOrderList(isRefresh: false, isInitial: false, list, pageIndex, index: indexAPI)
        .then((value) => refreshController.loadComplete())
        .catchError(
      (error) async {
        refreshController.loadNoData();
        await Future.delayed(Duration(milliseconds: 0000))
            .then((value) => refreshController.refreshToIdle());
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SmartRefresher(
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
            child: Icon(Icons.expand_circle_down, color: Colors.red)),
        canLoadingIcon: SizedBox(
            width: 25.0,
            height: 25.0,
            child: const CupertinoActivityIndicator()),
        failedIcon: Icon(Icons.error, color: Colors.grey),
        idleIcon: SizedBox(
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
        loadingIcon: SizedBox(
            width: 25.0,
            height: 25.0,
            child: const CupertinoActivityIndicator()),
      ),
      controller: refreshController,
      onRefresh: _onRefresh,
      onLoading: _onLoading,
      child: Container(
        color: Colors.white,
        padding: EdgeInsets.only(top: 16),
        child: SingleChildScrollView(
          physics: NeverScrollableScrollPhysics(),
          child: Obx(() => list.isNotEmpty
              ? ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: list.length,
                  itemBuilder: (BuildContext context, int index) =>
                      GestureDetector(
                        onTap: () {
                          controller.selectedOrders.value = list[index];
                          Get.to(()=> OrderHistoryDetail());
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 28,
                            vertical: 18,
                          ),
                          margin:
                              EdgeInsets.only(left: 52, right: 52, bottom: 16),
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
                                  blurRadius: 1,
                                  offset: Offset(
                                      0, 1), // changes position of shadow
                                ),
                              ],
                              borderRadius: BorderRadius.circular(20)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: Get.height * 0.06,
                                width: Get.height * 0.06,
                                // width: Get.height * 0.055,
                                child: list[index]
                                        .status
                                        .toString()
                                        .toLowerCase()
                                        .contains('order')
                                    ? SvgPicture.asset(
                                        "assets/images/order_placed.svg")
                                    : list[index]
                                            .status
                                            .toString()
                                            .toLowerCase()
                                            .contains('package')
                                        ? SvgPicture.asset(
                                            "assets/images/package_created.svg")
                                        : list[index]
                                                .status
                                                .toString()
                                                .toLowerCase()
                                                .contains('shipped')
                                            ? SvgPicture.asset(
                                                "assets/images/shipped.svg")
                                            : list[index]
                                                    .status
                                                    .toString()
                                                    .toLowerCase()
                                                    .contains('delivered')
                                                ? SvgPicture.asset(
                                                    "assets/images/shipped.svg")
                                                : SvgPicture.asset(
                                                    "assets/images/canceled.svg"),
                              ),
                              SizedBox(
                                width: 28,
                              ),
                              Expanded(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Order #${list[index].trackingCode}',
                                      maxLines: 1,
                                      style: kThemeData.textTheme.titleMedium
                                          ?.copyWith(color: DarkTheme.dark),
                                    ),
                                    list[index]
                                            .status
                                            .toString()
                                            .toLowerCase()
                                            .contains('order')
                                        ? Container(
                                            padding: EdgeInsets.only(top: 8),
                                            child: Text(
                                              'Order Placed',
                                              maxLines: 1,
                                              style: kThemeData
                                                  .textTheme.bodyLarge
                                                  ?.copyWith(
                                                color: AppColors.warning500,
                                              ),
                                            ),
                                          )
                                        : list[index]
                                                .status
                                                .toString()
                                                .toLowerCase()
                                                .contains('package')
                                            ? Container(
                                                padding:
                                                    EdgeInsets.only(top: 8),
                                                child: Text(
                                                  'Package Created',
                                                  maxLines: 1,
                                                  style: kThemeData
                                                      .textTheme.bodyLarge
                                                      ?.copyWith(
                                                    color: AppColors.warning500,
                                                  ),
                                                ),
                                              )
                                            : list[index]
                                                    .status
                                                    .toString()
                                                    .toLowerCase()
                                                    .contains('shipped')
                                                ? Container(
                                                    padding:
                                                        EdgeInsets.only(top: 8),
                                                    child: Text(
                                                      'Shipped',
                                                      maxLines: 1,
                                                      style: kThemeData
                                                          .textTheme.bodyLarge
                                                          ?.copyWith(
                                                        color: AppColors
                                                            .success800,
                                                      ),
                                                    ),
                                                  )
                                                : list[index]
                                                        .status
                                                        .toString()
                                                        .toLowerCase()
                                                        .contains('delivered')
                                                    ? Container(
                                                        padding:
                                                            EdgeInsets.only(
                                                                top: 8),
                                                        child: Text(
                                                          'Delivered',
                                                          maxLines: 1,
                                                          style: kThemeData
                                                              .textTheme
                                                              .bodyLarge
                                                              ?.copyWith(
                                                            color: DarkTheme
                                                                .darkActive,
                                                          ),
                                                        ),
                                                      )
                                                    : list[index]
                                                            .status
                                                            .toString()
                                                            .toLowerCase()
                                                            .contains(
                                                                'canceled')
                                                        ? Container(
                                                            padding:
                                                                EdgeInsets.only(
                                                                    top: 8),
                                                            child: Text(
                                                              'Canceled',
                                                              maxLines: 1,
                                                              style: kThemeData
                                                                  .textTheme
                                                                  .bodyLarge
                                                                  ?.copyWith(
                                                                color: AppColors
                                                                    .error500,
                                                              ),
                                                            ),
                                                          )
                                                        : Container(),
                                    list[index]
                                                .status
                                                .toString()
                                                .toLowerCase()
                                                .contains('order') ||
                                            list[index]
                                                .status
                                                .toString()
                                                .toLowerCase()
                                                .contains('package') ||
                                            list[index]
                                                .status
                                                .toString()
                                                .toLowerCase()
                                                .contains('shipped')
                                        ? Container(
                                            padding: EdgeInsets.only(top: 8),
                                            child: Text(
                                              'Arriving ${DateTimeConverter.notificationDate(
                                                list[index].estimatedTime,
                                              )}',
                                              maxLines: 1,
                                              style: kThemeData
                                                  .textTheme.labelSmall
                                                  ?.copyWith(
                                                color: DarkTheme.dark,
                                              ),
                                            ),
                                          )
                                        : list[index]
                                                .status
                                                .toString()
                                                .toLowerCase()
                                                .contains('delivered')
                                            ? Container(
                                                padding:
                                                    EdgeInsets.only(top: 8),
                                                child: Text(
                                                  'Arrived ${DateTimeConverter.notificationDate(
                                                    list[index].estimatedTime,
                                                  )}',
                                                  maxLines: 1,
                                                  style: kThemeData
                                                      .textTheme.labelSmall
                                                      ?.copyWith(
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
    );
  }
}
