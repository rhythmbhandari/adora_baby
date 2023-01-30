import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../modules/cart/controllers/cart_controller.dart';

class SingleCheckBox extends StatelessWidget {
  CartController controller = Get.find();
  @override
  Widget build(BuildContext context) {


    return  SizedBox(
      height: 40,
      width: 20,
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: controller.selectOne.length,
        itemBuilder: (context, index) {
          return Obx(()=>Checkbox(
            value: controller.selectOne[index],
            onChanged: (bool? value) {
              controller.selectOne[index]=value!;
            },
          )
          );
        },
      ),
    );
  }
}