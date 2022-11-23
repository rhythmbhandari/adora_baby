import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../../widgets/hot_sales.dart';
import '../controllers/shop_controller.dart';

class ShopView extends GetView<ShopController> {
  const ShopView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(

     backgroundColor: const Color.fromRGBO(250, 245, 252, 1),
      body: SingleChildScrollView(
        child: Column(
          children: [
            HotSale(),
            Text("abc")
          ],
        ),
      ),

    );
  }
}
