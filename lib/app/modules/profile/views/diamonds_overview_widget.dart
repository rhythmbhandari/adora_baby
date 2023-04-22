import 'package:adora_baby/app/modules/profile/controllers/profile_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:shimmer/shimmer.dart';

import '../../../config/app_colors.dart';
import '../../../config/app_theme.dart';
import '../../../enums/progress_status.dart';
import '../../cart/widgets/custom_error_widget.dart';
import '../../cart/widgets/internet_error_widget.dart';

class DiamondsOverviewWidget extends StatelessWidget {
  final ProfileController controller = Get.find();

  final RefreshController refreshController;

  final RxList list;

  final int indexAPI;

  final Rx<ProgressStatus> progressStatus;

  DiamondsOverviewWidget({
    super.key,
    required this.refreshController,
    required this.list,
    required this.indexAPI,
    required this.progressStatus,
  });


  void _onRefresh() async {
    try {
      await controller
          .getDiamonds(
            isRefresh: true,
            isInitial: false,
            list,
            index: indexAPI,
            progressStatus,
          )
          .then((value) => refreshController.refreshCompleted());
    } catch (error) {
      refreshController.refreshFailed();
      await Future.delayed(const Duration(milliseconds: 0000)).then((value) {
        refreshController.refreshToIdle();
        indexAPI == 0
            ? controller.pieChartCalculateWeek()
            : indexAPI == 1
                ? controller.pieChartCalculateHalfMonth()
                : controller.pieChartCalculateMonth();
        controller.update();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SmartRefresher(
      physics: const AlwaysScrollableScrollPhysics(),
      enablePullDown: true,
      enablePullUp: false,
      header: ClassicHeader(
        refreshStyle: RefreshStyle.Follow,
        releaseIcon: const SizedBox(
            width: 25.0,
            height: 25.0,
            child: CupertinoActivityIndicator()),
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
            width: 25.0,
            height: 25.0,
            child: CupertinoActivityIndicator()),
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
            width: 25.0,
            height: 25.0,
            child: CupertinoActivityIndicator()),
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
            width: 25.0,
            height: 25.0,
            child: CupertinoActivityIndicator()),
      ),
      controller: refreshController,
      onRefresh: _onRefresh,
      child: Container(
        color: Colors.white,
        padding: const EdgeInsets.only(top: 16),
        child: SingleChildScrollView(
            physics: const NeverScrollableScrollPhysics(),
            child: Obx(() {
              switch (progressStatus.value) {
                case ProgressStatus.error:
                  return SizedBox(
                      height: Get.height * 0.7,
                      child: const FittedBox(child: CustomErrorWidget()));
                case ProgressStatus.internetError:
                  return SizedBox(
                      height: Get.height * 0.7,
                      child: const FittedBox(child: InternetErrorWidget()));
                case ProgressStatus.empty:
                  return Container(
                    height: Get.height * 0.85,
                    margin: EdgeInsets.symmetric(
                      vertical: Get.height * 0.02,
                    ),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        GestureDetector(
                          onTap: () {
                            // Get.to(TempView());
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 40,
                              vertical: 20,
                            ),
                            child: Text(
                              "You haven't earned any coin yet.",
                              style: Get.theme.textTheme.bodyLarge?.copyWith(
                                fontSize: 16,
                                color: DarkTheme.darkNormal,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: Get.height * 0.05,
                        ),
                        Center(
                          child: SvgPicture.asset(
                            'assets/images/oops.svg',
                            width: Get.width * 0.8,
                            // height: Get.height * 0.4,
                          ),
                        ),

                        const SizedBox(
                          height: 5,
                        ),
                        Container(
                          margin: const EdgeInsets.symmetric(horizontal: 25),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 18,
                            vertical: 22,
                          ),
                          decoration: BoxDecoration(
                              border: Border.all(
                                color: DarkTheme.lighter,
                                width: 0.1,
                              ),
                              color: Colors.white,
                              boxShadow: const [
                                BoxShadow(
                                  color: Color.fromRGBO(0, 0, 0, 0.18),
                                  blurRadius: 3,
                                  spreadRadius: 1,
                                  offset: Offset(
                                    -0,
                                    2,
                                  ), // Shadow position
                                ),
                              ],
                              borderRadius: BorderRadius.circular(20)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SvgPicture.asset(
                                "assets/images/info-circle.svg",
                                height: 22,
                                // color: const Color(0xff667080),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                child: Text(
                                  'The more you shop, the more you earn!\n\nDiamonds are great way to enjoy discounts while buying products from Adora App.\n\nGet diamonds with each of your purchase. ',
                                  textAlign: TextAlign.start,
                                  style: kThemeData.textTheme.bodyMedium?.copyWith(
                                    color: DarkTheme.darkNormal,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                case ProgressStatus.idle:
                case ProgressStatus.loading:
                case ProgressStatus.searching:
                case ProgressStatus.success:
                  return GetBuilder<ProfileController>(
                    builder: (value) => list.isNotEmpty
                        ? pieChartWidget(
                            indexAPI == 0
                                ? value.dataMap
                                : indexAPI == 1
                                    ? value.dataMapHalfMonth
                                    : value.dataMapMonth,
                            context)
                        : Shimmer.fromColors(
                            baseColor: Colors.white,
                            highlightColor: LightTheme.lightActive,
                            enabled: true,
                            child: buildImagePieCart(),
                          ),
                  );
              }
            })),
      ),
    );
  }
}

Widget buildImagePieCart() {
  return GridView.count(
    childAspectRatio: 3,
    physics: const NeverScrollableScrollPhysics(),
    shrinkWrap: true,
    crossAxisCount: 1,
    children: List.generate(
      5,
      (index) => Container(
        padding: const EdgeInsets.only(top: 10),
        margin: const EdgeInsets.only(left: 52, right: 52, bottom: 16),
        alignment: Alignment.center,
        decoration: BoxDecoration(
            color: Colors.white,
            border:
                Border.all(color: const Color.fromRGBO(192, 144, 254, 0.25)),
            borderRadius: BorderRadius.circular(15)),
        child: Container(
            padding: const EdgeInsets.only(left: 5, right: 5),
            decoration: const BoxDecoration(
                color: Color.fromRGBO(243, 234, 249, 1),
                borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(15),
                    bottomLeft: Radius.circular(15))),
            child: Text(
              "snapshot.data![index].name",
              style: kThemeData.textTheme.bodyMedium,
            )),
      ),
    ),
  );
}

Widget pieChartWidget(Map<String, double> value, BuildContext context) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      const SizedBox(
        height: 60,
      ),
      Stack(
        children: [
          Positioned(
              right: 20,
              top: 0,
              child: Text(
                '${value['Diamonds Spent']}\nDiamonds\nSpent',
                style: kThemeData.textTheme.labelSmall?.copyWith(
                  color: DarkTheme.darkNormal,
                ),
              )),
          Positioned(
              left: 20,
              bottom: 0,
              child: Text(
                '${value['Diamonds Earned']}\nDiamonds\nEarned',
                textAlign: TextAlign.end,
                style: kThemeData.textTheme.labelSmall?.copyWith(
                  color: DarkTheme.darkNormal,
                ),
              )),
          PieChart(
            dataMap: value,
            animationDuration: const Duration(milliseconds: 800),
            chartLegendSpacing: 32,
            chartRadius: MediaQuery.of(context).size.width / 2,
            colorList: const <Color>[
              Color.fromRGBO(
                1,
                125,
                29,
                1,
              ),
              Color.fromRGBO(
                164,
                36,
                36,
                1,
              ),
            ],
            initialAngleInDegree: 10,
            chartType: ChartType.ring,
            ringStrokeWidth: 33,
            legendOptions: LegendOptions(
              showLegendsInRow: false,
              legendPosition: LegendPosition.right,
              showLegends: false,
              legendLabels: const {
                "Diamonds Spent": "Diamonds\nSpent",
                "Diamonds Earned": "Diamonds\nEarned",
              },
              // legendShape: BoxShape.circle,
              legendTextStyle: kThemeData.textTheme.labelSmall!
                  .copyWith(color: DarkTheme.dark),
            ),
            chartValuesOptions: const ChartValuesOptions(
              showChartValueBackground: true,
              showChartValues: false,
              showChartValuesInPercentage: false,
              showChartValuesOutside: true,
              decimalPlaces: 1,
            ),
            // gradientList: ---To add gradient colors---
            // emptyColorGradient: ---Empty Color gradient---
          ),
        ],
      ),
      const SizedBox(
        height: 60,
      ),
      Container(
        margin: const EdgeInsets.symmetric(horizontal: 25),
        padding: const EdgeInsets.symmetric(
          horizontal: 18,
          vertical: 22,
        ),
        decoration: BoxDecoration(
            border: Border.all(
              color: DarkTheme.lighter,
              width: 0.1,
            ),
            color: Colors.white,
            boxShadow: const [
              BoxShadow(
                color: Color.fromRGBO(0, 0, 0, 0.18),
                blurRadius: 3,
                spreadRadius: 1,
                offset: Offset(
                  -0,
                  2,
                ), // Shadow position
              ),
            ],
            borderRadius: BorderRadius.circular(20)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SvgPicture.asset(
              "assets/images/info-circle.svg",
              height: 22,
              // color: const Color(0xff667080),
            ),
            const SizedBox(
              width: 10,
            ),
            Expanded(
              child: Text(
                'The more you shop, the more you earn!\n\nDiamonds are great way to enjoy discounts while buying products from Adora App.\n\nGet diamonds with each of your purchase. ',
                textAlign: TextAlign.start,
                style: kThemeData.textTheme.bodyMedium?.copyWith(
                  color: DarkTheme.darkNormal,
                ),
              ),
            ),
          ],
        ),
      ),
    ],
  );
}
