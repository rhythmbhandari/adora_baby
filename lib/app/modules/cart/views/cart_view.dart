import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../../main.dart';
import '../../../config/constants.dart';
import '../controllers/cart_controller.dart';


class CartView extends GetView<CartController> {
  const CartView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ProfileView'),
        centerTitle: true,
      ),
      body: const Text("Cart View is working",)
    );
  }
}
