import 'dart:developer';

import 'package:adora_baby/app/modules/cart/widgets/item_card.dart';
import 'package:adora_baby/app/widgets/buttons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../main.dart';
import '../../../config/app_colors.dart';
import '../../../config/app_theme.dart';
import '../../../enums/progress_status.dart';
import '../../shop/widgets/auth_progress_indicator.dart';
import '../controllers/cart_controller.dart';
import '../widgets/cart_loaded_widget.dart';
import '../widgets/custom_error_widget.dart';
import '../widgets/empty_widget.dart';
import '../widgets/internet_error_widget.dart';

class CartView extends GetView<CartController> {
  CartView({Key? key}) : super(key: key);

  final RefreshController _refreshControllerCart =
      RefreshController(initialRefresh: false);

  @override
  Widget build(BuildContext context) {
    return progressWrap(
        Scaffold(
          backgroundColor: LightTheme.white,
          appBar: AppBar(
            backgroundColor: LightTheme.white,
            elevation: 0,
          ),
          body: SafeArea(
            child: Container(
              color: LightTheme.whiteActive,
              child: Column(
                children: [
                  GestureDetector(
                    onTap: () async {
                      log((await storage.readAccessToken()).toString());
                    },
                    child: Container(
                      color: LightTheme.white,
                      padding: EdgeInsets.only(
                        bottom: Get.height * 0.02,
                        top: Get.height * 0.02,
                      ),
                      child: Center(
                        child: Text(
                          'Cart',
                          style: kThemeData.textTheme.displaySmall
                              ?.copyWith(color: DarkTheme.normal),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: SmartRefresher(
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
                            child: Icon(Icons.expand_circle_down,
                                color: Colors.red)),
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
                      controller: _refreshControllerCart,
                      onRefresh: () {
                        controller.cart().then((value) =>
                            _refreshControllerCart.refreshCompleted());
                      },
                      child: Obx(() {
                        switch (controller.progressBarStatusCart.value) {
                          case ProgressStatus.error:
                            return const CustomErrorWidget();
                          case ProgressStatus.internetError:
                            return const InternetErrorWidget();
                          case ProgressStatus.empty:
                            return EmptyWidget();
                          case ProgressStatus.idle:
                          case ProgressStatus.loading:
                          case ProgressStatus.searching:
                          case ProgressStatus.success:
                            return CartLoadedWidget(
                              controller: controller,
                            );
                        }
                      }),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        controller.progressBarStatusCart);
  }
}
