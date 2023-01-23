import 'package:adora_baby/app/enums/date_type.dart';
import 'package:adora_baby/app/modules/profile/controllers/profile_controller.dart';
import 'package:adora_baby/app/modules/profile/views/history/order_history_halfMonth.dart';
import 'package:adora_baby/app/modules/profile/views/history/order_history_week.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../config/app_colors.dart';
import '../../../config/app_theme.dart';
import 'history/order_history_month.dart';
import 'order_history_widget.dart';

class OrderHistoryView extends StatefulWidget {
  const OrderHistoryView({Key? key}) : super(key: key);

  @override
  State<OrderHistoryView> createState() => _OrderHistoryViewState();
}

class _OrderHistoryViewState extends State<OrderHistoryView>
    with TickerProviderStateMixin {
  final ProfileController controller = Get.find();

  List<RefreshController> _refreshController = [
    RefreshController(),
    RefreshController(),
    RefreshController(),
    RefreshController()
  ];

  late TabController tabController;

  @override
  void initState() {
    tabController = TabController(
      initialIndex: 0,
      length: 3,
      vsync: this,
    );
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
                  Obx(() => SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        controller: controller.scrollController,
                        child: Row(
                          children: [
                            GestureDetector(
                              onTap: () {
                                controller
                                    .updateSelectedBookingPage(DateType.WEEK);
                                controller.animateTab(0);
                              },
                              child: Container(
                                height: 32,
                                width: 94,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(4),
                                  color:
                                      controller.dateType.value == DateType.WEEK
                                          ? Get.theme.colorScheme.secondary
                                          : Colors.white,
                                ),
                                child: Center(
                                  child: Text('Week',
                                      style: Get.textTheme.headline5?.copyWith(
                                          fontSize: 14,
                                          fontFamily: 'Poppins',
                                          fontWeight: FontWeight.w500,
                                          color: controller.dateType.value ==
                                                  DateType.WEEK
                                              ? Colors.white
                                              : Color(0xffBEBEBE))),
                                ),
                              ),
                            ),
                            SizedBox(width: 11),
                            GestureDetector(
                              onTap: () {
                                controller.updateSelectedBookingPage(
                                    DateType.HALFMONTH);
                                controller.animateTab(1);
                              },
                              child: Container(
                                height: 32,
                                width: 94,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(4),
                                  color: controller.dateType.value ==
                                          DateType.HALFMONTH
                                      ? Get.theme.colorScheme.secondary
                                      : Colors.white,
                                ),
                                child: Center(
                                  child: Text('2 Week',
                                      style: Get.textTheme.headline5?.copyWith(
                                          fontSize: 14,
                                          fontFamily: 'Poppins',
                                          fontWeight: FontWeight.w500,
                                          color: controller.dateType.value ==
                                                  DateType.HALFMONTH
                                              ? Colors.white
                                              : Color(0xffBEBEBE))),
                                ),
                              ),
                            ),
                            SizedBox(width: 11),
                            GestureDetector(
                              onTap: () {
                                controller
                                    .updateSelectedBookingPage(DateType.MONTH);
                                controller.animateTab(2);
                              },
                              child: Container(
                                height: 32,
                                width: 94,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(4),
                                  color: controller.dateType.value ==
                                          DateType.MONTH
                                      ? Get.theme.colorScheme.secondary
                                      : Colors.white,
                                ),
                                child: Center(
                                  child: Text('MONTH',
                                      style: Get.textTheme.headline5?.copyWith(
                                          fontSize: 14,
                                          fontFamily: 'Poppins',
                                          fontWeight: FontWeight.w500,
                                          color: controller.dateType.value ==
                                                  DateType.MONTH
                                              ? Colors.white
                                              : Color(0xffBEBEBE))),
                                ),
                              ),
                            ),
                            SizedBox(width: 20),
                          ],
                        ),
                      )),
                  Container(
                    height: Get.height * 0.015,
                  ),
                  Expanded(
                    child: Obx(() => PageView.builder(
                        controller: controller.pageController.value,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: 3,
                        itemBuilder: (context, pageViewIndex) {
                          return OrderHistoryWeek(
                            refreshController:
                                _refreshController[pageViewIndex],
                            list: pageViewIndex == 0
                                ? controller.orderHistoryListWeek
                                : pageViewIndex == 1
                                    ? controller.orderHistoryListHalfMonth
                                    : controller.orderHistoryListMonth,
                          );
                          return SmartRefresher(
                            controller: _refreshController[pageViewIndex],
                            child: Container(
                              color: Colors.white,
                            ),
                          );

                          // pageContent[controller.currentPageOrder.value];
                        })),
                  ),
                  // Obx(() => controller.progressStatus.value ==
                  //         ProgressStatus.SEARCHING
                  //     ? CustomProgressBar()
                  //     : Container()),
                ]),
          )),
    );
  }

// final List pageContent = [
//   OrderHistoryWeek(),
//   OrderHistoryHalfMonth(),
//   OrderHistoryMonth()
// ];
}
