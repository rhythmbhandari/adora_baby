import 'package:adora_baby/app/modules/cart/controllers/cart_controller.dart';
import 'package:adora_baby/app/modules/shop/controllers/all_products_controller.dart';
import 'package:adora_baby/app/modules/shop/controllers/shop_controller.dart';
import 'package:get/get.dart';

import '../../profile/controllers/profile_controller.dart';
import '../controllers/home_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeController>(
      () => HomeController(),
    );

    Get.lazyPut<ProfileController>(
      () => ProfileController(),
    );
    Get.lazyPut<ShopController>(
      () => ShopController(),
    );
    Get.lazyPut<CartController>(
      () => CartController(),
    );
  }
}
