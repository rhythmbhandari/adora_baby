import 'package:adora_baby/app/enums/date_type.dart';
import 'package:adora_baby/app/modules/profile/controllers/profile_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../config/app_colors.dart';
import '../../../config/app_theme.dart';
import 'diamonds_overview_widget.dart';
import 'diamonds_statement_widget.dart';
import 'order_history_widget.dart';

class DiamondsView extends StatefulWidget {
  const DiamondsView({Key? key}) : super(key: key);

  @override
  State<DiamondsView> createState() => _DiamondsViewState();
}

class _DiamondsViewState extends State<DiamondsView>
    with TickerProviderStateMixin {
  final ProfileController controller = Get.find();

  List<RefreshController> _refreshControllerStatement = [
    RefreshController(),
    RefreshController(),
    RefreshController(),
  ];

  List<RefreshController> _refreshControllerOverview = [
    RefreshController(),
    RefreshController(),
    RefreshController(),
  ];

  late TabController tabController;

  late TabController tabControllerMain;

  @override
  void initState() {
    tabController = TabController(
      initialIndex: 0,
      length: 3,
      vsync: this,
    );
    tabControllerMain = TabController(
      initialIndex: 0,
      length: 2,
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
                        "Diamonds",
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
              Row(
                children: [
                  TabBar(
                    labelStyle: kThemeData.textTheme.labelMedium?.copyWith(
                      fontSize: 18,
                    ),
                    isScrollable: true,
                    indicatorSize: TabBarIndicatorSize.tab,
                    labelPadding: EdgeInsets.symmetric(horizontal: 30),
                    unselectedLabelColor: Color.fromRGBO(175, 152, 168, 1),
                    unselectedLabelStyle:
                        kThemeData.textTheme.labelMedium?.copyWith(
                      fontSize: 18,
                    ),
                    labelColor: DarkTheme.dark,
                    indicatorColor: DarkTheme.dark,
                    padding: EdgeInsets.symmetric(horizontal: 40),
                    controller: tabControllerMain,
                    indicatorWeight: 2.5,
                    tabs: [
                      Tab(
                        text: 'Overview',
                      ),
                      Tab(
                        text: 'Statement',
                      ),
                    ],
                  ),
                ],
              ),
              Divider(
                height: 0,
                color: Color(
                  0xffAF98A8,
                ),
                thickness: 0.2,
              ),
              Container(
                alignment: Alignment.topLeft,
                padding: EdgeInsets.symmetric(
                  horizontal: 27,
                  vertical: 16,
                ),
                child: Text(
                  '${controller.user.value.diamond} Diamonds',
                  style: kThemeData.textTheme.titleMedium
                      ?.copyWith(color: DarkTheme.dark),
                ),
              ),
              Expanded(
                child: TabBarView(
                  controller: tabControllerMain,
                  children: <Widget>[
                    Column(
                      children: [
                        Obx(() => SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              controller: controller.scrollControllerOverview,
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 27, vertical: 0),
                                child: Row(
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        controller.updateSelectedBookingPage(
                                          DateType.WEEK,
                                          controller.pageControllerOverview,
                                          controller.dateTypeOverview,
                                          controller.currentPageOverview,
                                        );
                                        controller.animateTab(
                                            0,
                                            controller
                                                .scrollControllerOverview);
                                      },
                                      child: Container(
                                        padding: EdgeInsets.symmetric(
                                          horizontal: 22,
                                          vertical: 8,
                                        ),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          border: Border.all(
                                              color: DarkTheme.lightActive,
                                              width: 1),
                                          color: controller
                                                      .dateTypeOverview.value ==
                                                  DateType.WEEK
                                              ? DarkTheme.lightActive
                                              : Colors.white,
                                        ),
                                        child: Center(
                                          child: Text('Last 7 Days',
                                              style: controller.dateTypeOverview
                                                          .value ==
                                                      DateType.WEEK
                                                  ? kThemeData
                                                      .textTheme.bodyLarge
                                                      ?.copyWith(
                                                          color: Colors.white,
                                                          fontSize: 17)
                                                  : kThemeData
                                                      .textTheme.bodyLarge
                                                      ?.copyWith(
                                                          color:
                                                              DarkTheme.lighter,
                                                          fontSize: 17)),
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: 11),
                                    GestureDetector(
                                      onTap: () {
                                        controller.updateSelectedBookingPage(
                                          DateType.HALFMONTH,
                                          controller.pageControllerOverview,
                                          controller.dateTypeOverview,
                                          controller.currentPageOverview,
                                        );
                                        controller.animateTab(
                                            1,
                                            controller
                                                .scrollControllerOverview);
                                      },
                                      child: Container(
                                        padding: EdgeInsets.symmetric(
                                          horizontal: 22,
                                          vertical: 8,
                                        ),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          border: Border.all(
                                              color: DarkTheme.lightActive,
                                              width: 1),
                                          color: controller
                                                      .dateTypeOverview.value ==
                                                  DateType.HALFMONTH
                                              ? DarkTheme.lightActive
                                              : Colors.white,
                                        ),
                                        child: Center(
                                          child: Text('Last 14 Days',
                                              style: controller.dateTypeOverview
                                                          .value ==
                                                      DateType.HALFMONTH
                                                  ? kThemeData
                                                      .textTheme.bodyLarge
                                                      ?.copyWith(
                                                          color: Colors.white,
                                                          fontSize: 17)
                                                  : kThemeData
                                                      .textTheme.bodyLarge
                                                      ?.copyWith(
                                                          color:
                                                              DarkTheme.lighter,
                                                          fontSize: 17)),
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: 11),
                                    GestureDetector(
                                      onTap: () {
                                        controller.updateSelectedBookingPage(
                                          DateType.MONTH,
                                          controller.pageControllerOverview,
                                          controller.dateTypeOverview,
                                          controller.currentPageOverview,
                                        );
                                        controller.animateTab(
                                            2,
                                            controller
                                                .scrollControllerOverview);
                                      },
                                      child: Container(
                                        padding: EdgeInsets.symmetric(
                                          horizontal: 22,
                                          vertical: 8,
                                        ),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          border: Border.all(
                                              color: DarkTheme.lightActive,
                                              width: 1),
                                          color: controller
                                                      .dateTypeOverview.value ==
                                                  DateType.MONTH
                                              ? DarkTheme.lightActive
                                              : Colors.white,
                                        ),
                                        child: Center(
                                          child: Text('Last 30 Days',
                                              style: controller.dateTypeOverview
                                                          .value ==
                                                      DateType.MONTH
                                                  ? kThemeData
                                                      .textTheme.bodyLarge
                                                      ?.copyWith(
                                                          color: Colors.white,
                                                          fontSize: 17)
                                                  : kThemeData
                                                      .textTheme.bodyLarge
                                                      ?.copyWith(
                                                          color:
                                                              DarkTheme.lighter,
                                                          fontSize: 17)),
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: 20),
                                  ],
                                ),
                              ),
                            )),
                        Container(
                          height: Get.height * 0.007,
                        ),
                        Expanded(
                          child: Obx(
                            () => PageView.builder(
                              controller:
                                  controller.pageControllerOverview.value,
                              physics: NeverScrollableScrollPhysics(),
                              itemCount: 3,
                              itemBuilder: (context, pageViewIndex) {
                                return DiamondsOverviewWidget(
                                  refreshController:
                                      _refreshControllerOverview[pageViewIndex],
                                  list: pageViewIndex == 0
                                      ? controller.diamondListWeekOverview
                                      : pageViewIndex == 1
                                          ? controller.diamondHalfMonthOverview
                                          : controller.diamondListMonthOverview,
                                  indexAPI: pageViewIndex,
                                );
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Obx(() => SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              controller: controller.scrollControllerStatement,
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 27, vertical: 0),
                                child: Row(
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        controller.updateSelectedBookingPage(
                                          DateType.WEEK,
                                          controller.pageControllerStatement,
                                          controller.dateTypeStatement,
                                          controller.currentPageStatement,
                                        );
                                        controller.animateTab(
                                            0,
                                            controller
                                                .scrollControllerStatement);
                                      },
                                      child: Container(
                                        padding: EdgeInsets.symmetric(
                                          horizontal: 22,
                                          vertical: 8,
                                        ),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          border: Border.all(
                                              color: DarkTheme.lightActive,
                                              width: 1),
                                          color: controller.dateTypeStatement
                                                      .value ==
                                                  DateType.WEEK
                                              ? DarkTheme.lightActive
                                              : Colors.white,
                                        ),
                                        child: Center(
                                          child: Text('Last 7 Days',
                                              style: controller
                                                          .dateTypeStatement
                                                          .value ==
                                                      DateType.WEEK
                                                  ? kThemeData
                                                      .textTheme.bodyLarge
                                                      ?.copyWith(
                                                          color: Colors.white,
                                                          fontSize: 17)
                                                  : kThemeData
                                                      .textTheme.bodyLarge
                                                      ?.copyWith(
                                                          color:
                                                              DarkTheme.lighter,
                                                          fontSize: 17)),
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: 11),
                                    GestureDetector(
                                      onTap: () {
                                        controller.updateSelectedBookingPage(
                                          DateType.HALFMONTH,
                                          controller.pageControllerStatement,
                                          controller.dateTypeStatement,
                                          controller.currentPageStatement,
                                        );
                                        controller.animateTab(
                                            1,
                                            controller
                                                .scrollControllerStatement);
                                      },
                                      child: Container(
                                        padding: EdgeInsets.symmetric(
                                          horizontal: 22,
                                          vertical: 8,
                                        ),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          border: Border.all(
                                              color: DarkTheme.lightActive,
                                              width: 1),
                                          color: controller.dateTypeStatement
                                                      .value ==
                                                  DateType.HALFMONTH
                                              ? DarkTheme.lightActive
                                              : Colors.white,
                                        ),
                                        child: Center(
                                          child: Text('Last 14 Days',
                                              style: controller
                                                          .dateTypeStatement
                                                          .value ==
                                                      DateType.HALFMONTH
                                                  ? kThemeData
                                                      .textTheme.bodyLarge
                                                      ?.copyWith(
                                                          color: Colors.white,
                                                          fontSize: 17)
                                                  : kThemeData
                                                      .textTheme.bodyLarge
                                                      ?.copyWith(
                                                          color:
                                                              DarkTheme.lighter,
                                                          fontSize: 17)),
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: 11),
                                    GestureDetector(
                                      onTap: () {
                                        controller.updateSelectedBookingPage(
                                          DateType.MONTH,
                                          controller.pageControllerStatement,
                                          controller.dateTypeStatement,
                                          controller.currentPageStatement,
                                        );
                                        controller.animateTab(
                                            2,
                                            controller
                                                .scrollControllerStatement);
                                      },
                                      child: Container(
                                        padding: EdgeInsets.symmetric(
                                          horizontal: 22,
                                          vertical: 8,
                                        ),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          border: Border.all(
                                              color: DarkTheme.lightActive,
                                              width: 1),
                                          color: controller.dateTypeStatement
                                                      .value ==
                                                  DateType.MONTH
                                              ? DarkTheme.lightActive
                                              : Colors.white,
                                        ),
                                        child: Center(
                                          child: Text('Last 30 Days',
                                              style: controller
                                                          .dateTypeStatement
                                                          .value ==
                                                      DateType.MONTH
                                                  ? kThemeData
                                                      .textTheme.bodyLarge
                                                      ?.copyWith(
                                                          color: Colors.white,
                                                          fontSize: 17)
                                                  : kThemeData
                                                      .textTheme.bodyLarge
                                                      ?.copyWith(
                                                          color:
                                                              DarkTheme.lighter,
                                                          fontSize: 17)),
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: 20),
                                  ],
                                ),
                              ),
                            )),
                        Container(
                          height: Get.height * 0.007,
                        ),
                        Expanded(
                          child: Obx(
                            () => PageView.builder(
                              controller:
                                  controller.pageControllerStatement.value,
                              physics: NeverScrollableScrollPhysics(),
                              itemCount: 3,
                              itemBuilder: (context, pageViewIndex) {
                                return DiamondsStatementWidget(
                                  refreshController:
                                      _refreshControllerStatement[
                                          pageViewIndex],
                                  list: pageViewIndex == 0
                                      ? controller.diamondListWeek
                                      : pageViewIndex == 1
                                          ? controller.diamondHalfMonth
                                          : controller.diamondListMonth,
                                  indexAPI: pageViewIndex,
                                );
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
