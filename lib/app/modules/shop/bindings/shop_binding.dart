import 'package:adora_baby/app/modules/profile/controllers/profile_controller.dart';
import 'package:adora_baby/app/modules/shop/controllers/all_products_controller.dart';
import 'package:get/get.dart';

import '../controllers/shop_controller.dart';

class ShopBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ShopController>(
      () => ShopController(),
    );
    Get.lazyPut<AllProductsController>(
          () => AllProductsController(),
    );
  }
}
