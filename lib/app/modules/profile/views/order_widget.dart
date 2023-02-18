import 'package:adora_baby/app/modules/auth/controllers/auth_controllers.dart';
import 'package:adora_baby/app/data/repositories/shop_respository.dart';
import 'package:adora_baby/app/modules/profile/controllers/profile_controller.dart';
import 'package:adora_baby/app/modules/profile/views/order_history_detail.dart';
import 'package:adora_baby/app/routes/app_pages.dart';
import 'package:adora_baby/app/modules/shop/widgets/hot_sales.dart';
import 'package:adora_baby/app/utils/date_time_converter.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

import '../../../config/app_colors.dart';
import '../../../config/app_theme.dart';
import '../../../data/models/hot_sales_model.dart';
import '../../../data/models/orders_model.dart';
import '../../../widgets/gradient_icon.dart';
import 'order_history.dart';

class OrderWidget extends StatelessWidget {
  final ProfileController controller;

  const OrderWidget({required this.controller, super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          const EdgeInsets.only(left: 18.0, right: 18, top: 10, bottom: 15),
      child: Container(
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(20)),
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            GestureDetector(
              onTap: () {},
              child: const Center(
                child: Text(
                  "My Orders",
                  style: TextStyle(
                    color: DarkTheme.dark,
                    fontFamily: "PLayfair",
                    fontSize: 24,
                    fontWeight: FontWeight.w600,
                    letterSpacing: -0.01,
                  ),
                ),
              ),
            ),
            Obx(() => controller.ordersList.isNotEmpty
                ? _buildFeaturedCards(controller)
                : Shimmer.fromColors(
                    baseColor: Colors.white,
                    highlightColor: LightTheme.lightActive,
                    enabled: true,
                    child: _buildImage()))
          ],
        ),
      ),
    );
  }
}

Widget _buildImage() {
  return GridView.count(
    childAspectRatio: 1.3,
    physics: NeverScrollableScrollPhysics(),
    shrinkWrap: true,
    crossAxisCount: 1,
    children: List.generate(
      1,
      (index) => Column(
        children: [
          Expanded(
            child: Row(
              children: [
                Expanded(
                  flex: 3,
                  child: Container(
                    padding: const EdgeInsets.only(top: 10),
                    margin: EdgeInsets.all(20),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(
                            color: const Color.fromRGBO(192, 144, 254, 0.25)),
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
                Expanded(
                  flex: 2,
                  child: Container(
                    padding: const EdgeInsets.only(top: 10),
                    margin: EdgeInsets.only(top: 20, bottom: 20, left: 0),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(
                            color: const Color.fromRGBO(192, 144, 254, 0.25)),
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(15),
                            bottomLeft: Radius.circular(15))),
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
              ],
            ),
          ),
          SizedBox(
            height: Get.height * 0.05,
          ),
        ],
      ),
    ),
  );
}

Widget _buildFeaturedCards(ProfileController controller) {
  final cards = <Widget>[];
  Widget FeaturedCard;

  if (controller != null) {
    for (int i = 0; i < controller.ordersList.length; i++) {
      cards.add(GestureDetector(
        onTap: () {
          controller.selectedOrders.value = controller.ordersList[i];

          Get.to(()=> OrderHistoryDetail());
        },
        child: Container(
          padding: const EdgeInsets.only(top: 10),
          margin: EdgeInsets.only(
              right: (controller.ordersList.length - 1 == i) ? 19 : 0,
              bottom: 10,
              left: 19),
          width: controller.ordersList.length == 1
              ? Get.width * 0.9
              : Get.width * 0.7,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: Colors.white,
            border:
                Border.all(color: const Color.fromRGBO(192, 144, 254, 0.25)),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 0.5,
                blurRadius: 1,
                offset: Offset(0, 2), // changes position of shadow
              ),
            ],
            borderRadius: BorderRadius.circular(
              15,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.only(left: 19, top: 10),
                child: Text(
                  '#${controller.ordersList[i].trackingCode}',
                  maxLines: 1,
                  style: kThemeData.textTheme.labelSmall
                      ?.copyWith(color: DarkTheme.dark, fontSize: 12),
                ),
              ),
              controller.ordersList[i].status
                      .toString()
                      .toLowerCase()
                      .contains('order')
                  ? Container(
                      padding: EdgeInsets.only(left: 19, top: 2),
                      child: Text(
                        'Order Placed',
                        maxLines: 1,
                        style: kThemeData.textTheme.bodyMedium?.copyWith(
                          color: AppColors.warning500,
                        ),
                      ),
                    )
                  : controller.ordersList[i].status
                          .toString()
                          .toLowerCase()
                          .contains('package')
                      ? Container(
                          padding: EdgeInsets.only(left: 19, top: 2),
                          child: Text(
                            'Package Created',
                            maxLines: 1,
                            style: kThemeData.textTheme.bodyMedium?.copyWith(
                              color: AppColors.warning500,
                            ),
                          ),
                        )
                      : controller.ordersList[i].status
                              .toString()
                              .toLowerCase()
                              .contains('shipped')
                          ? Container(
                              padding: EdgeInsets.only(left: 19, top: 2),
                              child: Text(
                                'Shipped',
                                maxLines: 1,
                                style:
                                    kThemeData.textTheme.bodyMedium?.copyWith(
                                  color: AppColors.success800,
                                ),
                              ),
                            )
                          : controller.ordersList[i].status
                                  .toString()
                                  .toLowerCase()
                                  .contains('delivered')
                              ? Container(
                                  padding: EdgeInsets.only(left: 19, top: 2),
                                  child: Text(
                                    'Delivered',
                                    maxLines: 1,
                                    style: kThemeData.textTheme.bodyMedium
                                        ?.copyWith(
                                      color: DarkTheme.darkActive,
                                    ),
                                  ),
                                )
                              : controller.ordersList[i].status
                                      .toString()
                                      .toLowerCase()
                                      .contains('canceled')
                                  ? Container(
                                      padding:
                                          EdgeInsets.only(left: 19, top: 2),
                                      child: Text(
                                        'Canceled',
                                        maxLines: 1,
                                        style: kThemeData.textTheme.bodyMedium
                                            ?.copyWith(
                                          color: AppColors.error500,
                                        ),
                                      ),
                                    )
                                  : Container(),
              controller.ordersList[i].status
                          .toString()
                          .toLowerCase()
                          .contains('order') ||
                      controller.ordersList[i].status
                          .toString()
                          .toLowerCase()
                          .contains('package') ||
                      controller.ordersList[i].status
                          .toString()
                          .toLowerCase()
                          .contains('shipped')
                  ? Container(
                      padding: EdgeInsets.only(left: 19, top: 2),
                      child: Text(
                        'Arriving ${DateTimeConverter.notificationDate(
                          controller.ordersList[i].estimatedTime,
                        )}',
                        maxLines: 1,
                        style: kThemeData.textTheme.labelSmall?.copyWith(
                          color: DarkTheme.dark,
                        ),
                      ),
                    )
                  : controller.ordersList[i].status
                          .toString()
                          .toLowerCase()
                          .contains('delivered')
                      ? Container(
                          padding: EdgeInsets.only(left: 19, top: 2),
                          child: Text(
                            'Arrived ${DateTimeConverter.notificationDate(
                              controller.ordersList[i].estimatedTime,
                            )}',
                            maxLines: 1,
                            style: kThemeData.textTheme.labelSmall?.copyWith(
                              color: DarkTheme.dark,
                            ),
                          ),
                        )
                      : Container(),
              Container(
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    for (var i in controller.ordersList[i].checkOut.cart)
                      CachedNetworkImage(
                        fit: BoxFit.contain,
                        height: Get.height * 0.1,
                        imageUrl: '${i.product.productImages[0].name}',
                        placeholder: (context, url) =>
                            const Center(child: CircularProgressIndicator()),
                        errorWidget: (context, url, error) =>
                            const Icon(Icons.error),
                      ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.only(
                    left: 13, right: 13, top: 17, bottom: 17),
                decoration: const BoxDecoration(
                    color: AppColors.primary500,
                    borderRadius: BorderRadius.only(
                        bottomRight: Radius.circular(15),
                        bottomLeft: Radius.circular(15))),
                child: Center(
                  child: Text(
                    'Show Details',
                    maxLines: 1,
                    style: kThemeData.textTheme.labelMedium
                        ?.copyWith(color: Colors.white),
                  ),
                ),
              )
            ],
          ),
        ),
      ));
    }
    FeaturedCard = Container(
      padding: EdgeInsets.only(top: 16, bottom: 16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(children: cards),
          ),
          SizedBox(
            height: 10,
          ),
          GestureDetector(
            onTap: () {
              controller.fetchOrders();
              Get.to(()=> const OrderHistoryView());

            },
            child: Container(
              padding: EdgeInsets.only(top: 10, right: 24, bottom: 8),
              alignment: Alignment.bottomRight,
              child: Text(
                'Show History',
                maxLines: 1,
                style: kThemeData.textTheme.bodyLarge
                    ?.copyWith(color: DarkTheme.dark),
              ),
            ),
          ),
        ],
      ),
    );
  } else {
    FeaturedCard = Container();
  }
  return FeaturedCard;
}

// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:get/get.dart';
//
// import '../../../config/app_colors.dart';
// import '../../../config/app_theme.dart';
// import '../controllers/profile_controller.dart';

// Widget ordersWidget(ProfileController controller, BuildContext context) {
//   return Container(
//       decoration: BoxDecoration(
//           color: LightTheme.white, borderRadius: BorderRadius.circular(20)),
//       margin: EdgeInsets.symmetric(horizontal: 16, vertical: 20),
//       padding: EdgeInsets.symmetric(horizontal: 33, vertical: 34),
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         crossAxisAlignment: CrossAxisAlignment.center,
//         children: [
//           Text(
//             'My Orders',
//             style: kThemeData.textTheme.displaySmall
//                 ?.copyWith(color: DarkTheme.normal),
//           ),
//           SizedBox(
//             height: 30,
//           ),
//           ListView.builder(
//             itemCount: 2,
//             shrinkWrap: true,
//             // padding:
//             // EdgeInsets.only(top: 60, left: 32, bottom: 21),
//             scrollDirection: Axis.horizontal,
//             itemBuilder: (context, index) {
//               return Container(
//                 width: 200,
//                 padding: EdgeInsets.only(right: 8),
//                 decoration: BoxDecoration(
//                     color: AppColors.secondary500,
//                     border: Border.all(color: Colors.transparent)),
//                 child: Center(
//                   child: Text('hshs',
//                       style: kThemeData.textTheme.bodyLarge
//                           ?.copyWith(color: Colors.red)),
//                 ),
//               );
//             },
//           ),
//           SizedBox(
//             height: 12,
//           ),
//         ],
//       ));
// }
