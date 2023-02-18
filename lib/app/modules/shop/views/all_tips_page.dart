import 'dart:developer';

import 'package:adora_baby/app/widgets/buttons.dart';
import 'package:adora_baby/app/widgets/custom_progress_bar.dart';
import 'package:cached_network_image/cached_network_image.dart';
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
import '../../../widgets/gradient_icon.dart';
import '../controllers/shop_controller.dart';

class MoreTips extends GetView<ShopController> {
  MoreTips({Key? key}) : super(key: key);

  final RefreshController _refreshControllerTips =
  RefreshController(initialRefresh: false);

  void _onRefresh() async {
    await controller
        .getTips(true, false)
        .then((value) => _refreshControllerTips.refreshCompleted())
        .catchError((error) async {
      _refreshControllerTips.refreshFailed();
      await Future.delayed(Duration(milliseconds: 0000))
          .then((value) => _refreshControllerTips.refreshToIdle());
    });
  }

  void _onLoading() async {
    // monitor network fetch
    await controller
        .getTips(false, false)
        .then((value) => _refreshControllerTips.loadComplete())
        .catchError((error) async {
      _refreshControllerTips.loadFailed();
      await Future.delayed(Duration(milliseconds: 0000))
          .then((value) => _refreshControllerTips.refreshToIdle());
    });
  }

  @override
  Widget build(BuildContext context) {
    if (Get.arguments != null) {
      controller.tipsListFiltered.value = Get.arguments;
    }
    return WillPopScope(
      onWillPop: () async {
        return true;
      },
      child: Scaffold(
          backgroundColor: Colors.white,
          body: SafeArea(
            bottom: false,
            child: Container(
              color: Color.fromRGBO(
                250,
                245,
                252,
                1,
              ),
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
                              "All Tips",
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
                                  child:
                                  CupertinoActivityIndicator.partiallyRevealed(
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
                                  child:
                                  CupertinoActivityIndicator.partiallyRevealed(
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
                            controller: _refreshControllerTips,
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
                                child: Obx(() =>
                                controller.tipsListFiltered.isNotEmpty
                                    ? ListView.builder(
                                    physics:
                                    NeverScrollableScrollPhysics(),
                                    shrinkWrap: true,
                                    padding: EdgeInsets.symmetric(vertical: 32, horizontal: 32),
                                    itemCount: controller
                                        .tipsListFiltered.length,
                                    itemBuilder:
                                        (BuildContext context,
                                        int index) =>
                                            Container(
                                              // padding: const EdgeInsets.only(top: 10),
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
                                                      Offset(0, 2), // changes position of shadow
                                                    ),
                                                  ],
                                                  borderRadius: BorderRadius.circular(30)),
                                              child: Container(
                                                // padding: EdgeInsets.symmetric(horizontal: 18),
                                                child: ClipRRect(
                                                  borderRadius: BorderRadius.circular(30.0),
                                                  child: Container(
                                                    height: Get.height * 0.4,
                                                    width: Get.width,
                                                    child: CachedNetworkImage(
                                                      fit: BoxFit.fill,
                                                      imageUrl: '${controller.tipsList[index].picture}',
                                                      placeholder: (context, url) => Container(
                                                          height: Get.height * 0.4,
                                                          child: Center(
                                                              child: CircularProgressIndicator())),
                                                      errorWidget: (context, url, error) =>
                                                          Icon(Icons.error),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ))
                                    : Container()),
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
            ),
          )),
    );
  }

}
