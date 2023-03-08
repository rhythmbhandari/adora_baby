import 'dart:developer';

import 'package:adora_baby/app/modules/cart/widgets/empty_widget.dart';
import 'package:adora_baby/app/modules/cart/widgets/internet_error_widget.dart';
import 'package:adora_baby/app/modules/profile/controllers/profile_controller.dart';
import 'package:adora_baby/app/modules/profile/views/cancel_order_dialog.dart';
import 'package:adora_baby/app/modules/profile/views/tracking_view.dart';
import 'package:adora_baby/app/widgets/custom_progress_bar.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:timelines/timelines.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../config/app_colors.dart';
import '../../../config/app_theme.dart';
import '../../../data/models/order_logs_model.dart';
import '../../../enums/progress_status.dart';
import '../../../routes/app_pages.dart';
import '../../../utils/date_time_converter.dart';
import '../../../widgets/buttons.dart';
import '../../../widgets/gradient_icon.dart';
import '../../shop/views/getBrandName.dart';
import 'package_delivery_tracking.dart';

class OrderHistoryDetail extends GetView<ProfileController> {
  OrderHistoryDetail({Key? key}) : super(key: key);

  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return true;
      },
      child: Obx(() => Stack(
            children: [
              Scaffold(
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
                                style:
                                    kThemeData.textTheme.displaySmall?.copyWith(
                                  color: DarkTheme.darkNormal,
                                ),
                              ),
                            ),
                            Expanded(
                              child: NestedScrollView(
                                headerSliverBuilder:
                                    (context, innerBoxIsScrolled) => [
                                  // The flexible app bar with the tabs
                                  SliverAppBar(
                                    backgroundColor: Colors.white,
                                    flexibleSpace: TabBar(
                                        labelStyle: kThemeData
                                            .textTheme.labelMedium
                                            ?.copyWith(
                                          color: DarkTheme.darkNormal,
                                          fontSize: 18,
                                        ),
                                        isScrollable: false,
                                        unselectedLabelColor: DarkTheme.lighter,
                                        unselectedLabelStyle: kThemeData
                                            .textTheme.labelMedium
                                            ?.copyWith(
                                          color: DarkTheme.lighter,
                                          fontSize: 18,
                                        ),
                                        labelColor: DarkTheme.darkNormal,
                                        indicatorColor: DarkTheme.darkNormal,
                                        indicatorSize:
                                            TabBarIndicatorSize.label,
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
                                    SingleChildScrollView(
                                      key: new PageStorageKey('details'),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          for (int i = 0;
                                              i <
                                                  controller
                                                      .selectedOrders
                                                      .value
                                                      .checkOut!
                                                      .cart!
                                                      .length;
                                              i++)
                                            Container(
                                              padding: EdgeInsets.symmetric(
                                                horizontal: 23,
                                                vertical: 24,
                                              ),
                                              margin: EdgeInsets.symmetric(
                                                  horizontal: 23, vertical: 16),
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                                border: Border.all(
                                                    color: Colors.black
                                                        .withOpacity(0.05)),
                                                color: Colors.white,
                                                boxShadow: [
                                                  const BoxShadow(
                                                    color: Color.fromRGBO(
                                                        0, 0, 0, 0.25),
                                                    blurRadius: 0.5,
                                                    spreadRadius: 0.5,
                                                    offset: Offset(-0,
                                                        0.5), // Shadow position
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
                                                    placeholder: (context,
                                                            url) =>
                                                        const Center(
                                                            child:
                                                                CircularProgressIndicator()),
                                                    errorWidget: (context, url,
                                                            error) =>
                                                        const Icon(Icons.error),
                                                  ),
                                                  Expanded(
                                                    child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                          getBrandName(controller.selectedOrders.value.checkOut?.cart?[i]?.product?.categories),
                                                          maxLines: 1,
                                                          style: kThemeData
                                                              .textTheme
                                                              .bodyMedium
                                                              ?.copyWith(
                                                            color: AppColors
                                                                .secondary700,
                                                          ),
                                                        ),
                                                        Text(
                                                          '${controller.selectedOrders.value.checkOut?.cart?[i]?.product?.name}',
                                                          maxLines: 4,
                                                          style: kThemeData
                                                              .textTheme
                                                              .titleMedium
                                                              ?.copyWith(
                                                            color: AppColors
                                                                .primary700,
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          height: 20,
                                                        ),
                                                        Container(
                                                          padding:
                                                              const EdgeInsets
                                                                      .symmetric(
                                                                  horizontal:
                                                                      15,
                                                                  vertical: 3),
                                                          decoration: BoxDecoration(
                                                              shape: BoxShape
                                                                  .rectangle,
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          10),
                                                              border: Border.all(
                                                                  color: DarkTheme
                                                                      .normal)),
                                                          child: Text(
                                                            '${controller.selectedOrders.value.checkOut?.cart?[i]?.quantity}',
                                                            maxLines: 1,
                                                            style: kThemeData
                                                                .textTheme
                                                                .titleMedium
                                                                ?.copyWith(
                                                              color: AppColors
                                                                  .primary700,
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
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 32),
                                            child: Text(
                                              'Payment Method',
                                              maxLines: 1,
                                              style: kThemeData
                                                  .textTheme.titleMedium
                                                  ?.copyWith(
                                                color: DarkTheme.darkNormal,
                                              ),
                                            ),
                                          ),
                                          Container(
                                              padding: EdgeInsets.symmetric(
                                                horizontal: 23,
                                                vertical: 24,
                                              ),
                                              margin: EdgeInsets.symmetric(
                                                  horizontal: 32, vertical: 16),
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                                border: Border.all(
                                                    color: Colors.black
                                                        .withOpacity(0.05)),
                                                color: Colors.white,
                                                boxShadow: [
                                                  const BoxShadow(
                                                    color: Color.fromRGBO(
                                                        0, 0, 0, 0.06),
                                                    blurRadius: 0.2,
                                                    spreadRadius: 0.5,
                                                    offset: Offset(0,
                                                        2), // Shadow position
                                                  ),
                                                ],
                                              ),
                                              child: Row(
                                                children: [
                                                  SizedBox(
                                                    width: 33,
                                                  ),
                                                  SvgPicture.asset(
                                                    "assets/images/wallet-money.svg",
                                                    // height: 22,
                                                    // color: Color(0xff667080)
                                                  ),
                                                  SizedBox(
                                                    width: 33,
                                                  ),
                                                  Expanded(
                                                    child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                          'Cash on Delivery',
                                                          style: kThemeData
                                                              .textTheme
                                                              .titleMedium
                                                              ?.copyWith(
                                                                  color:
                                                                      DarkTheme
                                                                          .dark),
                                                        ),
                                                        Text(
                                                          'Pay Cash upon delivery',
                                                          style: kThemeData
                                                              .textTheme
                                                              .bodyMedium
                                                              ?.copyWith(
                                                                  color:
                                                                      DarkTheme
                                                                          .dark),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              )),
                                          Container(
                                              padding: EdgeInsets.symmetric(
                                                horizontal: 23,
                                                vertical: 24,
                                              ),
                                              margin: EdgeInsets.symmetric(
                                                  horizontal: 32, vertical: 0),
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                                border: Border.all(
                                                    color: Colors.black
                                                        .withOpacity(0.05)),
                                                color: Colors.white,
                                                boxShadow: [
                                                  const BoxShadow(
                                                    color: Color.fromRGBO(
                                                        0, 0, 0, 0.06),
                                                    blurRadius: 0.2,
                                                    spreadRadius: 0.5,
                                                    offset: Offset(0,
                                                        2), // Shadow position
                                                  ),
                                                ],
                                              ),
                                              child: Row(
                                                children: [
                                                  SizedBox(
                                                    width: 33,
                                                  ),
                                                  SvgPicture.asset(
                                                      "assets/images/profile_diamonds.svg",
                                                      height: 35,
                                                      color: DarkTheme.dark),
                                                  SizedBox(
                                                    width: 33,
                                                  ),
                                                  Expanded(
                                                    child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                          '${controller.selectedOrders.value.checkOut?.dimondOff ?? 0} Diamonds used',
                                                          style: kThemeData
                                                              .textTheme
                                                              .titleMedium
                                                              ?.copyWith(
                                                                  color:
                                                                      DarkTheme
                                                                          .dark),
                                                        ),
                                                        Text(
                                                          'Rs. ${controller.selectedOrders.value.checkOut?.dimondOff ?? 0} off',
                                                          style: kThemeData
                                                              .textTheme
                                                              .bodyMedium
                                                              ?.copyWith(
                                                                  color:
                                                                      DarkTheme
                                                                          .dark),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              )),
                                          Container(
                                            height: Get.height * 0.02,
                                          ),
                                          Container(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 32),
                                            child: Text(
                                              'Applied Coupon',
                                              maxLines: 1,
                                              style: kThemeData
                                                  .textTheme.titleMedium
                                                  ?.copyWith(
                                                color: DarkTheme.darkNormal,
                                              ),
                                            ),
                                          ),
                                          Container(
                                            margin: const EdgeInsets.only(
                                                top: 20.0,
                                                left: 32,
                                                right: 32,
                                                bottom: 10),
                                            color: Colors.white,
                                            child: TextField(
                                              readOnly: true,
                                              enabled: false,
                                              cursorColor: AppColors.primary300,
                                              decoration: InputDecoration(
                                                label: Text(
                                                  (controller
                                                              .selectedOrders
                                                              .value
                                                              .checkOut
                                                              ?.isCouponUse ??
                                                          false
                                                      ? '${controller.selectedOrders.value.checkOut?.couponCode ?? 'N/A'}'
                                                      : 'N/A'),
                                                  style: TextStyle(
                                                      fontSize: 16,
                                                      fontFamily: 'Poppins',
                                                      fontWeight:
                                                          FontWeight.w400),
                                                ),
                                                floatingLabelBehavior:
                                                    FloatingLabelBehavior.never,
                                                hintStyle: kThemeData
                                                    .textTheme.bodyLarge,
                                                contentPadding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 30,
                                                        vertical: 8),
                                                suffixIcon: Padding(
                                                  padding: EdgeInsets.all(12),
                                                  child: SvgPicture.asset(
                                                      "assets/images/tag.svg",
                                                      color: DarkTheme.dark),
                                                ),
                                                fillColor: Colors.white,
                                                border: OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                        width: 1,
                                                        color: AppColors
                                                            .secondary500),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                      33,
                                                    )),
                                              ),
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
                                            padding: EdgeInsets.symmetric(
                                              horizontal: 56,
                                            ),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  'Sub Total',
                                                  style: kThemeData
                                                      .textTheme.bodyLarge
                                                      ?.copyWith(
                                                          color:
                                                              DarkTheme.dark),
                                                ),
                                                Text(
                                                  '${controller.selectedOrders.value.checkOut?.subTotal}',
                                                  style: kThemeData
                                                      .textTheme.titleMedium
                                                      ?.copyWith(
                                                          color:
                                                              DarkTheme.dark),
                                                )
                                              ],
                                            ),
                                          ),
                                          Container(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 56, vertical: 5),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  'Diamond Off',
                                                  style: kThemeData
                                                      .textTheme.bodyLarge
                                                      ?.copyWith(
                                                          color:
                                                              DarkTheme.dark),
                                                ),
                                                Text(
                                                  '${controller.selectedOrders.value.checkOut?.dimondOff}',
                                                  style: kThemeData
                                                      .textTheme.titleMedium
                                                      ?.copyWith(
                                                          color:
                                                              DarkTheme.dark),
                                                )
                                              ],
                                            ),
                                          ),
                                          Container(
                                            padding: EdgeInsets.only(
                                                left: 56, right: 56, bottom: 5),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  'Discount',
                                                  style: kThemeData
                                                      .textTheme.bodyLarge
                                                      ?.copyWith(
                                                          color:
                                                              DarkTheme.dark),
                                                ),
                                                Text(
                                                  '${controller.selectedOrders.value.checkOut?.discount}',
                                                  style: kThemeData
                                                      .textTheme.titleMedium
                                                      ?.copyWith(
                                                          color:
                                                              DarkTheme.dark),
                                                )
                                              ],
                                            ),
                                          ),
                                          Container(
                                            padding: EdgeInsets.only(
                                                left: 56, right: 56, bottom: 5),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  'Delivery Charge',
                                                  style: kThemeData
                                                      .textTheme.bodyLarge
                                                      ?.copyWith(
                                                          color:
                                                              DarkTheme.dark),
                                                ),
                                                Text(
                                                  '${controller.selectedOrders.value.checkOut?.deliveryCharge}',
                                                  style: kThemeData
                                                      .textTheme.titleMedium
                                                      ?.copyWith(
                                                          color:
                                                              DarkTheme.dark),
                                                )
                                              ],
                                            ),
                                          ),
                                          Container(
                                            padding: EdgeInsets.only(
                                                left: 56,
                                                right: 56,
                                                bottom: 5,
                                                top: 20),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  'Grand Total',
                                                  style: kThemeData
                                                      .textTheme.bodyLarge
                                                      ?.copyWith(
                                                          color:
                                                              DarkTheme.dark),
                                                ),
                                                Text(
                                                  '${controller.selectedOrders.value.checkOut?.grandTotal}',
                                                  style: kThemeData
                                                      .textTheme.titleMedium
                                                      ?.copyWith(
                                                          color:
                                                              DarkTheme.dark),
                                                )
                                              ],
                                            ),
                                          ),
                                          Container(
                                            height: Get.height * 0.02,
                                          ),
                                          Container(
                                            height: Get.height * 0.04,
                                            color: Color.fromRGBO(
                                              250,
                                              245,
                                              252,
                                              1,
                                            ),
                                          ),
                                          controller.selectedOrders.value.status
                                                  .toString()
                                                  .toLowerCase()
                                                  .contains('order')
                                              ? Container(
                                                  padding: EdgeInsets.only(
                                                    left: 32,
                                                    right: 32,
                                                  ),
                                                  color: Color.fromRGBO(
                                                    250,
                                                    245,
                                                    252,
                                                    1,
                                                  ),
                                                  child: GestureDetector(
                                                    onTap: () async {
                                                      try {
                                                        Uri url = Uri.parse(
                                                            'https://www.facebook.com/adorababies');
                                                        if (await canLaunchUrl(
                                                            url)) {
                                                          await launchUrl(url);
                                                        } else {
                                                          throw 'Could not launch $url';
                                                        }
                                                      } catch (error) {
                                                        await launchUrl(Uri.parse(
                                                            'https://www.google.com/search?q=adorababies'));
                                                      }
                                                    },
                                                    child: Container(
                                                      padding:
                                                          const EdgeInsets.only(
                                                        top: 20,
                                                        bottom: 20,
                                                        left: 40,
                                                        right: 40,
                                                      ),
                                                      decoration: BoxDecoration(
                                                        color: AppColors
                                                            .primary500,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(30),
                                                      ),
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          Text(
                                                              'Need Help with this Order?',
                                                              style: kThemeData
                                                                  .textTheme
                                                                  .labelMedium
                                                                  ?.copyWith(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600,
                                                              )),
                                                          SvgPicture.asset(
                                                            "assets/images/messenger.svg",
                                                            // height: 22,
                                                            // color: Color(0xff667080)
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                )
                                              : Container(),
                                          controller.selectedOrders.value.status
                                                  .toString()
                                                  .toLowerCase()
                                                  .contains('order')
                                              ? Container(
                                                  height: Get.height * 0.03,
                                                  color: Color.fromRGBO(
                                                    250,
                                                    245,
                                                    252,
                                                    1,
                                                  ),
                                                )
                                              : Container(),
                                          controller.selectedOrders.value.status
                                                  .toString()
                                                  .toLowerCase()
                                                  .contains('order')
                                              ? GestureDetector(
                                                  onTap: () async {
                                                    final status =
                                                        await showDialog<bool>(
                                                      context: context,
                                                      builder: (context) {
                                                        return CancelOrderDialog();
                                                      },
                                                    );
                                                    if (status != null) {
                                                      if (status) {
                                                        final ProfileController
                                                            controller =
                                                            Get.find();

                                                        final status =
                                                            await controller
                                                                .cancelBooking();
                                                        if (!status) {
                                                          controller
                                                              .progressBarStatusOrderDetails
                                                              .value = false;
                                                          var snackBar =
                                                              SnackBar(
                                                            elevation: 0,
                                                            behavior:
                                                                SnackBarBehavior
                                                                    .floating,
                                                            backgroundColor:
                                                                Colors.red,
                                                            duration: Duration(
                                                                milliseconds:
                                                                    2000),
                                                            content: Text(
                                                                "${controller.authError.toUpperCase()}"),
                                                          );
                                                          ScaffoldMessenger.of(
                                                                  context)
                                                              .showSnackBar(
                                                                  snackBar);
                                                        } else {
                                                          controller
                                                              .progressBarStatusOrderDetails
                                                              .value = false;
                                                          var snackBar =
                                                              SnackBar(
                                                            elevation: 0,
                                                            behavior:
                                                                SnackBarBehavior
                                                                    .floating,
                                                            backgroundColor:
                                                                AppColors
                                                                    .success500,
                                                            duration: Duration(
                                                                milliseconds:
                                                                    2000),
                                                            content: Text(
                                                                "Order successfully cancelled."),
                                                          );
                                                          ScaffoldMessenger.of(
                                                                  context)
                                                              .showSnackBar(
                                                                  snackBar);
                                                          Get.back();
                                                          controller
                                                              .getOrderList(
                                                            isRefresh: true,
                                                            isInitial: true,
                                                            controller
                                                                .ordersList,
                                                            controller
                                                                .orderHistoryIndex,
                                                            index: 0,
                                                            controller
                                                                .progressStatusOrderProfile,
                                                          );
                                                        }
                                                      }
                                                    }
                                                  },
                                                  child: Container(
                                                    color: Color.fromRGBO(
                                                      250,
                                                      245,
                                                      252,
                                                      1,
                                                    ),
                                                    child: Center(
                                                      child: Text(
                                                          'Cancel My Order',
                                                          style: kThemeData
                                                              .textTheme
                                                              .labelMedium
                                                              ?.copyWith(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                  color: DarkTheme
                                                                      .lightActive)),
                                                    ),
                                                  ),
                                                )
                                              : Container(),
                                          Container(
                                            height: Get.height * 0.06,
                                            color: Color.fromRGBO(
                                              250,
                                              245,
                                              252,
                                              1,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    TrackingView(),
                                    // PackageDeliveryTrackingPage(),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ))),
              Obx(() => controller.progressBarStatusOrderDetails.value
                  ? Center(child: CustomProgressBar())
                  : Container())
            ],
          )),
    );
  }
}
