import 'package:adora_baby/app/modules/shop/controllers/all_products_controller.dart';
import 'package:get/get.dart';


class AllProductsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AllProductsController>(
          () => AllProductsController(),
    );
  }
}
