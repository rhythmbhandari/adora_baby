import 'dart:developer';

import 'package:adora_baby/app/modules/profile/controllers/profile_controller.dart';
import 'package:adora_baby/app/widgets/custom_progress_bar.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../config/app_colors.dart';
import '../../../config/app_theme.dart';
import '../../../enums/progress_status.dart';
import '../../../routes/app_pages.dart';
import '../../../utils/date_time_converter.dart';
import '../../../widgets/buttons.dart';
import '../../../widgets/gradient_icon.dart';

class OrderHistoryDetail extends GetView<ProfileController> {
  OrderHistoryDetail({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return true;
      },
      child: Stack(
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
                            style: kThemeData.textTheme.displaySmall?.copyWith(
                              color: DarkTheme.dark,
                            ),
                          ),
                        ),
                        Expanded(
                          child: NestedScrollView(
                            headerSliverBuilder: (context, innerBoxIsScrolled) => [
                              // The flexible app bar with the tabs
                              SliverAppBar(
                                backgroundColor: Colors.white,
                                flexibleSpace: TabBar(
                                    labelStyle:
                                        kThemeData.textTheme.labelMedium?.copyWith(
                                      color: DarkTheme.dark,
                                      fontSize: 18,
                                    ),
                                    isScrollable: false,
                                    unselectedLabelColor: DarkTheme.lighter,
                                    unselectedLabelStyle:
                                        kThemeData.textTheme.labelMedium?.copyWith(
                                      color: DarkTheme.lighter,
                                      fontSize: 18,
                                    ),
                                    labelColor: DarkTheme.dark,
                                    indicatorColor: DarkTheme.dark,
                                    indicatorSize: TabBarIndicatorSize.label,
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
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      for (int i = 0;
                                          i <
                                              controller.selectedOrders.value
                                                  .checkOut!.cart!.length;
                                          i++)
                                        Container(
                                          padding: EdgeInsets.symmetric(
                                            horizontal: 23,
                                            vertical: 24,
                                          ),
                                          margin: EdgeInsets.symmetric(
                                              horizontal: 23, vertical: 16),
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(20),
                                            border: Border.all(
                                                color:
                                                    Colors.black.withOpacity(0.05)),
                                            color: Colors.white,
                                            boxShadow: [
                                              const BoxShadow(
                                                color:
                                                    Color.fromRGBO(0, 0, 0, 0.25),
                                                blurRadius: 0.5,
                                                spreadRadius: 0.5,
                                                offset: Offset(
                                                    -0, 0.5), // Shadow position
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
                                                placeholder: (context, url) =>
                                                    const Center(
                                                        child:
                                                            CircularProgressIndicator()),
                                                errorWidget:
                                                    (context, url, error) =>
                                                        const Icon(Icons.error),
                                              ),
                                              Expanded(
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      '${controller.selectedOrders.value.checkOut?.cart?[i]?.product?.shortName}',
                                                      maxLines: 1,
                                                      style: kThemeData
                                                          .textTheme.bodyMedium
                                                          ?.copyWith(
                                                        color:
                                                            AppColors.secondary700,
                                                      ),
                                                    ),
                                                    Text(
                                                      '${controller.selectedOrders.value.checkOut?.cart?[i]?.product?.name}',
                                                      maxLines: 4,
                                                      style: kThemeData
                                                          .textTheme.titleMedium
                                                          ?.copyWith(
                                                        color: AppColors.primary700,
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height: 20,
                                                    ),
                                                    Container(
                                                      padding: const EdgeInsets
                                                              .symmetric(
                                                          horizontal: 15,
                                                          vertical: 3),
                                                      decoration: BoxDecoration(
                                                          shape: BoxShape.rectangle,
                                                          borderRadius:
                                                              BorderRadius.circular(
                                                                  10),
                                                          border: Border.all(
                                                              color: DarkTheme
                                                                  .normal)),
                                                      child: Text(
                                                        '${controller.selectedOrders.value.checkOut?.cart?[i]?.quantity}',
                                                        maxLines: 1,
                                                        style: kThemeData
                                                            .textTheme.titleMedium
                                                            ?.copyWith(
                                                          color:
                                                              AppColors.primary700,
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
                                        padding:
                                            EdgeInsets.symmetric(horizontal: 32),
                                        child: Text(
                                          'Payment Method',
                                          maxLines: 1,
                                          style: kThemeData.textTheme.titleMedium
                                              ?.copyWith(
                                            color: DarkTheme.dark,
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
                                            borderRadius: BorderRadius.circular(5),
                                            border: Border.all(
                                                color:
                                                    Colors.black.withOpacity(0.05)),
                                            color: Colors.white,
                                            boxShadow: [
                                              const BoxShadow(
                                                color:
                                                    Color.fromRGBO(0, 0, 0, 0.06),
                                                blurRadius: 0.2,
                                                spreadRadius: 0.5,
                                                offset:
                                                    Offset(0, 2), // Shadow position
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
                                                      MainAxisAlignment.start,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      'Cash on Delivery',
                                                      style: kThemeData
                                                          .textTheme.titleMedium
                                                          ?.copyWith(
                                                              color:
                                                                  DarkTheme.dark),
                                                    ),
                                                    Text(
                                                      'Pay Cash upon delivery',
                                                      style: kThemeData
                                                          .textTheme.bodyMedium
                                                          ?.copyWith(
                                                              color:
                                                                  DarkTheme.dark),
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
                                            borderRadius: BorderRadius.circular(5),
                                            border: Border.all(
                                                color:
                                                    Colors.black.withOpacity(0.05)),
                                            color: Colors.white,
                                            boxShadow: [
                                              const BoxShadow(
                                                color:
                                                    Color.fromRGBO(0, 0, 0, 0.06),
                                                blurRadius: 0.2,
                                                spreadRadius: 0.5,
                                                offset:
                                                    Offset(0, 2), // Shadow position
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
                                                      MainAxisAlignment.start,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      '${controller.selectedOrders.value.checkOut?.dimondOff} Diamonds used',
                                                      style: kThemeData
                                                          .textTheme.titleMedium
                                                          ?.copyWith(
                                                              color:
                                                                  DarkTheme.dark),
                                                    ),
                                                    Text(
                                                      'Rs. ${controller.selectedOrders.value.checkOut?.discount} off',
                                                      style: kThemeData
                                                          .textTheme.bodyMedium
                                                          ?.copyWith(
                                                              color:
                                                                  DarkTheme.dark),
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
                                        padding:
                                            EdgeInsets.symmetric(horizontal: 32),
                                        child: Text(
                                          'Applied Coupon',
                                          maxLines: 1,
                                          style: kThemeData.textTheme.titleMedium
                                              ?.copyWith(
                                            color: DarkTheme.dark,
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
                                              '${controller.selectedOrders.value.checkOut?.couponCode ?? 'N/A'}',
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  fontFamily: 'Poppins',
                                                  fontWeight: FontWeight.w400),
                                            ),
                                            floatingLabelBehavior:
                                                FloatingLabelBehavior.never,
                                            hintStyle:
                                                kThemeData.textTheme.bodyLarge,
                                            contentPadding:
                                                const EdgeInsets.symmetric(
                                                    horizontal: 30, vertical: 8),
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
                                                    color: AppColors.secondary500),
                                                borderRadius: BorderRadius.circular(
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
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              'Sub Total',
                                              style: kThemeData.textTheme.bodyLarge
                                                  ?.copyWith(color: DarkTheme.dark),
                                            ),
                                            Text(
                                              '${controller.selectedOrders.value.checkOut?.subTotal}',
                                              style: kThemeData
                                                  .textTheme.titleMedium
                                                  ?.copyWith(color: DarkTheme.dark),
                                            )
                                          ],
                                        ),
                                      ),
                                      Container(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 56, vertical: 5),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              'Diamond Off',
                                              style: kThemeData.textTheme.bodyLarge
                                                  ?.copyWith(color: DarkTheme.dark),
                                            ),
                                            Text(
                                              '${controller.selectedOrders.value.checkOut?.dimondOff}',
                                              style: kThemeData
                                                  .textTheme.titleMedium
                                                  ?.copyWith(color: DarkTheme.dark),
                                            )
                                          ],
                                        ),
                                      ),
                                      Container(
                                        padding: EdgeInsets.only(
                                            left: 56, right: 56, bottom: 5),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              'Discount',
                                              style: kThemeData.textTheme.bodyLarge
                                                  ?.copyWith(color: DarkTheme.dark),
                                            ),
                                            Text(
                                              '${controller.selectedOrders.value.checkOut?.discount}',
                                              style: kThemeData
                                                  .textTheme.titleMedium
                                                  ?.copyWith(color: DarkTheme.dark),
                                            )
                                          ],
                                        ),
                                      ),
                                      Container(
                                        padding: EdgeInsets.only(
                                            left: 56, right: 56, bottom: 5),
                                        child: Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              'Delivery Charge',
                                              style: kThemeData.textTheme.bodyLarge
                                                  ?.copyWith(color: DarkTheme.dark),
                                            ),
                                            Text(
                                              '${controller.selectedOrders.value.checkOut?.deliveryCharge}',
                                              style: kThemeData
                                                  .textTheme.titleMedium
                                                  ?.copyWith(color: DarkTheme.dark),
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
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              'Grand Total',
                                              style: kThemeData.textTheme.bodyLarge
                                                  ?.copyWith(color: DarkTheme.dark),
                                            ),
                                            Text(
                                              '${controller.selectedOrders.value.checkOut?.grandTotal}',
                                              style: kThemeData
                                                  .textTheme.titleMedium
                                                  ?.copyWith(color: DarkTheme.dark),
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
                                      Container(
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
                                          onTap: () {},
                                          child: Container(
                                            padding: const EdgeInsets.only(
                                              top: 20,
                                              bottom: 20,
                                              left: 40,
                                              right: 40,
                                            ),
                                            decoration: BoxDecoration(
                                              color: AppColors.primary500,
                                              borderRadius:
                                                  BorderRadius.circular(30),
                                            ),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceBetween,
                                              children: [
                                                Text('Need Help with this Order?',
                                                    style: kThemeData
                                                        .textTheme.labelMedium
                                                        ?.copyWith(
                                                      fontWeight: FontWeight.w600,
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
                                      ),
                                      Container(
                                        height: Get.height * 0.03,
                                        color: Color.fromRGBO(
                                          250,
                                          245,
                                          252,
                                          1,
                                        ),
                                      ),
                                      GestureDetector(
                                        onTap: (){

                                        },
                                        child: Container(
                                          color: Color.fromRGBO(
                                            250,
                                            245,
                                            252,
                                            1,
                                          ),
                                          child: Center(
                                            child: Text('Cancel My Order',
                                                style: kThemeData
                                                    .textTheme.labelMedium
                                                    ?.copyWith(
                                                        fontWeight: FontWeight.w600,
                                                        color:
                                                            DarkTheme.lightActive)),
                                          ),
                                        ),
                                      ),
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
                                SingleChildScrollView(
                                  child: Container(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 50,
                                      vertical: 50,
                                    ),
                                    child: Column(
                                      children: [
                                        controller.selectedOrders.value.status
                                                .toString()
                                                .toLowerCase()
                                                .contains('delivered')
                                            ? Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.spaceBetween,
                                                children: [
                                                  Expanded(
                                                    flex: 3,
                                                    child: Text('Delivered on ',
                                                        style: kThemeData
                                                            .textTheme.bodyLarge
                                                            ?.copyWith(
                                                                color: DarkTheme
                                                                    .dark)),
                                                  ),
                                                  Expanded(
                                                    flex: 3,
                                                    child: Text(
                                                        DateTimeConverter
                                                            .tripDateFormatter(
                                                                controller
                                                                    .selectedOrders
                                                                    .value
                                                                    .estimatedTime!),
                                                        style: kThemeData
                                                            .textTheme.labelMedium
                                                            ?.copyWith(
                                                                fontWeight:
                                                                    FontWeight.w600,
                                                                color: DarkTheme
                                                                    .dark)),
                                                  ),
                                                  Expanded(child: SizedBox())
                                                ],
                                              )
                                            : controller.selectedOrders.value.status
                                                    .toString()
                                                    .toLowerCase()
                                                    .contains('canceled')
                                                ? Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Expanded(
                                                        flex: 3,
                                                        child: Text('Canceled on ',
                                                            style: kThemeData
                                                                .textTheme.bodyLarge
                                                                ?.copyWith(
                                                                    color: DarkTheme
                                                                        .dark)),
                                                      ),
                                                      Expanded(
                                                        flex: 3,
                                                        child: Text(
                                                            DateTimeConverter
                                                                .tripDateFormatter(
                                                                    controller
                                                                        .selectedOrders
                                                                        .value
                                                                        .updatedAt!),
                                                            style: kThemeData
                                                                .textTheme
                                                                .labelMedium
                                                                ?.copyWith(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w600,
                                                                    color: DarkTheme
                                                                        .dark)),
                                                      ),
                                                      Expanded(child: SizedBox())
                                                    ],
                                                  )
                                                : Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Expanded(
                                                        flex: 3,
                                                        child: Text(
                                                            'Estimated Time',
                                                            style: kThemeData
                                                                .textTheme.bodyLarge
                                                                ?.copyWith(
                                                                    color: DarkTheme
                                                                        .dark)),
                                                      ),
                                                      Expanded(
                                                        flex: 3,
                                                        child: Text(
                                                            controller
                                                                        .selectedOrders
                                                                        .value
                                                                        .estimatedTime ==
                                                                    null
                                                                ? 'N/A'
                                                                : DateTimeConverter
                                                                    .tripDateFormatter(
                                                                        controller
                                                                            .selectedOrders
                                                                            .value
                                                                            .estimatedTime!),
                                                            style: kThemeData
                                                                .textTheme
                                                                .labelMedium
                                                                ?.copyWith(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w600,
                                                                    color: DarkTheme
                                                                        .dark)),
                                                      ),
                                                      Expanded(child: SizedBox())
                                                    ],
                                                  ),
                                        Container(
                                          height: 45,
                                        ),
                                        controller.selectedOrders.value.status
                                                .toString()
                                                .toLowerCase()
                                                .contains('order')
                                            ? Row(
                                                children: [
                                                  Container(
                                                    height: 30,
                                                    width: 30,
                                                    decoration: BoxDecoration(
                                                        color: AppColors.success500,
                                                        shape: BoxShape.circle,
                                                        border: Border.all(
                                                            color: AppColors
                                                                .success500,
                                                            width: 1.5)),
                                                    child: Center(
                                                        child: Icon(
                                                      Icons.check_outlined,
                                                      color: Colors.white,
                                                      size: 20,
                                                    )),
                                                  ),
                                                  SizedBox(
                                                    width: 50,
                                                  ),
                                                  SvgPicture.asset(
                                                      "assets/images/order_placed.svg",
                                                      // height: 22,
                                                      color: DarkTheme.dark),
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
                                                        Text('Order Placed',
                                                            style: kThemeData
                                                                .textTheme
                                                                .labelMedium
                                                                ?.copyWith(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w600,
                                                                    color: DarkTheme
                                                                        .dark)),
                                                        Text(
                                                            'We have received your order.',
                                                            style: kThemeData
                                                                .textTheme
                                                                .bodyMedium
                                                                ?.copyWith(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w400,
                                                                    color: DarkTheme
                                                                        .dark)),
                                                      ],
                                                    ),
                                                  )
                                                ],
                                              )
                                            : controller.selectedOrders.value.status
                                                    .toString()
                                                    .toLowerCase()
                                                    .contains('package')
                                                ? Row(
                                          children: [
                                            Container(
                                              height: 30,
                                              width: 30,
                                              decoration: BoxDecoration(
                                                  color: AppColors.success500,
                                                  shape: BoxShape.circle,
                                                  border: Border.all(
                                                      color: AppColors
                                                          .success500,
                                                      width: 1.5)),
                                              child: Center(
                                                  child: Icon(
                                                    Icons.check_outlined,
                                                    color: Colors.white,
                                                    size: 20,
                                                  )),
                                            ),
                                            SizedBox(
                                              width: 50,
                                            ),
                                            SvgPicture.asset(
                                                "assets/images/package_created.svg",
                                                // height: 22,
                                                color: DarkTheme.dark),
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
                                                  Text('Package Created',
                                                      style: kThemeData
                                                          .textTheme
                                                          .labelMedium
                                                          ?.copyWith(
                                                          fontWeight:
                                                          FontWeight
                                                              .w600,
                                                          color: DarkTheme
                                                              .dark)),
                                                  Text(
                                                      'We have packed your order.',
                                                      style: kThemeData
                                                          .textTheme
                                                          .bodyMedium
                                                          ?.copyWith(
                                                          fontWeight:
                                                          FontWeight
                                                              .w400,
                                                          color: DarkTheme
                                                              .dark)),
                                                ],
                                              ),
                                            )
                                          ],
                                        )
                                                : controller
                                                        .selectedOrders.value.status
                                                        .toString()
                                                        .toLowerCase()
                                                        .contains('shipped')
                                                    ? Row(
                                          children: [
                                            Container(
                                              height: 30,
                                              width: 30,
                                              decoration: BoxDecoration(
                                                  color: AppColors.success500,
                                                  shape: BoxShape.circle,
                                                  border: Border.all(
                                                      color: AppColors
                                                          .success500,
                                                      width: 1.5)),
                                              child: Center(
                                                  child: Icon(
                                                    Icons.check_outlined,
                                                    color: Colors.white,
                                                    size: 20,
                                                  )),
                                            ),
                                            SizedBox(
                                              width: 50,
                                            ),
                                            SvgPicture.asset(
                                                "assets/images/shipped.svg",
                                                // height: 22,
                                                color: DarkTheme.dark),
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
                                                  Text('Shipped',
                                                      style: kThemeData
                                                          .textTheme
                                                          .labelMedium
                                                          ?.copyWith(
                                                          fontWeight:
                                                          FontWeight
                                                              .w600,
                                                          color: DarkTheme
                                                              .dark)),
                                                  Text(
                                                      'We are shipping your order.',
                                                      style: kThemeData
                                                          .textTheme
                                                          .bodyMedium
                                                          ?.copyWith(
                                                          fontWeight:
                                                          FontWeight
                                                              .w400,
                                                          color: DarkTheme
                                                              .dark)),
                                                ],
                                              ),
                                            )
                                          ],
                                        )
                                                    : controller.selectedOrders
                                                            .value.status
                                                            .toString()
                                                            .toLowerCase()
                                                            .contains('delivered')
                                                        ? Row(
                                          children: [
                                            Container(
                                              height: 30,
                                              width: 30,
                                              decoration: BoxDecoration(
                                                  color: AppColors.success500,
                                                  shape: BoxShape.circle,
                                                  border: Border.all(
                                                      color: AppColors
                                                          .success500,
                                                      width: 1.5)),
                                              child: Center(
                                                  child: Icon(
                                                    Icons.check_outlined,
                                                    color: Colors.white,
                                                    size: 20,
                                                  )),
                                            ),
                                            SizedBox(
                                              width: 50,
                                            ),
                                            SvgPicture.asset(
                                                "assets/images/location-tick.svg",
                                                // height: 22,
                                                color: DarkTheme.dark),
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
                                                  Text('Order Delivered',
                                                      style: kThemeData
                                                          .textTheme
                                                          .labelMedium
                                                          ?.copyWith(
                                                          fontWeight:
                                                          FontWeight
                                                              .w600,
                                                          color: DarkTheme
                                                              .dark)),
                                                  Text(
                                                      'Your order is delivered',
                                                      style: kThemeData
                                                          .textTheme
                                                          .bodyMedium
                                                          ?.copyWith(
                                                          fontWeight:
                                                          FontWeight
                                                              .w400,
                                                          color: DarkTheme
                                                              .dark)),
                                                ],
                                              ),
                                            )
                                          ],
                                        )
                                                        : Row(
                                                            children: [
                                                              Container(
                                                                height: 30,
                                                                width: 30,
                                                                decoration: BoxDecoration(
                                                                    color: Colors
                                                                        .white,
                                                                    shape: BoxShape
                                                                        .circle,
                                                                    border: Border.all(
                                                                        color: AppColors
                                                                            .error500,
                                                                        width:
                                                                            1.5)),
                                                              ),
                                                              SizedBox(
                                                                width: 50,
                                                              ),
                                                              SvgPicture.asset(
                                                                  "assets/images/canceled.svg",
                                                                  // height: 22,
                                                                  color: AppColors
                                                                      .error500),
                                                              SizedBox(
                                                                width: 8,
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
                                                                    Text('Canceled',
                                                                        style: kThemeData
                                                                            .textTheme
                                                                            .labelMedium
                                                                            ?.copyWith(
                                                                                fontWeight:
                                                                                    FontWeight.w600,
                                                                                color: AppColors.error500)),
                                                                    Text(
                                                                        'Your order was canceled as the deilvery was late',
                                                                        style: kThemeData
                                                                            .textTheme
                                                                            .bodyMedium
                                                                            ?.copyWith(
                                                                                fontWeight:
                                                                                    FontWeight.w400,
                                                                                color: AppColors.error500)),
                                                                  ],
                                                                ),
                                                              )
                                                            ],
                                                          )
                                        // Stack(
                                        //   children: [
                                        //     Positioned(
                                        //       top: 15,
                                        //       left: 12,
                                        //       child: Container(
                                        //         height: 43 * 3,
                                        //         width: 4,
                                        //         color: AppColors.success500,
                                        //       ),
                                        //     ),
                                        //     Container(
                                        //       margin: EdgeInsets.only(bottom: 43),
                                        //       child: Row(
                                        //         children: [
                                        //           Container(
                                        //             height: 30,
                                        //             width: 30,
                                        //             decoration: BoxDecoration(
                                        //                 color: AppColors.success500,
                                        //                 shape: BoxShape.circle,
                                        //                 border: Border.all(
                                        //                     color: AppColors
                                        //                         .success500,
                                        //                     width: 1.5)),
                                        //             child: Center(
                                        //                 child: Icon(
                                        //               Icons.check_outlined,
                                        //               color: Colors.white,
                                        //               size: 20,
                                        //             )),
                                        //           ),
                                        //           SizedBox(
                                        //             width: 50,
                                        //           ),
                                        //           SvgPicture.asset(
                                        //               "assets/images/order_placed.svg",
                                        //               // height: 22,
                                        //               color: DarkTheme.dark),
                                        //           SizedBox(
                                        //             width: 8,
                                        //           ),
                                        //           Expanded(
                                        //             child: Column(
                                        //               mainAxisAlignment:
                                        //                   MainAxisAlignment.start,
                                        //               crossAxisAlignment:
                                        //                   CrossAxisAlignment.start,
                                        //               children: [
                                        //                 Text('Order Placed',
                                        //                     style: kThemeData
                                        //                         .textTheme
                                        //                         .labelMedium
                                        //                         ?.copyWith(
                                        //                             fontWeight:
                                        //                                 FontWeight
                                        //                                     .w600,
                                        //                             color: DarkTheme
                                        //                                 .dark)),
                                        //                 Text(
                                        //                     'We have received your order.',
                                        //                     style: kThemeData
                                        //                         .textTheme
                                        //                         .bodyMedium
                                        //                         ?.copyWith(
                                        //                             fontWeight:
                                        //                                 FontWeight
                                        //                                     .w400,
                                        //                             color: DarkTheme
                                        //                                 .dark)),
                                        //               ],
                                        //             ),
                                        //           )
                                        //         ],
                                        //       ),
                                        //     ),
                                        //   ],
                                        // ),
                                        // Stack(
                                        //   children: [
                                        //     Positioned(
                                        //       top: 0,
                                        //       left: 12,
                                        //       child: Container(
                                        //         height: 43 * 3,
                                        //         width: 4,
                                        //         color: AppColors.success500,
                                        //       ),
                                        //     ),
                                        //     Container(
                                        //       margin: EdgeInsets.only(bottom: 43),
                                        //       child: Row(
                                        //         children: [
                                        //           Container(
                                        //             height: 30,
                                        //             width: 30,
                                        //             decoration: BoxDecoration(
                                        //                 color: AppColors.success500,
                                        //                 shape: BoxShape.circle,
                                        //                 border: Border.all(
                                        //                     color: AppColors
                                        //                         .success500,
                                        //                     width: 1.5)),
                                        //             child: Center(
                                        //                 child: Icon(
                                        //               Icons.check_outlined,
                                        //               color: Colors.white,
                                        //               size: 20,
                                        //             )),
                                        //           ),
                                        //           SizedBox(
                                        //             width: 50,
                                        //           ),
                                        //           SvgPicture.asset(
                                        //               "assets/images/package_created.svg",
                                        //               // height: 22,
                                        //               color: DarkTheme.dark),
                                        //           SizedBox(
                                        //             width: 8,
                                        //           ),
                                        //           Expanded(
                                        //             child: Column(
                                        //               mainAxisAlignment:
                                        //                   MainAxisAlignment.start,
                                        //               crossAxisAlignment:
                                        //                   CrossAxisAlignment.start,
                                        //               children: [
                                        //                 Text('Package Created',
                                        //                     style: kThemeData
                                        //                         .textTheme
                                        //                         .labelMedium
                                        //                         ?.copyWith(
                                        //                             fontWeight:
                                        //                                 FontWeight
                                        //                                     .w600,
                                        //                             color: DarkTheme
                                        //                                 .dark)),
                                        //                 Text(
                                        //                     'We have packed your order.',
                                        //                     style: kThemeData
                                        //                         .textTheme
                                        //                         .bodyMedium
                                        //                         ?.copyWith(
                                        //                             fontWeight:
                                        //                                 FontWeight
                                        //                                     .w400,
                                        //                             color: DarkTheme
                                        //                                 .dark)),
                                        //               ],
                                        //             ),
                                        //           )
                                        //         ],
                                        //       ),
                                        //     ),
                                        //   ],
                                        // ),
                                        // Row(
                                        //   children: [
                                        //     Container(
                                        //       height: 30,
                                        //       width: 30,
                                        //       decoration: BoxDecoration(
                                        //           color: Colors.white,
                                        //           shape: BoxShape.circle,
                                        //           border: Border.all(
                                        //               color: AppColors.error500,
                                        //               width: 1.5)),
                                        //     ),
                                        //     SizedBox(
                                        //       width: 50,
                                        //     ),
                                        //     SvgPicture.asset(
                                        //         "assets/images/canceled.svg",
                                        //         // height: 22,
                                        //         color: AppColors.error500),
                                        //     SizedBox(
                                        //       width: 8,
                                        //     ),
                                        //     Expanded(
                                        //       child: Column(
                                        //         mainAxisAlignment:
                                        //             MainAxisAlignment.start,
                                        //         crossAxisAlignment:
                                        //             CrossAxisAlignment.start,
                                        //         children: [
                                        //           Text('Canceled',
                                        //               style: kThemeData
                                        //                   .textTheme.labelMedium
                                        //                   ?.copyWith(
                                        //                       fontWeight:
                                        //                           FontWeight.w600,
                                        //                       color: AppColors
                                        //                           .error500)),
                                        //           Text(
                                        //               'Your order was canceled as the deilvery was late',
                                        //               style: kThemeData
                                        //                   .textTheme.bodyMedium
                                        //                   ?.copyWith(
                                        //                       fontWeight:
                                        //                           FontWeight.w400,
                                        //                       color: AppColors
                                        //                           .error500)),
                                        //         ],
                                        //       ),
                                        //     )
                                        //   ],
                                        // ),
                                        // SizedBox(
                                        //   height: 43,
                                        // ),
                                        // Row(
                                        //   children: [
                                        //     Container(
                                        //       height: 30,
                                        //       width: 30,
                                        //       decoration: BoxDecoration(
                                        //           color: AppColors.success500,
                                        //           shape: BoxShape.circle,
                                        //           border: Border.all(
                                        //               color: AppColors.success500,
                                        //               width: 1.5)),
                                        //       child: Center(
                                        //           child: Icon(
                                        //         Icons.check_outlined,
                                        //         color: Colors.white,
                                        //         size: 20,
                                        //       )),
                                        //     ),
                                        //     SizedBox(
                                        //       width: 50,
                                        //     ),
                                        //     SvgPicture.asset(
                                        //         "assets/images/shipped.svg",
                                        //         // height: 22,
                                        //         color: DarkTheme.dark),
                                        //     SizedBox(
                                        //       width: 8,
                                        //     ),
                                        //     Expanded(
                                        //       child: Column(
                                        //         mainAxisAlignment:
                                        //             MainAxisAlignment.start,
                                        //         crossAxisAlignment:
                                        //             CrossAxisAlignment.start,
                                        //         children: [
                                        //           Text('Shipped',
                                        //               style: kThemeData
                                        //                   .textTheme.labelMedium
                                        //                   ?.copyWith(
                                        //                       fontWeight:
                                        //                           FontWeight.w600,
                                        //                       color:
                                        //                           DarkTheme.dark)),
                                        //           Text(
                                        //               'We are shipping your order.',
                                        //               style: kThemeData
                                        //                   .textTheme.bodyMedium
                                        //                   ?.copyWith(
                                        //                       fontWeight:
                                        //                           FontWeight.w400,
                                        //                       color:
                                        //                           DarkTheme.dark)),
                                        //         ],
                                        //       ),
                                        //     )
                                        //   ],
                                        // ),
                                        // SizedBox(
                                        //   height: 43,
                                        // ),
                                        // Row(
                                        //   children: [
                                        //     Container(
                                        //       height: 30,
                                        //       width: 30,
                                        //       decoration: BoxDecoration(
                                        //           color: AppColors.success500,
                                        //           shape: BoxShape.circle,
                                        //           border: Border.all(
                                        //               color: AppColors.success500,
                                        //               width: 1.5)),
                                        //       child: Center(
                                        //           child: Icon(
                                        //         Icons.check_outlined,
                                        //         color: Colors.white,
                                        //         size: 20,
                                        //       )),
                                        //     ),
                                        //     SizedBox(
                                        //       width: 50,
                                        //     ),
                                        //     SvgPicture.asset(
                                        //         "assets/images/location-tick.svg",
                                        //         // height: 22,
                                        //         color: DarkTheme.dark),
                                        //     SizedBox(
                                        //       width: 8,
                                        //     ),
                                        //     Expanded(
                                        //       child: Column(
                                        //         mainAxisAlignment:
                                        //             MainAxisAlignment.start,
                                        //         crossAxisAlignment:
                                        //             CrossAxisAlignment.start,
                                        //         children: [
                                        //           Text('Order Delivered',
                                        //               style: kThemeData
                                        //                   .textTheme.labelMedium
                                        //                   ?.copyWith(
                                        //                       fontWeight:
                                        //                           FontWeight.w600,
                                        //                       color:
                                        //                           DarkTheme.dark)),
                                        //           Text('Your order is delivered.',
                                        //               style: kThemeData
                                        //                   .textTheme.bodyMedium
                                        //                   ?.copyWith(
                                        //                       fontWeight:
                                        //                           FontWeight.w400,
                                        //                       color:
                                        //                           DarkTheme.dark)),
                                        //         ],
                                        //       ),
                                        //     )
                                        //   ],
                                        // ),
                                      ],
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ))),
          Obx(() => controller.progressBarStatus.value
              ? Center(child: CustomProgressBar())
              : Container())
        ],
      ),
    );
  }
}
