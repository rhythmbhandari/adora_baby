
import 'package:adora_baby/app/config/app_colors.dart';
import 'package:adora_baby/app/config/app_theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../enums/progress_status.dart';
import '../../cart/widgets/custom_error_widget.dart';
import '../../cart/widgets/empty_widget.dart';
import '../../cart/widgets/internet_error_widget.dart';
import '../../shop/widgets/auth_progress_indicator.dart';
import '../controllers/profile_controller.dart';
import 'baby_profile_widget.dart';
import 'order_widget.dart';
import 'user_profile_widget.dart';

class ProfileView extends GetView<ProfileController> {
  ProfileView(this.scaffoldKey, {Key? key}) : super(key: key);

  final RefreshController _refreshControllerProfile =
      RefreshController(initialRefresh: false);
  final GlobalKey<ScaffoldState> scaffoldKey;


  @override
  Widget build(BuildContext context) {
    return progressWrap(
        Scaffold(
            backgroundColor: LightTheme.white,
            appBar: AppBar(
              backgroundColor: LightTheme.white,
              elevation: 0,
              systemOverlayStyle: const SystemUiOverlayStyle(
                statusBarColor: AppColors.primary500, // You can use this as well
                statusBarIconBrightness: Brightness.light, // OR Vice Versa for ThemeMode.dark
                statusBarBrightness: Brightness.light, // OR Vice Versa for ThemeMode.dark

              ),
            ),
            body: SafeArea(
                child: Container(
              color: LightTheme.whiteActive,
              child: Column(
                children: [
                  Container(
                    color: LightTheme.white,
                    padding: EdgeInsets.only(
                      bottom: Get.height * 0.02,
                      top: Get.height * 0.02,
                    ),
                    child: Row(
                      children: [
                        const SizedBox(
                          width: 35,
                        ),
                        const Expanded(flex: 5, child: SizedBox()),
                        Text(
                          'Profile',
                          style: kThemeData.textTheme.displaySmall
                              ?.copyWith(color: DarkTheme.normal),
                        ),
                        const Expanded(flex: 4, child: SizedBox()),
                        GestureDetector(
                            onTap: () async {
                              // try {
                              //   await storage.delete(
                              //     Constants.ACCESS_TOKEN,
                              //   );
                              //   await storage.delete(
                              //     Constants.LOGGED_IN_STATUS,
                              //   );
                              //   await storage.delete(
                              //     Constants.REFRESH_TOKEN,
                              //   );
                              //   Get.offAllNamed(Routes.PHONE);
                              // } catch (e) {
                              //   Get.offAllNamed(Routes.PHONE);
                              // }
                              scaffoldKey.currentState!.openEndDrawer();
                            },
                            child: const Icon(Icons.menu)),
                        const SizedBox(
                          width: 35,
                        )
                      ],
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
                      controller: _refreshControllerProfile,
                      onRefresh: () {
                        controller.fetchData().then((value) =>
                            _refreshControllerProfile.refreshCompleted());
                      },
                      child: Obx(() {
                        switch (controller.progressStatus.value) {
                          case ProgressStatus.error:
                            return const CustomErrorWidget();
                          case ProgressStatus.internetError:
                            return const InternetErrorWidget();
                          case ProgressStatus.empty:
                            return const EmptyWidget();
                          case ProgressStatus.idle:
                          case ProgressStatus.loading:
                          case ProgressStatus.searching:
                          case ProgressStatus.success:
                            return SingleChildScrollView(
                              child: Column(
                                children: [
                                  userProfile(
                                    controller,
                                    context,
                                  ),
                                  babyProfile(
                                    controller,
                                    context,
                                  ),
                                  OrderWidget(
                                    controller: controller,
                                  ),
                                  SizedBox(height: Get.height * 0.15)
                                ],
                              ),
                            );
                        }
                      }),
                    ),
                  ),
                ],
              ),
            ))
            // Center(
            //   child: GestureDetector(
            //     onTap: (){
            //       storage.writeData(Constants.LOGGED_IN_STATUS, null);
            //     },
            //     child: Text(
            //       'Click to remove logged in',
            //       style: TextStyle(fontSize: 20, color: Colors.green),
            //     ),
            //   ),
            // ),
            ),
        controller.progressStatus);
  }
}
