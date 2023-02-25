import 'package:adora_baby/app/data/repositories/session_manager.dart';
import 'package:adora_baby/app/modules/cart/controllers/cart_controller.dart';
import 'package:adora_baby/app/modules/cart/views/order_confirmation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../config/app_colors.dart';
import '../../../config/app_theme.dart';
import '../../../routes/app_pages.dart';
import '../../../widgets/buttons.dart';
import '../../shop/widgets/auth_progress_indicator.dart';

class CheckOutView extends GetView<CartController> {
  const CheckOutView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return progressWrap(
        Scaffold(
            backgroundColor: LightTheme.white,
            body: SingleChildScrollView(
                child: SafeArea(
                    child: GetBuilder<CartController>(
              id: 'priceTotal',
              builder: (myController) => Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      color: LightTheme.white,
                      margin: EdgeInsets.symmetric(
                        horizontal: 32,
                      ),
                      padding: EdgeInsets.only(
                        bottom: Get.height * 0.02,
                        top: Get.height * 0.02,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                              onTap: () {
                                Get.back();
                              },
                              child: const Icon(Icons.arrow_back_ios_new)),
                          Expanded(
                            child: Container(),
                          ),
                          Text(
                            'Checkout',
                            style: kThemeData.textTheme.displaySmall
                                ?.copyWith(color: DarkTheme.normal),
                          ),
                          Expanded(
                            child: Container(),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      height: Get.height * 0.04,
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 32),
                      child: Text(
                        'Payment Method',
                        maxLines: 1,
                        style: kThemeData.textTheme.titleMedium?.copyWith(
                          color: DarkTheme.darkNormal,
                        ),
                      ),
                    ),
                    Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 23,
                          vertical: 24,
                        ),
                        margin: EdgeInsets.only(
                            left: 32, right: 32, top: 16, bottom: 10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          border:
                              Border.all(color: Colors.black.withOpacity(0.05)),
                          color: Colors.white,
                          boxShadow: [
                            const BoxShadow(
                              color: Color.fromRGBO(0, 0, 0, 0.1),
                              blurRadius: 0.2,
                              spreadRadius: 1,
                              offset: Offset(0, 2), // Shadow position
                            ),
                          ],
                        ),
                        child: Row(
                          children: [
                            Container(
                              height: 25,
                              width: 25,
                              padding: EdgeInsets.zero,
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      color: DarkTheme.darkNormal, width: 1),
                                  borderRadius: BorderRadius.circular(7)),
                              child: Transform.scale(
                                scale: 0.7,
                                child: Checkbox(
                                  autofocus: true,
                                  checkColor: DarkTheme.darkNormal,
                                  activeColor: Colors.white,
                                  value:
                                  myController.cashOnDeliveryCheckBox.value,
                                  onChanged: (bool? val) {},
                                  // onChanged: (value) => onChanged,
                                ),
                              ),
                            ),
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
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Cash on Delivery',
                                    style: kThemeData.textTheme.titleMedium
                                        ?.copyWith(color: DarkTheme.darkNormal),
                                  ),
                                  Text(
                                    'Pay Cash upon delivery',
                                    style: kThemeData.textTheme.bodyMedium
                                        ?.copyWith(color: DarkTheme.darkNormal),
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
                        margin:
                            EdgeInsets.symmetric(horizontal: 32, vertical: 0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          border:
                              Border.all(color: Colors.black.withOpacity(0.05)),
                          color: Colors.white,
                          boxShadow: [
                            const BoxShadow(
                              color: Color.fromRGBO(0, 0, 0, 0.06),
                              blurRadius: 0.2,
                              spreadRadius: 0.5,
                              offset: Offset(0, 2), // Shadow position
                            ),
                          ],
                        ),
                        child: Row(
                          children: [
                            GetBuilder<CartController>(
                              id: 'useDiamond',
                              builder: (myController) => Container(
                                height: 25,
                                width: 25,
                                padding: EdgeInsets.zero,
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        color: DarkTheme.darkNormal, width: 1),
                                    borderRadius: BorderRadius.circular(7)),
                                child: Transform.scale(
                                  scale: 0.7,
                                  child: Checkbox(
                                    autofocus: false,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(16.0),
                                      side: const BorderSide(
                                          width: 0, color: Colors.white),
                                    ),
                                    fillColor:
                                        MaterialStateProperty.all(Colors.white),
                                    focusColor: Colors.white,
                                    side: const BorderSide(
                                        width: 0, color: Colors.white),
                                    checkColor: DarkTheme.darkNormal,
                                    activeColor: Colors.white,
                                    value:
                                        myController.useDiamondCheckBox.value,
                                    onChanged: (bool? val) async {
                                      myController.useDiamondCheckBox.value =
                                          val ?? false;
                                      // if (myController.useDiamondCheckBox.value) {
                                      myController.showLoading(myController
                                          .progressBarStatusCheckout);
                                      final status = await myController
                                          .requestToUpdateCheckOut(
                                              myController
                                                  .checkoutModel.value.id,
                                              myController
                                                  .useDiamondCheckBox.value,
                                              '');
                                      myController.completeLoading(
                                          myController
                                              .progressBarStatusCheckout,
                                          status);
                                      // }
                                      myController.update(['useDiamond','priceTotal']);
                                    },
                                    // onChanged: (value) => onChanged,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 33,
                            ),
                            SvgPicture.asset(
                                "assets/images/profile_diamonds.svg",
                                height: 35,
                                color: DarkTheme.darkNormal),
                            SizedBox(
                              width: 33,
                            ),
                            Expanded(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    '${SessionManager.instance.user?.diamond ?? 0} Diamonds used',
                                    style: kThemeData.textTheme.titleMedium
                                        ?.copyWith(color: DarkTheme.darkNormal),
                                  ),
                                  Text(
                                    'Rs. ${myController.checkoutModel.value.dimondOff ?? 0} off',
                                    style: kThemeData.textTheme.bodyMedium
                                        ?.copyWith(color: DarkTheme.darkNormal),
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
                      padding: EdgeInsets.symmetric(horizontal: 32),
                      child: Text(
                        'Applied Coupon',
                        maxLines: 1,
                        style: kThemeData.textTheme.titleMedium?.copyWith(
                          color: DarkTheme.darkNormal,
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(
                          top: 20.0, left: 32, right: 32, bottom: 10),
                      color: Colors.white,
                      child: TextField(
                        readOnly: false,
                        enabled: true,
                        cursorColor: AppColors.primary300,
                        controller: myController.couponController,
                        style: kThemeData.textTheme.bodyLarge?.copyWith(
                          color: DarkTheme.darkNormal,
                        ),
                        decoration: InputDecoration(
                          label: Text(
                            '',
                            style: kThemeData.textTheme.bodyLarge?.copyWith(
                              color: DarkTheme.darkNormal,
                            ),
                          ),
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                          hintText: 'Coupon Code',
                          hintStyle: kThemeData.textTheme.bodyLarge
                              ?.copyWith(color: DarkTheme.darkLightActive),
                          contentPadding: const EdgeInsets.symmetric(
                              horizontal: 30, vertical: 8),
                          suffixIcon: GestureDetector(
                            onTap: () async {
                              if (myController.couponController.text
                                  .trim()
                                  .isNotEmpty) {
                                myController.showLoading(
                                    myController.progressBarStatusCheckout);
                                final status =
                                    await myController.requestToUpdateCheckOut(
                                        myController.checkoutModel.value.id,
                                        myController.useDiamondCheckBox.value,
                                        myController.couponController.text
                                            .trim());
                                if (status) {
                                  myController.update(['priceTotal']);
                                  var snackBar = SnackBar(
                                    elevation: 0,
                                    behavior: SnackBarBehavior.floating,
                                    backgroundColor: AppColors.success500,
                                    duration: Duration(milliseconds: 2000),
                                    content: Text(
                                        "Coupon code applied succesfully."),
                                  );
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(snackBar);
                                } else {
                                  var snackBar = SnackBar(
                                    elevation: 0,
                                    behavior: SnackBarBehavior.floating,
                                    backgroundColor: Colors.red,
                                    duration: Duration(milliseconds: 2000),
                                    content: Text("${myController.authError}"),
                                  );
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(snackBar);
                                }
                                myController.completeLoading(
                                    myController.progressBarStatusCheckout,
                                    status);
                              }
                            },
                            child: Padding(
                              padding: EdgeInsets.all(12),
                              child: Icon(
                                Icons.arrow_forward_ios,
                                color: DarkTheme.darkNormal,
                                size: 18,
                              ),
                            ),
                          ),
                          fillColor: Colors.white,
                          border: OutlineInputBorder(
                              borderSide: BorderSide(
                                  width: 1, color: AppColors.secondary500),
                              borderRadius: BorderRadius.circular(
                                33,
                              )),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(33),
                              borderSide: const BorderSide(
                                  width: 1,
                                  color: Color.fromRGBO(175, 152, 168, 1))),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(33),
                              borderSide: const BorderSide(
                                  width: 1,
                                  color: Color.fromRGBO(175, 152, 168, 1))),
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
                      height: Get.height * 0.04,
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 56,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Sub Total',
                            style: kThemeData.textTheme.bodyLarge
                                ?.copyWith(color: DarkTheme.darkNormal),
                          ),
                          Text(
                            'Rs. ${myController.checkoutModel.value.subTotal}',
                            style: kThemeData.textTheme.titleMedium
                                ?.copyWith(color: DarkTheme.darkNormal),
                          )
                        ],
                      ),
                    ),
                    Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 56, vertical: 5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Diamond Off',
                            style: kThemeData.textTheme.bodyLarge
                                ?.copyWith(color: DarkTheme.darkNormal),
                          ),
                          Text(
                            'Rs. ${myController.checkoutModel.value.dimondOff}',
                            style: kThemeData.textTheme.titleMedium
                                ?.copyWith(color: DarkTheme.dark),
                          )
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 56, right: 56, bottom: 5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Discount',
                            style: kThemeData.textTheme.bodyLarge
                                ?.copyWith(color: DarkTheme.darkNormal),
                          ),
                          Text(
                            'Rs. ${myController.checkoutModel.value.discount}',
                            style: kThemeData.textTheme.titleMedium
                                ?.copyWith(color: DarkTheme.dark),
                          )
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 56, right: 56, bottom: 5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Delivery Charge',
                            style: kThemeData.textTheme.bodyLarge
                                ?.copyWith(color: DarkTheme.dark),
                          ),
                          Text(
                            'Rs. ${myController.checkoutModel.value.deliveryCharge}',
                            style: kThemeData.textTheme.titleMedium
                                ?.copyWith(color: DarkTheme.dark),
                          )
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(
                          left: 56, right: 56, bottom: 5, top: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Grand Total',
                            style: kThemeData.textTheme.bodyLarge
                                ?.copyWith(color: DarkTheme.dark),
                          ),
                          Text(
                            'Rs. ${myController.checkoutModel.value.grandTotal}',
                            style: kThemeData.textTheme.titleMedium
                                ?.copyWith(color: DarkTheme.dark),
                          )
                        ],
                      ),
                    ),
                    Container(
                      height: Get.height * 0.02,
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 32),
                      child: ButtonsWidget(
                          name: "Confirm",
                          onPressed: () async {
                            try {
                              myController.showLoading(
                                  myController.progressBarStatusCheckout);
                              final status =
                                  await myController.requestToPlaceOrder();
                              if (!status) {
                                myController.completeLoading(
                                    myController.progressBarStatusCheckout,
                                    false);
                                var snackBar = SnackBar(
                                  elevation: 0,
                                  behavior: SnackBarBehavior.floating,
                                  backgroundColor: Colors.red,
                                  duration: const Duration(milliseconds: 2000),
                                  content:
                                      Text(myController.authError.toUpperCase()),
                                );
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(snackBar);
                              } else {
                                myController.completeLoading(
                                    myController.progressBarStatusCheckout,
                                    false);
                                var snackBar = SnackBar(
                                  elevation: 0,
                                  behavior: SnackBarBehavior.floating,
                                  backgroundColor: Colors.green,
                                  duration: const Duration(milliseconds: 2000),
                                  content: Text("Successfully placed order!"
                                      .toUpperCase()),
                                );
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(snackBar);
                                myController.cart();
                                myController.priceCart.value = 0.0;
                                Get.to(() => const OrderConfirmation());
                              }
                            } catch (e) {
                              myController.completeLoading(
                                  myController.progressBarStatusCheckout, false);
                            }
                          }),
                    )
                  ]),
            )))),
        controller.progressBarStatusCheckout);
  }
}
