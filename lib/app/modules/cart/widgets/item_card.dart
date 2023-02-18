import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../config/app_colors.dart';
import '../../../config/app_theme.dart';
import '../controllers/cart_controller.dart';

class CartCardWidget extends StatelessWidget {
  const CartCardWidget(
    this.index,
    this.controller, {
    Key? key,
  }) : super(key: key);

  final int index;
  final CartController controller;

  @override
  Widget build(BuildContext context) {
    return Card(
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
        padding:
            const EdgeInsets.only(right: 14, top: 20, bottom: 20, left: 14),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            GetBuilder<CartController>(
              id: 'individualCheckbox',
              builder: (myController) => Transform.scale(
                scale: 1.2,
                child: SizedBox(
                  height: 24.0,
                  width: 24.0,
                  child: Checkbox(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4),
                    ),

                    side:
                        BorderSide(width: 1, color: DarkTheme.darkLightActive),
                    focusColor: AppColors.primary500,
                    // fillColor:
                    //     MaterialStateProperty
                    //         .all(DarkTheme
                    //             .lightActive),
                    value: myController.cartList[index].checkBox,
                    onChanged: (bool? val) =>
                        myController.individualCheckboxPressed(
                      val,
                      index,
                    ),
                  ),
                ),
              ),
              // onChanged: (value) => onChanged,
            ),
            Container(
                padding: EdgeInsets.symmetric(
                  horizontal: 10,
                ),
                // height: Get.height * 0.18,
                width: Get.width * 0.35,
                child: Image.network(controller
                    .cartList[index].product!.productImages![0]!.name!)),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    controller.cartList[index].product!.shortName!,
                    style: kThemeData.textTheme.bodyMedium?.copyWith(
                      color: AppColors.secondary700,
                    ),
                  ),
                  Text(
                    controller.cartList[index].product!.name!,
                    style: kThemeData.textTheme.titleMedium?.copyWith(
                      color: AppColors.primary700,
                    ),
                  ),
                  controller.cartList[index].product!.stockAvailable!
                      ? Text(
                          "In-Stock",
                          style: kThemeData.textTheme.titleMedium?.copyWith(
                            color: AppColors.success700,
                            fontStyle: FontStyle.italic,
                          ),
                        )
                      : Text(
                          "Out of stock",
                          style: kThemeData.textTheme.titleMedium?.copyWith(
                            color: AppColors.error700,
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                  SizedBox(
                    height: 16,
                  ),
                  GetBuilder<CartController>(
                    id: 'add_remove_cart',
                    builder: (getController) => Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: () =>
                              getController.removeFromCartPressed(index),
                          child: Container(
                            padding: const EdgeInsets.all(2),
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(color: DarkTheme.normal)),
                            child: const Icon(
                              Icons.remove,
                              color: DarkTheme.normal,
                              size: 20,
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 14,
                        ),
                        Container(
                            padding: const EdgeInsets.only(top: 5, bottom: 5),
                            width: Get.width * 0.15,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(color: DarkTheme.normal)),
                            child: Center(
                              child: Obx(
                                () => Text(
                                    getController.cartList[index].quantity
                                        .toString(),
                                    style: kThemeData.textTheme.titleMedium
                                        ?.copyWith(color: DarkTheme.dark)),
                              ),
                            )),
                        const SizedBox(
                          width: 14,
                        ),
                        GestureDetector(
                          onTap: () => getController.addToCartPressed(index),
                          child: Container(
                            padding: const EdgeInsets.all(2),
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(color: DarkTheme.normal)),
                            child: const Icon(
                              Icons.add,
                              color: DarkTheme.normal,
                              size: 20,
                            ),
                          ),
                        ),
                        Expanded(
                          child: const SizedBox(),
                        ),
                        // SvgPicture.asset(
                        //   "assets/images/like.svg",
                        //   height: 24,
                        //   width: 24,
                        // )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  Obx(() => Container(
                        alignment: Alignment.bottomRight,
                        child: Text(
                          "Rs. ${controller.cartList[index].product.priceItem}",
                          style: const TextStyle(
                              color: DarkTheme.dark,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w700,
                              fontSize: 16),
                        ),
                      ))
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
