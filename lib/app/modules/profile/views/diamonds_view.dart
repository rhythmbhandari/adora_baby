import 'package:adora_baby/app/enums/date_type.dart';
import 'package:adora_baby/app/modules/profile/controllers/profile_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../config/app_colors.dart';
import '../../../config/app_theme.dart';
import 'order_history_widget.dart';

class DiamondsView extends StatefulWidget {
  const DiamondsView({Key? key}) : super(key: key);

  @override
  State<DiamondsView> createState() => _DiamondsViewState();
}

class _DiamondsViewState extends State<DiamondsView>
    with TickerProviderStateMixin {
  final ProfileController controller = Get.find();

  List<RefreshController> _refreshController = [
    RefreshController(),
    RefreshController(),
    RefreshController(),
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
                child: Container(
                  padding:
                  EdgeInsets.symmetric(horizontal: 27, vertical: 20),
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          controller
                              .updateSelectedBookingPage(DateType.WEEK);
                          controller.animateTab(0);
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 22,
                            vertical: 8,
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color:
                            controller.dateType.value == DateType.WEEK
                                ? DarkTheme.lightActive
                                : Colors.white,
                          ),
                          child: Center(
                            child: Text('Last 7 Days',
                                style: controller.dateType.value ==
                                    DateType.WEEK
                                    ? kThemeData.textTheme.bodyLarge
                                    ?.copyWith(
                                    color: Colors.white,
                                    fontSize: 17)
                                    : kThemeData.textTheme.bodyLarge
                                    ?.copyWith(
                                    color: DarkTheme.lighter,
                                    fontSize: 17)),
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
                          padding: EdgeInsets.symmetric(
                            horizontal: 22,
                            vertical: 8,
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: controller.dateType.value ==
                                DateType.HALFMONTH
                                ? DarkTheme.lightActive
                                : Colors.white,
                          ),
                          child: Center(
                            child: Text('Last 14 Days',
                                style: controller.dateType.value ==
                                    DateType.HALFMONTH
                                    ? kThemeData.textTheme.bodyLarge
                                    ?.copyWith(
                                    color: Colors.white,
                                    fontSize: 17)
                                    : kThemeData.textTheme.bodyLarge
                                    ?.copyWith(
                                    color: DarkTheme.lighter,
                                    fontSize: 17)),
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
                          padding: EdgeInsets.symmetric(
                            horizontal: 22,
                            vertical: 8,
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color:
                            controller.dateType.value == DateType.MONTH
                                ? DarkTheme.lightActive
                                : Colors.white,
                          ),
                          child: Center(
                            child: Text('Last 30 Days',
                                style: controller.dateType.value ==
                                    DateType.MONTH
                                    ? kThemeData.textTheme.bodyLarge
                                    ?.copyWith(
                                    color: Colors.white,
                                    fontSize: 17)
                                    : kThemeData.textTheme.bodyLarge
                                    ?.copyWith(
                                    color: DarkTheme.lighter,
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
                    controller: controller.pageController.value,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: 3,
                    itemBuilder: (context, pageViewIndex) {
                      return OrderHistoryWidgets(
                        refreshController: _refreshController[pageViewIndex],
                        list: pageViewIndex == 0
                            ? controller.orderHistoryListWeek
                            : pageViewIndex == 1
                            ? controller.orderHistoryListHalfMonth
                            : controller.orderHistoryListMonth,
                        indexAPI: pageViewIndex,
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
