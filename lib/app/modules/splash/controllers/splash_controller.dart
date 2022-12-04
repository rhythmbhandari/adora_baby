import 'dart:async';
import 'package:get/get.dart';
import '../../../../main.dart';
import '../../../config/constants.dart';
import '../../../routes/app_pages.dart';

class SplashController extends GetxController with StateMixin<dynamic> {
  @override
  void onInit() {
    startLoader();
    super.onInit();
  }

  startLoader() async {
    Future.delayed(Duration(seconds: 2)).then((value) async {
      await (storage.readData(Constants.WALK_THROUGH_STATE)) == null
          ? Get.offNamed(Routes.WALKTHROUGH)
          : (await (storage.readData(Constants.LOGGED_IN_STATUS)) != null)
              ? Get.offNamed(Routes.HOME)
              : Get.offNamed(Routes.PHONE);
      change(value, status: RxStatus.success());
    });
  }
}
