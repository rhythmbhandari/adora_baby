import 'package:adora_baby/app/modules/profile/controllers/profile_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:shimmer/shimmer.dart';

import '../../../config/app_colors.dart';
import '../../../config/app_theme.dart';
import '../../../enums/progress_status.dart';
import '../../../utils/date_time_converter.dart';
import '../../cart/widgets/custom_error_widget.dart';
import '../../cart/widgets/internet_error_widget.dart';

class DiamondsStatementWidget extends StatelessWidget {
  final ProfileController controller = Get.find();

  final RefreshController refreshController;

  final RxList list;

  final int indexAPI;

  final Rx<ProgressStatus> progressStatus;

  DiamondsStatementWidget({
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
      await Future.delayed(const Duration(milliseconds: 0000))
          .then((value) => refreshController.refreshToIdle());
    }
  }

  void _onLoading() async {
    try {
      await controller
          .getDiamonds(
              isRefresh: true,
              isInitial: false,
              list,
              index: indexAPI,
              progressStatus)
          .then((value) => refreshController.loadComplete());
    } catch (error) {
      refreshController.loadNoData();
      await Future.delayed(const Duration(milliseconds: 0000))
          .then((value) => refreshController.refreshToIdle());
    }
  }

  @override
  Widget build(BuildContext context) {
    return SmartRefresher(
      physics: const AlwaysScrollableScrollPhysics(),
      enablePullDown: true,
      enablePullUp: true,
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
      onLoading: _onLoading,
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
                                'No coins were recently used.',
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
                        ],
                      ),
                    );
                  case ProgressStatus.idle:
                  case ProgressStatus.loading:
                  case ProgressStatus.searching:
                  case ProgressStatus.success:
                    return list.isNotEmpty
                        ? ListView.separated(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: list.length,
                            separatorBuilder: (context, index) {
                              return Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 6,
                                ),
                                child: const Divider(
                                  color: Color(
                                    0xffAF98A8,
                                  ),
                                  thickness: 0.8,
                                ),
                              );
                            },
                            itemBuilder: (BuildContext context, int index) =>
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 27.5,
                                  ),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              list[index]
                                                      .types
                                                      .toString()
                                                      .toLowerCase()
                                                      .contains('earned')
                                                  ? 'Diamonds earned on'
                                                  : 'Diamonds spent on',
                                              style: kThemeData
                                                  .textTheme.titleMedium
                                                  ?.copyWith(
                                                color: DarkTheme.darkNormal,
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 5,
                                            ),
                                            Text(
                                              'Order #${list[index].id}',
                                              style: kThemeData
                                                  .textTheme.titleMedium
                                                  ?.copyWith(
                                                color: AppColors.primary600,
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 5,
                                            ),
                                            Text(
                                              DateTimeConverter.diamondsData(
                                                  list[index].updatedAt),
                                              style: kThemeData
                                                  .textTheme.bodyMedium
                                                  ?.copyWith(
                                                color: DarkTheme.darkNormal,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 20,
                                      ),
                                      Container(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 15,
                                          vertical: 13,
                                        ),
                                        decoration: BoxDecoration(
                                          color: list[index]
                                                  .types
                                                  .toString()
                                                  .toLowerCase()
                                                  .contains('earned')
                                              ? const Color(0xff017D1D)
                                              : AppColors.error700,
                                          borderRadius: BorderRadius.circular(
                                            20,
                                          ),
                                        ),
                                        child: Row(
                                          children: [
                                            SvgPicture.asset(
                                              "assets/images/profile_diamonds.svg",
                                              // height: 0.022 * Get.height,
                                            ),
                                            const SizedBox(
                                              width: 8,
                                            ),
                                            Text(
                                              '${list[index].amount}',
                                              style: kThemeData
                                                  .textTheme.bodyLarge
                                                  ?.copyWith(
                                                color: Colors.white,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ))
                        : Shimmer.fromColors(
                            baseColor: Colors.white,
                            highlightColor: LightTheme.lightActive,
                            enabled: true,
                            child: buildImageDiamond(),
                          );
                }
              }))),
    );
  }
}

Widget buildImageDiamond() {
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
