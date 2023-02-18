import 'dart:developer';

import 'package:adora_baby/app/data/models/get_orders_model.dart';
import 'package:adora_baby/app/data/repositories/cart_repository.dart';
import 'package:adora_baby/app/widgets/buttons.dart';
import 'package:adora_baby/app/widgets/custom_progress_bar.dart';
import 'package:adora_baby/app/widgets/shimmer_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_svg/svg.dart';

import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../main.dart';
import '../../../config/app_colors.dart';
import '../../../config/app_theme.dart';
import '../../../config/constants.dart';
import '../../../data/models/get_carts_model.dart' as c;
import '../../../routes/app_pages.dart';
import '../../../widgets/custom_progress_bar.dart';
import '../../../widgets/tab_bar.dart';
import '../../shop/widgets/hot_sales.dart';
import '../controllers/cart_controller.dart';

class CartView extends GetView<CartController> {
  const CartView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: LightTheme.whiteActive,
      appBar: AppBar(
        backgroundColor: LightTheme.white,
        elevation: 0,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
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
                  child: Center(
                    child: Text(
                      'Cart',
                      style: kThemeData.textTheme.displaySmall
                          ?.copyWith(color: DarkTheme.normal),
                    ),
                  ),
                ),
                Obx(
                  () => controller.cartList.isNotEmpty
                      ? Container(
                          decoration: BoxDecoration(
                            color: LightTheme.white,
                          ),
                          margin: const EdgeInsets.symmetric(vertical: 10),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 22, vertical: 34),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${controller.cartList.length} items in your cart",
                                style: kThemeData.textTheme.labelLarge,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 0.0, right: 38, top: 40),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        GetBuilder<CartController>(
                                          id: 'mainCheckbox',
                                          builder: (myController) => Checkbox(
                                              value: myController
                                                  .mainCheckbox.value,
                                              onChanged: (bool? val) async {
                                                for (final cartItem
                                                    in myController.cartList) {
                                                  cartItem.checkBox = val;
                                                }
                                                myController.mainCheckbox
                                                    .value = val ?? false;
                                                await myController
                                                    .calculateGrandTotal(
                                                        myController.cartList);
                                                myController.update(
                                                  [
                                                    'individualCheckbox',
                                                    'mainCheckbox'
                                                  ],
                                                  true,
                                                );
                                              }),
                                        ),
                                        Text(
                                          "Select All",
                                          style: kThemeData.textTheme.bodyLarge,
                                        ),
                                      ],
                                    ),
                                    GestureDetector(
                                        onTap: () {
                                          // controller.requestToDeleteCart(
                                          //     snapshot.data![0].id!);
                                        },
                                        child: const Text(
                                          "Remove Selected",
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontFamily: "Poppins",
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ))
                                  ],
                                ),
                              ),
                              ListView.builder(
                                itemCount: controller.cartList.length,
                                physics: NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                padding: EdgeInsets.only(top: 20),
                                itemBuilder:
                                    (BuildContext context, int index) => Card(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20.0),
                                      side: BorderSide(
                                        color: Colors.grey.withOpacity(0.2),
                                      )),
                                  margin: EdgeInsets.only(
                                    bottom: 30,
                                  ),
                                  elevation: 2.5,
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        left: 5, right: 5, top: 40, bottom: 40),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Flexible(
                                          fit: FlexFit.loose,
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                top: 70.0),
                                            child: GetBuilder<CartController>(
                                              id: 'individualCheckbox',
                                              builder: (myController) =>
                                                  Checkbox(
                                                value: myController
                                                    .cartList[index].checkBox,
                                                onChanged: (bool? val) async {
                                                  myController.cartList[index]
                                                      .checkBox = val!;
                                                  await myController
                                                      .calculateGrandTotal(
                                                      myController.cartList);

                                                  myController.update(
                                                    ['individualCheckbox'],
                                                    true,
                                                  );
                                                },
                                              ),
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                            height: 180,
                                            child: Image.network(controller
                                                .cartList[index]
                                                .product!
                                                .productImages![0]!
                                                .name!)),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            SizedBox(
                                              width: 150,
                                              child: Text(
                                                controller.cartList[index]
                                                    .product!.shortName!,
                                                style: const TextStyle(
                                                    fontFamily: "Poppins",
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.w600,
                                                    color: Color.fromRGBO(
                                                        151, 121, 142, 1)),
                                              ),
                                            ),
                                            SizedBox(
                                              width: 200,
                                              child: Text(
                                                controller.cartList[index]
                                                    .product!.name!,
                                                style: const TextStyle(
                                                    fontFamily: "Poppins",
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.w700,
                                                    color: AppColors.mainColor),
                                              ),
                                            ),
                                            controller.cartList[index].product!
                                                    .stockAvailable!
                                                ? const Text("In-Stock",
                                                    style: TextStyle(
                                                      fontFamily: "Poppins",
                                                      fontSize: 16,
                                                      fontStyle:
                                                          FontStyle.italic,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      color: Colors.green,
                                                    ))
                                                : const Text(
                                                    "Out of stock",
                                                    style: TextStyle(
                                                        fontStyle:
                                                            FontStyle.italic,
                                                        fontFamily: "Poppins",
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        color: Colors.red),
                                                  ),
                                            const SizedBox(
                                              height: 20,
                                            ),
                                            GetBuilder<CartController>(
                                              id: 'add_remove_cart',
                                              builder: (getController) => Row(
                                                mainAxisSize: MainAxisSize.min,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  GestureDetector(
                                                    onTap: () async{
                                                      var quantity =
                                                          getController
                                                              .cartList[index]
                                                              .quantity;
                                                      if (quantity != 1 &&
                                                          quantity >= 0) {
                                                        getController
                                                            .cartList[index]
                                                            .quantity -= 1;
                                                        // getController.priceCart
                                                        //     .value -= getController
                                                        //         .cartList[index]
                                                        //         .product
                                                        //         .salePrice ??
                                                        //     getController
                                                        //         .cartList[index]
                                                        //         .product
                                                        //         .regularPrice ??
                                                        //     0.0;
                                                        getController
                                                            .cartList[index]
                                                            .product
                                                            .priceItem = getController
                                                                .cartList[index]
                                                                .quantity *
                                                            (getController
                                                                    .cartList[
                                                                        index]
                                                                    .product
                                                                    .salePrice ??
                                                                getController
                                                                    .cartList[
                                                                        index]
                                                                    .product
                                                                    .regularPrice);
                                                        await getController
                                                            .calculateGrandTotal(
                                                            getController.cartList);
                                                        // if(){}
                                                        getController.cartMap[
                                                            getController
                                                                .cartList[index]
                                                                .id] = {
                                                          'id': getController
                                                              .cartList[index]
                                                              .id,
                                                          'quantity':
                                                              getController
                                                                  .cartList[
                                                                      index]
                                                                  .quantity
                                                        };
                                                        log('Cart Map ${getController.cartMap}');
                                                        getController.update(
                                                            ['add_remove_cart'],
                                                            true);
                                                      }
                                                    },
                                                    child: Container(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              2),
                                                      decoration: BoxDecoration(
                                                          shape:
                                                              BoxShape.circle,
                                                          border: Border.all(
                                                              color: DarkTheme
                                                                  .normal)),
                                                      child: const Icon(
                                                        Icons.remove,
                                                        color: DarkTheme.normal,
                                                      ),
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    width: 14,
                                                  ),
                                                  Flexible(
                                                    fit: FlexFit.loose,
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              top: 3.0),
                                                      child: Container(
                                                          padding:
                                                              const EdgeInsets
                                                                      .only(
                                                                  left: 15,
                                                                  right: 15,
                                                                  top: 5,
                                                                  bottom: 5),
                                                          decoration: BoxDecoration(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          10),
                                                              border: Border.all(
                                                                  color: DarkTheme
                                                                      .normal)),
                                                          child: Center(
                                                            child: Obx(
                                                              () => Text(
                                                                getController
                                                                    .cartList[
                                                                        index]
                                                                    .quantity
                                                                    .toString(),
                                                                style: const TextStyle(
                                                                    color:
                                                                        DarkTheme
                                                                            .dark,
                                                                    fontFamily:
                                                                        'Poppins',
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w900,
                                                                    fontSize:
                                                                        10),
                                                              ),
                                                            ),
                                                          )),
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    width: 14,
                                                  ),
                                                  GestureDetector(
                                                    onTap: () async{
                                                      getController
                                                          .cartList[index]
                                                          .quantity += 1;
                                                      getController
                                                          .cartList[index]
                                                          .product
                                                          .priceItem = getController
                                                              .cartList[index]
                                                              .quantity *
                                                          (getController
                                                                  .cartList[
                                                                      index]
                                                                  .product
                                                                  .salePrice ??
                                                              getController
                                                                  .cartList[
                                                                      index]
                                                                  .product
                                                                  .regularPrice);
                                                      await getController
                                                          .calculateGrandTotal(
                                                          getController.cartList);
                                                      getController.cartMap[
                                                          getController
                                                              .cartList[index]
                                                              .id] = {
                                                        'id': getController
                                                            .cartList[index].id,
                                                        'quantity':
                                                            getController
                                                                .cartList[index]
                                                                .quantity
                                                      };
                                                      log('Cart Map ${getController.cartMap}');
                                                      getController.update(
                                                          ['add_remove_cart'],
                                                          true);
                                                    },
                                                    child: Container(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              2),
                                                      decoration: BoxDecoration(
                                                          shape:
                                                              BoxShape.circle,
                                                          border: Border.all(
                                                              color: DarkTheme
                                                                  .normal)),
                                                      child: const Icon(
                                                        Icons.add,
                                                        color: DarkTheme.normal,
                                                      ),
                                                    ),
                                                  ),
                                                  Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment.end,
                                                    children: [
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(top: 2.0),
                                                        child: SvgPicture.asset(
                                                          "assets/images/like.svg",
                                                          height: 25,
                                                        ),
                                                      ),
                                                      const SizedBox(
                                                        height: 15,
                                                      ),
                                                      Obx(() => Text(
                                                            "Rs. ${controller.cartList[index].product.priceItem}",
                                                            style: const TextStyle(
                                                                color: DarkTheme
                                                                    .dark,
                                                                fontFamily:
                                                                    'Poppins',
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w700,
                                                                fontSize: 16),
                                                          ))
                                                    ],
                                                  )
                                                ],
                                              ),
                                            )
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                color: LightTheme.whiteActive,
                                child: const Text(
                                  "abc",
                                  style:
                                      TextStyle(color: LightTheme.whiteActive),
                                ),
                              ),
                              Container(
                                  color: Colors.white,
                                  child: Padding(
                                      padding:
                                          const EdgeInsets.only(left: 70.0),
                                      child: Column(
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Expanded(
                                                child: Text(
                                                  "Subtotal:",
                                                  style: kThemeData
                                                      .textTheme.bodyLarge,
                                                ),
                                              ),
                                              Obx(() => Expanded(
                                                      child: Text(
                                                    "Rs. ${controller.priceCart.value}",
                                                    style: kThemeData
                                                        .textTheme.displaySmall,
                                                  ))),
                                            ],
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Expanded(
                                                child: Text(
                                                  "Diamond off:",
                                                  style: kThemeData
                                                      .textTheme.bodyLarge,
                                                ),
                                              ),
                                              Expanded(
                                                  child: Text(
                                                "0",
                                                style: kThemeData
                                                    .textTheme.displaySmall,
                                              )),
                                            ],
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Expanded(
                                                child: Text(
                                                  "Discount:",
                                                  style: kThemeData
                                                      .textTheme.bodyLarge,
                                                ),
                                              ),
                                              Expanded(
                                                  child: Text(
                                                "Rs. 100",
                                                style: kThemeData
                                                    .textTheme.displaySmall,
                                              )),
                                            ],
                                          ),
                                        ],
                                      ))),
                              const SizedBox(
                                height: 30,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 30.0, right: 30),
                                child: ButtonsWidget(
                                    name: "Proceed",
                                    onPressed: () {
                                      print("hi");
                                    }),
                              ),
                              const SizedBox(
                                height: 100,
                              ),
                            ],
                          ),
                        )
                      : Shimmer.fromColors(
                          baseColor: Colors.white,
                          highlightColor: LightTheme.lightActive,
                          enabled: true,
                          child: _buildImage(),
                        ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildImage() {
    return GridView.count(
      childAspectRatio: 1.5,
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      crossAxisCount: 1,
      padding: EdgeInsets.symmetric(
        vertical: 10,
      ),
      children: List.generate(
        4,
        (index) => Container(
          padding: const EdgeInsets.only(top: 10),
          margin:
              const EdgeInsets.only(left: 18, right: 18, top: 0, bottom: 20),
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
}
