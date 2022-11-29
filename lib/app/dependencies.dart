import 'package:get/get.dart';

import 'modules/shop/controllers/shop_controller.dart';

Future<void> init() async {
  Get.put(ShopController());

}