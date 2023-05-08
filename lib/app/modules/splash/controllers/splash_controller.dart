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
    try {
      Future.delayed(const Duration(seconds: 2)).then((value) async {
        await (storage.readData(Constants.WALK_THROUGH_STATE)) == null
            ? Get.offNamed(Routes.WALKTHROUGH)
            : (await (storage.readData(Constants.LOGGED_IN_STATUS)) != null)
                ? Get.offNamed(Routes.HOME)
                : (await (storage.readData(Constants.OTP_STATUS)) != null)
                    ? Get.offNamed(Routes.LOGIN)
                    : Get.offNamed(Routes.PHONE);
        change(value, status: RxStatus.success());
      });
    } catch (e) {
      Get.offNamed(Routes.LOGIN);
      change(value, status: RxStatus.success());
    }
  }
}
