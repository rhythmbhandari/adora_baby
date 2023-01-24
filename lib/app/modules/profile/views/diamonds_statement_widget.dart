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

class DiamondsStatementWidget extends StatelessWidget {
  final ProfileController controller = Get.find();

  final RefreshController refreshController;

  final RxList list;

  final int indexAPI;

  DiamondsStatementWidget({
    super.key,
    required this.refreshController,
    required this.list,
    required this.indexAPI,
  });

  void _onRefresh() async {
    await controller
        .getDiamonds(isRefresh: true, isInitial: false, list, index: indexAPI)
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
        .getDiamonds(isRefresh: false, isInitial: false, list, index: indexAPI)
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
              ? ListView.separated(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: list.length,
                  separatorBuilder: (context, index) {
                    return Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 6,
                      ),
                      child: Divider(
                        color: Color(
                          0xffAF98A8,
                        ),
                        thickness: 0.8,
                      ),
                    );
                  },
                  itemBuilder: (BuildContext context, int index) => Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 27.5,
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Diamonds earned on',
                                    style: kThemeData.textTheme.titleMedium
                                        ?.copyWith(
                                      color: DarkTheme.dark,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    'Order #${list[index].orderId}',
                                    style: kThemeData.textTheme.titleMedium
                                        ?.copyWith(
                                      color: AppColors.primary600,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    DateTimeConverter.diamondsData(
                                        list[index].updatedAt),
                                    style: kThemeData.textTheme.bodyMedium
                                        ?.copyWith(
                                      color: DarkTheme.dark,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: 15,
                                vertical: 13,
                              ),
                              decoration: BoxDecoration(
                                color: list[index].types.toString().toLowerCase().contains('earned')
                                    ? Color(0xff017D1D)
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
                                  SizedBox(
                                    width: 8,
                                  ),
                                  Text(
                                    '${list[index].amount}',
                                    style: kThemeData.textTheme.bodyLarge
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
              : Container()),
        ),
      ),
    );
  }
}
