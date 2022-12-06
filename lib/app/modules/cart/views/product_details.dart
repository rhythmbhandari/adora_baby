import 'package:adora_baby/app/data/repositories/cart_repository.dart';
import 'package:adora_baby/app/widgets/buttons.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../../main.dart';
import '../../../config/constants.dart';
import '../../../routes/app_pages.dart';
import '../controllers/cart_controller.dart';


class ProductDetails extends GetView<CartController> {
  const ProductDetails({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    var data = Get.arguments;
    var quantity = 5;


    return  Scaffold(
        body: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [

              Text(data),
              Text(quantity.toString()),
              ButtonsWidget(name: 'ADD TO CART', onPressed: ()  {
                print("abc");
               CartRepository.addToCart(data, quantity.toString());
              }
              )

            ],
          ),
        )
    );
  }
}
