import 'package:adora_baby/app/data/repositories/checkout_repositories.dart';
import 'package:adora_baby/app/modules/cart/controllers/cart_controller.dart';
import 'package:adora_baby/app/widgets/buttons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:get/get.dart';

import '../../../config/app_colors.dart';
import '../../../config/app_theme.dart';
import '../../../data/models/get_address_model.dart';

class CheckOutView extends GetView<CartController> {
  const CheckOutView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: LightTheme.whiteActive,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(left: 40.0, right: 40, top: 140),
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.only(top: 60, bottom: 40,right: 30,left: 30),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: Colors.grey.withOpacity(0.5))),
                  child: Column(
                    children: [
                      SvgPicture.asset("assets/images/amico.svg"),
                      Text(
                        "WE ARE ON OUR WAY",
                        style: kThemeData.textTheme.displaySmall,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Text(
                        "Hang Back and Relax!",
                        style: TextStyle(
                            fontFamily: 'Poppins',
                            color: Colors.black.withOpacity(0.5),
                            fontSize: 16,
                            fontWeight: FontWeight.w400),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                       Padding(
                         padding: const EdgeInsets.only(left: 35.0),
                         child: Text(
                          "Your order will be delivered in 2-5 business days.",
                          style: TextStyle(
                              fontFamily: 'Poppins',
                              color: Colors.black.withOpacity(0.5),
                              fontSize: 16,
                              fontWeight: FontWeight.w400),
                      ),
                       ),
                      const SizedBox(height: 60,),
                      ButtonsWidget(name: "Track My Order", onPressed: () {})
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
