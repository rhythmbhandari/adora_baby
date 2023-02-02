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
import '../../../widgets/checkBox.dart';
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
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.only(top: 60, bottom: 40),
                width: double.infinity,
                color: Colors.white,
                child: Center(
                  child: Text(
                    "Cart",
                    style: kThemeData.textTheme.displaySmall,
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              controller.progressBarStatusDeleteCart.value
                  ? CustomProgressBar()
                  : Container(
                      color: Colors.white,
                      child: FutureBuilder<List<c.Datum>>(
                          future: CartRepository.getCart(),
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              if (snapshot.data != null &&
                                  snapshot.data!.isNotEmpty) {
                                return Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 30.0, top: 20),
                                        child: Text(
                                          "${snapshot.data!.length} items in your cart",
                                          style:
                                              kThemeData.textTheme.labelLarge,
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 20.0, right: 20, top: 40),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            GetBuilder<CartController>(
                                              builder: (controller) {
                                                return Checkbox(
                                                  value: controller.selectAll,
                                                  onChanged: (value) {
                                                    controller.toggleAll();
                                                  },
                                                );
                                              },
                                            ),
                                            GestureDetector(
                                                onTap: () async {
                                                  controller
                                                      .progressBarStatusDeleteCart
                                                      .value = true;

                                                  for (int i = 0;
                                                      i <= 15;
                                                      i++) {
                                                    controller
                                                        .requestToDeleteCart(
                                                            snapshot
                                                                .data![i].id!);
                                                    snapshot.data!.removeAt(i);


                                                    Future.delayed(
                                                        const Duration(
                                                            seconds: 2), () {
                                                      controller
                                                          .progressBarStatusDeleteCart
                                                          .value = false;
                                                    });
                                                  }

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
                                      Obx(
                                        () => GestureDetector(
                                            onTap: () {},
                                            child: controller
                                                        .progressBarStatusDeleteCart
                                                        .value ==false
                                                ? AlignedGridView.count(
                                                    crossAxisCount: 1,
                                                    mainAxisSpacing: 20,
                                                    crossAxisSpacing: 20,
                                                    shrinkWrap: true,
                                                    itemCount:
                                                        snapshot.data!.length,
                                                    physics:
                                                        const NeverScrollableScrollPhysics(),
                                                    itemBuilder:
                                                        (context, int index) {
                                                      return Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .only(
                                                                left: 30.0,
                                                                right: 30,
                                                                top: 10),
                                                        child: Card(
                                                          shape:
                                                              RoundedRectangleBorder(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              20.0),
                                                                  side:
                                                                      BorderSide(
                                                                    color: Colors
                                                                        .grey
                                                                        .withOpacity(
                                                                            0.2),
                                                                  )),
                                                          elevation: 5,
                                                          child: Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                        .only(
                                                                    left: 5,
                                                                    top: 40,
                                                                    bottom: 40),
                                                            child: Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceBetween,
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              children: [
                                                                Padding(
                                                                    padding: const EdgeInsets
                                                                            .only(
                                                                        top:
                                                                            70.0),
                                                                    child: Obx(
                                                                      () =>
                                                                          Checkbox(
                                                                        value: controller
                                                                            .value[index],
                                                                        onChanged:
                                                                            (bool?
                                                                                val) {
                                                                          controller
                                                                              .toggleOne(index);
                                                                        },
                                                                      ),
                                                                    )),
                                                                SizedBox(
                                                                    height: 140,
                                                                    child: Image.network(snapshot
                                                                        .data![
                                                                            index]
                                                                        .product!
                                                                        .productImages![
                                                                            0]!
                                                                        .name!)),
                                                                Column(
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .start,
                                                                  children: [
                                                                    SizedBox(
                                                                      width:
                                                                          150,
                                                                      child:
                                                                          Text(
                                                                        snapshot
                                                                            .data![index]
                                                                            .product!
                                                                            .shortName!,
                                                                        style: const TextStyle(
                                                                            fontFamily:
                                                                                "Poppins",
                                                                            fontSize:
                                                                                16,
                                                                            fontWeight: FontWeight
                                                                                .w600,
                                                                            color: Color.fromRGBO(
                                                                                151,
                                                                                121,
                                                                                142,
                                                                                1)),
                                                                      ),
                                                                    ),
                                                                    SizedBox(
                                                                      width:
                                                                          200,
                                                                      child:
                                                                          Text(
                                                                        snapshot
                                                                            .data![index]
                                                                            .product!
                                                                            .name!,
                                                                        style: const TextStyle(
                                                                            fontFamily:
                                                                                "Poppins",
                                                                            fontSize:
                                                                                16,
                                                                            fontWeight:
                                                                                FontWeight.w700,
                                                                            color: AppColors.mainColor),
                                                                      ),
                                                                    ),
                                                                    snapshot
                                                                            .data![
                                                                                index]
                                                                            .product!
                                                                            .stockAvailable!
                                                                        ? const Text(
                                                                            "In-Stock",
                                                                            style:
                                                                                TextStyle(
                                                                              fontFamily: "Poppins",
                                                                              fontSize: 16,
                                                                              fontStyle: FontStyle.italic,
                                                                              fontWeight: FontWeight.w600,
                                                                              color: Colors.green,
                                                                            ))
                                                                        : const Text(
                                                                            "Out of stock",
                                                                            style: TextStyle(
                                                                                fontStyle: FontStyle.italic,
                                                                                fontFamily: "Poppins",
                                                                                fontSize: 16,
                                                                                fontWeight: FontWeight.w600,
                                                                                color: Colors.red),
                                                                          ),
                                                                    const SizedBox(
                                                                      height:
                                                                          20,
                                                                    ),
                                                                    Row(
                                                                      children: [
                                                                        Row(
                                                                          mainAxisSize:
                                                                              MainAxisSize.min,
                                                                          mainAxisAlignment:
                                                                              MainAxisAlignment.start,
                                                                          crossAxisAlignment:
                                                                              CrossAxisAlignment.start,
                                                                          children: [
                                                                            GestureDetector(
                                                                              onTap: () {
                                                                                controller.decrementCounter(index);
                                                                              },
                                                                              child: Container(
                                                                                padding: const EdgeInsets.all(2),
                                                                                decoration: BoxDecoration(shape: BoxShape.circle, border: Border.all(color: DarkTheme.normal)),
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
                                                                                padding: const EdgeInsets.only(top: 3.0),
                                                                                child: Container(
                                                                                    padding: const EdgeInsets.only(left: 15, right: 15, top: 5, bottom: 5),
                                                                                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), border: Border.all(color: DarkTheme.normal)),
                                                                                    child: Center(
                                                                                      child: Obx(
                                                                                        () => Text(
                                                                                          controller.counter[index].toString(),
                                                                                          style: const TextStyle(color: DarkTheme.dark, fontFamily: 'Poppins', fontWeight: FontWeight.w900, fontSize: 10),
                                                                                        ),
                                                                                      ),
                                                                                    )),
                                                                              ),
                                                                            ),
                                                                            const SizedBox(
                                                                              width: 14,
                                                                            ),
                                                                            GestureDetector(
                                                                              onTap: () {
                                                                                controller.incrementCounter(index);
                                                                              },
                                                                              child: Container(
                                                                                padding: const EdgeInsets.all(2),
                                                                                decoration: BoxDecoration(shape: BoxShape.circle, border: Border.all(color: DarkTheme.normal)),
                                                                                child: const Icon(
                                                                                  Icons.add,
                                                                                  color: DarkTheme.normal,
                                                                                ),
                                                                              ),
                                                                            ),
                                                                            Column(
                                                                              crossAxisAlignment: CrossAxisAlignment.end,
                                                                              children: [
                                                                                Padding(
                                                                                  padding: const EdgeInsets.only(top: 2.0),
                                                                                  child: SvgPicture.asset(
                                                                                    "assets/images/like.svg",
                                                                                    height: 25,
                                                                                  ),
                                                                                ),
                                                                                const SizedBox(
                                                                                  height: 15,
                                                                                ),
                                                                                Obx(() => Text(
                                                                                      "Rs. ${snapshot.data![index].product!.regularPrice! * controller.counter[index]}",
                                                                                      style: const TextStyle(color: DarkTheme.dark, fontFamily: 'Poppins', fontWeight: FontWeight.w700, fontSize: 16),
                                                                                    ))
                                                                              ],
                                                                            )
                                                                          ],
                                                                        ),
                                                                      ],
                                                                    )
                                                                  ],
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                      );
                                                    },
                                                  )
                                                : CustomProgressBar()),
                                      ),
                                      Container(
                                        color: LightTheme.whiteActive,
                                        child: const Text(
                                          "abc",
                                          style: TextStyle(
                                              color: LightTheme.whiteActive),
                                        ),
                                      ),
                                      Container(
                                          color: Colors.white,
                                          child: Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 70.0),
                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                    right: 40.0),
                                                child: Column(
                                                  children: [
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Text(
                                                          "Subtotal",
                                                          style: kThemeData
                                                              .textTheme
                                                              .bodyLarge,
                                                        ),
                                                        GetBuilder<CartController>(
                                                          builder: (_) {
                                                            int total = 0;
                                                            for (var i = 0; i < _.counter.length; i++) {
                                                              if (snapshot.data != null && i < snapshot.data!.length) {
                                                                int regularPrice = int.parse(
                                                                    snapshot.data![i].product!.regularPrice.toString());
                                                                int totalPrice = regularPrice * _.counter[i];
                                                                total += totalPrice;

                                                              }
                                                            }
                                                            return Text(
                                                              "Rs. ${total.toString()}",
                                                              style: kThemeData.textTheme.displaySmall,
                                                            );
                                                          },
                                                        )
                                                      ],
                                                    ),
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Text(
                                                          "Diamond off",
                                                          style: kThemeData
                                                              .textTheme
                                                              .bodyLarge,
                                                        ),
                                                        Text(
                                                          "0",
                                                          style: kThemeData
                                                              .textTheme
                                                              .displaySmall,
                                                        ),
                                                      ],
                                                    ),
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Text(
                                                          "Discount",
                                                          style: kThemeData
                                                              .textTheme
                                                              .bodyLarge,
                                                        ),
                                                        Text(
                                                          "Rs. 100",
                                                          style: kThemeData
                                                              .textTheme
                                                              .displaySmall,
                                                        ),
                                                      ],
                                                    ),
                                                    const SizedBox(
                                                      height: 40,
                                                    ),
                                                    Row(
                                                      mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                      children: [
                                                        Text(
                                                          "Subtotal",
                                                          style: kThemeData
                                                              .textTheme
                                                              .bodyLarge,
                                                        ),
                                                        GetBuilder<CartController>(
                                                          builder: (_) {
                                                            int total = 0;
                                                            int subTotal = 0;
                                                            for (var i = 0; i < _.counter.length; i++) {
                                                              if (snapshot.data != null && i < snapshot.data!.length) {
                                                                int regularPrice = int.parse(
                                                                    snapshot.data![i].product!.regularPrice.toString());
                                                                int totalPrice = regularPrice * _.counter[i];
                                                                total += totalPrice;
                                                                subTotal = total - 100;

                                                              }
                                                            }
                                                            return Text(
                                                              "Rs. ${subTotal.toString()}",
                                                              style: kThemeData.textTheme.displaySmall,
                                                            );
                                                          },
                                                        )
                                                      ],
                                                    ),
                                                  ],
                                                ),
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
                                              print(controller.cityName);
                                              Get.toNamed(
                                                  Routes.PERSONAL_INFORMATION);

                                              }),
                                      ),
                                      const SizedBox(
                                        height: 100,
                                      ),
                                    ]);
                              }
                            } else if (snapshot.hasError) {
                              print(snapshot.error);
                              return const Center(
                                child: Text("Sorry,not found!"),
                              );
                            }

                            return Shimmer.fromColors(
                                baseColor: Colors.white,
                                highlightColor: LightTheme.lightActive,
                                enabled: true,
                                child: _buildImage());
                          }),
                    )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildImage() {
    return GridView.count(
      childAspectRatio: 0.6,
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      crossAxisCount: 2,
      children: List.generate(
        4,
        (index) => Container(
          padding: const EdgeInsets.only(top: 10),
          margin: const EdgeInsets.all(10),
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
