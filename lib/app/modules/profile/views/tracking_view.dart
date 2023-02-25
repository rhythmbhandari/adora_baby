import 'dart:developer';

import 'package:adora_baby/app/utils/date_time_converter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:timelines/timelines.dart';

import '../../../config/app_colors.dart';
import '../../../config/app_theme.dart';
import '../../../data/models/order_logs_model.dart';
import '../../cart/widgets/empty_widget.dart';
import '../../cart/widgets/internet_error_widget.dart';
import '../controllers/profile_controller.dart';

class TrackingView extends GetView<ProfileController> {
  const TrackingView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      key: new PageStorageKey('track_my_order'),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.only(
              top: 24,
              left: 35,
              right: 35,
            ),
            alignment: Alignment.topLeft,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Estimated Time ',
                  style: kThemeData.textTheme.bodyLarge?.copyWith(
                    color: DarkTheme.darkNormal,
                  ),
                ),
                Text(
                  controller.selectedOrders.value.status
                          .toString()
                          .toLowerCase()
                          .contains('canceled')
                      ? 'N/A'
                      : controller.selectedOrders.value.estimatedTime == null
                          ? 'N/A'
                          : ' ${DateTimeConverter.bookingDetailsDate(controller.selectedOrders.value.estimatedTime ?? DateTime.now())}',
                  style: kThemeData.textTheme.titleMedium?.copyWith(
                    color: DarkTheme.darkNormal,
                  ),
                ),
                SizedBox(),
                SizedBox()
              ],
            ),
          ),
          Container(
              padding: EdgeInsets.only(
                left: 25,
                right: 35,
                top: 30,
                bottom: 50,
              ),
              child: FutureBuilder<List<OrderLogsModel>>(
                future: controller.initiateTrackOrder(),
                builder: (context, snapshot) {
                  log('Snapshot is ${snapshot.data}');
                  if (snapshot.hasData) {
                    if (snapshot.data != null && snapshot.data!.isNotEmpty) {
                      return DefaultTextStyle(
                        style: TextStyle(
                          color: Color(0xff9b9b9b),
                          fontSize: 12.5,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(0.0),
                          child: FixedTimeline.tileBuilder(
                            theme: TimelineThemeData(
                              nodePosition: 0,
                              color: Color(0xff989898),
                              indicatorTheme: IndicatorThemeData(
                                position: 0.3,
                                size: 20.0,
                              ),
                              connectorTheme: ConnectorThemeData(
                                space: 59,
                                thickness: 2,
                              ),
                            ),
                            builder: TimelineTileBuilder.connected(
                              connectionDirection: ConnectionDirection.before,
                              itemCount: snapshot.data?.length ?? 0,
                              contentsBuilder: (_, index) {
                                return Container(
                                  padding: EdgeInsets.only(bottom: 20),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        width: 32,
                                      ),
                                      SizedBox(
                                        height: Get.height * 0.06,
                                        width: Get.height * 0.06,
                                        // width: Get.height * 0.055,
                                        child: (snapshot.data?[index]
                                                        .orderStatus ??
                                                    '')
                                                .toString()
                                                .toLowerCase()
                                                .contains('order')
                                            ? SvgPicture.asset(
                                                "assets/images/order_placed.svg")
                                            : (snapshot.data?[index].orderStatus ??
                                                        '')
                                                    .toString()
                                                    .toLowerCase()
                                                    .contains('package')
                                                ? SvgPicture.asset(
                                                    "assets/images/package_created.svg")
                                                : (snapshot.data?[index]
                                                                .orderStatus ??
                                                            '')
                                                        .toString()
                                                        .toLowerCase()
                                                        .contains('shipped')
                                                    ? SvgPicture.asset(
                                                        "assets/images/shipped.svg")
                                                    : (snapshot.data?[index]
                                                                    .orderStatus ??
                                                                '')
                                                            .toString()
                                                            .toLowerCase()
                                                            .contains(
                                                                'delivered')
                                                        ? SvgPicture.asset(
                                                            "assets/images/shipped.svg")
                                                        : SvgPicture.asset(
                                                            "assets/images/canceled.svg"),
                                      ),
                                      SizedBox(
                                        width: 8,
                                      ),
                                      Expanded(
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              '${snapshot.data?[index].orderStatus}.'
                                                      .replaceAll(
                                                          RegExp('[^A-Za-z]'),
                                                          ' ')
                                                      .toLowerCase()
                                                      .capitalize ??
                                                  '',
                                              maxLines: 1,
                                              style: kThemeData
                                                  .textTheme.labelMedium
                                                  ?.copyWith(
                                                color: DarkTheme.darkNormal,
                                              ),
                                            ),
                                            (snapshot.data?[index].orderStatus ?? '')
                                                    .toString()
                                                    .toLowerCase()
                                                    .contains('order_placed')
                                                ? Text(
                                                    'We have received your order.\n',
                                                    maxLines: 2,
                                                    style: kThemeData
                                                        .textTheme.bodyMedium
                                                        ?.copyWith(
                                                      color:
                                                          DarkTheme.darkNormal,
                                                    ),
                                                  )
                                                : (snapshot.data?[index]
                                                                .orderStatus ??
                                                            '')
                                                        .toString()
                                                        .toLowerCase()
                                                        .contains(
                                                            'order_confirm')
                                                    ? Text(
                                                        'We have confirmed your order.\n',
                                                        maxLines: 2,
                                                        style: kThemeData
                                                            .textTheme
                                                            .bodyMedium
                                                            ?.copyWith(
                                                          color: DarkTheme
                                                              .darkNormal,
                                                        ),
                                                      )
                                                    : (snapshot.data?[index]
                                                                    .orderStatus ??
                                                                '')
                                                            .toString()
                                                            .toLowerCase()
                                                            .contains('package')
                                                        ? Text(
                                                            'We have packed your order.\n',
                                                            maxLines: 2,
                                                            style: kThemeData
                                                                .textTheme
                                                                .bodyMedium
                                                                ?.copyWith(
                                                              color: DarkTheme
                                                                  .darkNormal,
                                                            ),
                                                          )
                                                        : (snapshot.data?[index]
                                                                        .orderStatus ??
                                                                    '')
                                                                .toString()
                                                                .toLowerCase()
                                                                .contains(
                                                                    'shipped')
                                                            ? Text(
                                                                'We are shipping your order.\n',
                                                                maxLines: 2,
                                                                style: kThemeData
                                                                    .textTheme
                                                                    .bodyMedium
                                                                    ?.copyWith(
                                                                  color: DarkTheme
                                                                      .darkNormal,
                                                                ),
                                                              )
                                                            : (snapshot.data?[index].orderStatus ?? '')
                                                                    .toString()
                                                                    .toLowerCase()
                                                                    .contains(
                                                                        'hold')
                                                                ? Text(
                                                                    'Your order is put on hold.\n',
                                                                    maxLines: 2,
                                                                    style: kThemeData
                                                                        .textTheme
                                                                        .bodyMedium
                                                                        ?.copyWith(
                                                                      color: DarkTheme
                                                                          .darkNormal,
                                                                    ),
                                                                  )
                                                                : (snapshot.data?[index].orderStatus ?? '')
                                                                        .toString()
                                                                        .toLowerCase()
                                                                        .contains('delivered')
                                                                    ? Text(
                                                                        'Your order is delivered\n',
                                                                        maxLines:
                                                                            2,
                                                                        style: kThemeData
                                                                            .textTheme
                                                                            .bodyMedium
                                                                            ?.copyWith(
                                                                          color:
                                                                              DarkTheme.darkNormal,
                                                                        ),
                                                                      )
                                                                    : (snapshot.data?[index].orderStatus ?? '').toString().toLowerCase().contains('pre')
                                                                        ? Text(
                                                                            'Your order is pre ordered\n',
                                                                            maxLines:
                                                                                2,
                                                                            style:
                                                                                kThemeData.textTheme.bodyMedium?.copyWith(
                                                                              color: DarkTheme.darkNormal,
                                                                            ),
                                                                          )
                                                                        : (snapshot.data?[index].orderStatus ?? '').toString().toLowerCase().contains('terminated')
                                                                            ? Text(
                                                                                'Your order is terminated\n',
                                                                                maxLines: 2,
                                                                                style: kThemeData.textTheme.bodyMedium?.copyWith(
                                                                                  color: DarkTheme.darkNormal,
                                                                                ),
                                                                              )
                                                                            : Text(
                                                                                'Your order was canceled.\n',
                                                                                maxLines: 2,
                                                                                style: kThemeData.textTheme.bodyMedium?.copyWith(
                                                                                  color: DarkTheme.darkNormal,
                                                                                ),
                                                                              )
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              },
                              indicatorBuilder: (_, index) {
                                if ((snapshot.data?[index].orderStatus ?? '')
                                        .toString()
                                        .toLowerCase()
                                        .contains('canceled') ||
                                    (snapshot.data?[index].orderStatus ?? '')
                                        .toString()
                                        .toLowerCase()
                                        .contains('terminated') ||
                                    (snapshot.data?[index].orderStatus ?? '')
                                        .toString()
                                        .toLowerCase()
                                        .contains('hold')) {
                                  return OutlinedDotIndicator(
                                    color: AppColors.error500,
                                    borderWidth: 1.5,
                                  );
                                } else if (index ==
                                    (snapshot.data?.length ?? 0)) {
                                  return OutlinedDotIndicator(
                                    color: DarkTheme.darkNormal,
                                    borderWidth: 1.5,
                                  );
                                } else {
                                  return DotIndicator(
                                    color: AppColors.success300,
                                    child: Icon(
                                      Icons.check,
                                      color: Colors.white,
                                      size: 12.0,
                                    ),
                                  );
                                }
                              },
                              connectorBuilder: (_, index, ___) => Container(
                                // height: 50,
                                child: SolidLineConnector(
                                  thickness: 2,
                                  color: (snapshot.data?[index].orderStatus ??
                                                  '')
                                              .toString()
                                              .toLowerCase()
                                              .contains('canceled') ||
                                          (snapshot.data?[index].orderStatus ??
                                                  '')
                                              .toString()
                                              .toLowerCase()
                                              .contains('terminated') ||
                                          (snapshot.data?[index].orderStatus ??
                                                  '')
                                              .toString()
                                              .toLowerCase()
                                              .contains('hold')
                                      ? AppColors.error500
                                      : AppColors.success300,
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    } else {
                      return Container(
                          height: Get.height * 0.6,
                          child: FittedBox(child: EmptyWidget()));
                    }
                  } else if (snapshot.hasError) {
                    return Container(
                        height: Get.height * 0.6,
                        child: FittedBox(child: InternetErrorWidget()));
                  }
                  return Container(
                      height: Get.height * 0.6,
                      child: FittedBox(child: InternetErrorWidget()));
                },
              )),
        ],
      ),
    );
  }
}
