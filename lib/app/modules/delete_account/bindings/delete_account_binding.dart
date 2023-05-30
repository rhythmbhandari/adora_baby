import 'package:get/get.dart';

import '../controllers/delete_account_controllers.dart';

class DeleteAccountBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DeleteAccountController>(
      () => DeleteAccountController(),
    );
  }
}
