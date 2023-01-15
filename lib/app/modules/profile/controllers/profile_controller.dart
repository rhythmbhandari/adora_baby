import 'package:get/get.dart';

import '../../../data/repositories/data_repository.dart';
import '../../../data/repositories/session_manager.dart';

class ProfileController extends GetxController {
  //TODO: Implement ProfileController

  final count = 0.obs;

  final authError = ''.obs;

  final fullName = ''.obs;
  final phoneNumber = ''.obs;

  final progressBarStatus = false.obs;

  showProgressBar() => progressBarStatus.value = true;

  hideProgressBar() => progressBarStatus.value = false;

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  setUserData() async {
    hideProgressBar();
    fullName.value = '${SessionManager.instance.user?.fullName}';
    phoneNumber.value = '${SessionManager.instance.user?.phoneNumber}';
  }

  Future<void> getUserDetails() async {
    showProgressBar();
    // final firebaseMessaging = FirebaseMessaging.instance;
    // String? deviceToken = await firebaseMessaging.getToken();
    await DataRepository.fetchProfileDetail()
        .catchError((error) {
      authError.value = error;
      hideProgressBar();
    }).then(
          (value) => setUserData(),
    );
  }

  
}
