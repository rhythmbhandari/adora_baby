import 'dart:developer';

import 'package:adora_baby/app/modules/profile/controllers/profile_controller.dart';
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
import '../../../utils/date_time_converter.dart';
import '../../../widgets/buttons.dart';
import '../../../widgets/gradient_icon.dart';

class OrderHistoryDetail extends GetView<ProfileController> {
  OrderHistoryDetail({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return true;
      },
      child: Scaffold(
          backgroundColor: Colors.white,
          body: SafeArea(
              bottom: false,
              child: DefaultTabController(
                length: 2,
                child: Column(
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
                      alignment: Alignment.topLeft,
                      padding: EdgeInsets.only(
                        top: 16,
                        left: 34,
                        bottom: 40,
                      ),
                      child: Text(
                        'Order #${controller.selectedOrders.value.trackingCode}',
                        style: kThemeData.textTheme.displaySmall?.copyWith(
                          color: DarkTheme.dark,
                        ),
                      ),
                    ),
                    Expanded(
                      child: NestedScrollView(
                        headerSliverBuilder: (context, innerBoxIsScrolled) => [
                          // The flexible app bar with the tabs
                          SliverAppBar(
                            backgroundColor: Colors.white,
                            flexibleSpace: TabBar(
                                labelStyle:
                                    kThemeData.textTheme.labelMedium?.copyWith(
                                  color: DarkTheme.dark,
                                  fontSize: 18,
                                ),
                                isScrollable: false,
                                unselectedLabelColor: DarkTheme.lighter,
                                unselectedLabelStyle:
                                    kThemeData.textTheme.labelMedium?.copyWith(
                                  color: DarkTheme.lighter,
                                  fontSize: 18,
                                ),
                                labelColor: DarkTheme.dark,
                                indicatorColor: DarkTheme.dark,
                                indicatorSize: TabBarIndicatorSize.label,
                                indicatorWeight: 2,
                                tabs: [
                                  Tab(text: 'Details'),
                                  Tab(text: 'Track My Order'),
                                ]),
                            expandedHeight: 0,
                            pinned: true,
                            elevation: 0.5,

                            forceElevated: innerBoxIsScrolled,
                          ),
                          SliverToBoxAdapter(
                            child: Container(
                              height: 2,
                              color: Color.fromRGBO(
                                250,
                                245,
                                252,
                                1,
                              ),
                            ),
                          ),
                        ],
                        // The content of each tab
                        body: TabBarView(
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                for (int i = 0;
                                    i <
                                        controller
                                            .selectedOrders
                                            .value
                                            .checkOut!
                                            .cart!.length;
                                    i++)
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 23,
                                      vertical: 24,
                                    ),
                                    margin: EdgeInsets.symmetric(horizontal: 23, vertical: 16),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      border: Border.all(color: Colors.black.withOpacity(0.05)),
                                      color: Colors.white,
                                      boxShadow: [
                                        const BoxShadow(
                                          color: Color.fromRGBO(0, 0, 0, 0.25),
                                          blurRadius: 0.5,
                                          spreadRadius: 0.5,
                                          offset: Offset(-0, 0.5), // Shadow position
                                        ),
                                      ],
                                    ),
                                    child: Row(
                                      children: [
                                        CachedNetworkImage(
                                          fit: BoxFit.contain,
                                          height: Get.height * 0.18,
                                          width: Get.height * 0.18,
                                          imageUrl:
                                              '${controller.selectedOrders.value.checkOut?.cart?[i]?.product?.productImages?[0]?.name}',
                                          placeholder: (context, url) =>
                                              const Center(
                                                  child:
                                                      CircularProgressIndicator()),
                                          errorWidget: (context, url, error) =>
                                              const Icon(Icons.error),
                                        ),
                                        Expanded(
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                '${controller.selectedOrders.value.checkOut?.cart?[i]?.product?.shortName}',
                                                maxLines: 1,
                                                style: kThemeData
                                                    .textTheme.bodyMedium
                                                    ?.copyWith(
                                                  color: AppColors.secondary700,
                                                ),
                                              ),
                                              Text(
                                                '${controller.selectedOrders.value.checkOut?.cart?[i]?.product?.name}',
                                                maxLines: 4,
                                                style: kThemeData
                                                    .textTheme.titleMedium
                                                    ?.copyWith(
                                                  color: AppColors.primary700,
                                                ),
                                              ),
                                              SizedBox(
                                                height: 20,
                                              ),
                                              Container(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 15,
                                                        vertical: 3),
                                                decoration: BoxDecoration(
                                                    shape: BoxShape.rectangle,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                    border: Border.all(
                                                        color:
                                                            DarkTheme.normal)),
                                                child: Text(
                                                  '${controller.selectedOrders.value.checkOut?.cart?[i]?.quantity}',
                                                  maxLines: 1,
                                                  style: kThemeData
                                                      .textTheme.titleMedium
                                                      ?.copyWith(
                                                    color: AppColors.primary700,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                Container(
                                  height: Get.height * 0.02,
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
                                  height: Get.height * 0.02,
                                ),
                                Container(
                                  padding: EdgeInsets.symmetric(horizontal: 32),
                                  child: Text(
                                    'Payment Method',
                                    maxLines: 1,
                                    style: kThemeData
                                        .textTheme.titleMedium
                                        ?.copyWith(
                                      color: DarkTheme.dark,
                                    ),
                                  ),
                                ),
                                for (int i = 0;
                                i <
                                    controller
                                        .selectedOrders
                                        .value
                                        .checkOut!
                                        .cart!.length;
                                i++)
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 23,
                                      vertical: 24,
                                    ),
                                    margin: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      border: Border.all(color: Colors.black.withOpacity(0.05)),
                                      color: Colors.white,
                                      boxShadow: [
                                        const BoxShadow(
                                          color: Color.fromRGBO(0, 0, 0, 0.06),
                                          blurRadius: 0.2,
                                          spreadRadius: 0.5,
                                          offset: Offset(0, 2), // Shadow position
                                        ),
                                      ],
                                    ),
                                    child: Container())
                                    ],
                            ),
                            ListView.builder(
                              itemBuilder: (context, index) => ListTile(
                                title: Text(
                                  'Track My Order',
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ))),
    );
  }
}
