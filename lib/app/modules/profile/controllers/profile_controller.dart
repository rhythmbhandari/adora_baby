import 'package:adora_baby/app/data/models/user_model.dart';
import 'package:get/get.dart';

import '../../../data/repositories/data_repository.dart';
import '../../../data/repositories/session_manager.dart';

class ProfileController extends GetxController {
  //TODO: Implement ProfileController

  final count = 0.obs;

  final authError = ''.obs;

  final fullName = ''.obs;
  final phoneNumber = ''.obs;

  final ordersList = [].obs;

  final Rx<Users> user = Users(
    fullName: '',
    babyName: '',
    phoneNumber: '',
  ).obs;

  final progressBarStatus = false.obs;

  showProgressBar() => progressBarStatus.value = true;

  hideProgressBar() => progressBarStatus.value = false;

  @override
  void onInit() {
    fetchData();
    super.onInit();
  }

  Future<void> fetchData() async {
    await Future.wait(
      [
        getUserDetails(),
        getOrderList(),
      ],
    );
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
    if (SessionManager.instance.user != null) {
      user.value = SessionManager.instance.user ?? Users();
    }
  }

  Future<void> getUserDetails() async {
    showProgressBar();
    // final firebaseMessaging = FirebaseMessaging.instance;
    // String? deviceToken = await firebaseMessaging.getToken();
    await DataRepository.fetchProfileDetail().catchError((error) {
      authError.value = error;
      hideProgressBar();
    }).then(
      (value) => setUserData(),
    );
  }

  Future<void> getOrderList() async {
    showProgressBar();
    await DataRepository.fetchOrderList()
        .then(
          (value) => ordersList.value = value,
        )
        .then((value) => hideProgressBar())
        .catchError(
      (error) {
        authError.value = error;
        hideProgressBar();
      },
    );
  }
}
