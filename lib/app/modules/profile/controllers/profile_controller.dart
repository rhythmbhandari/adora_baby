import 'dart:developer';

import 'package:adora_baby/app/data/models/user_model.dart';
import 'package:get/get.dart';

import '../../../data/models/orders_model.dart';
import '../../../data/repositories/data_repository.dart';
import '../../../data/repositories/session_manager.dart';
import '../../../enums/progress_status.dart';

class ProfileController extends GetxController {
  //TODO: Implement ProfileController

  final count = 0.obs;

  final authError = ''.obs;

  final fullName = ''.obs;
  final phoneNumber = ''.obs;

  final ordersList = [].obs;

  final orderHistoryList = [].obs;

  final orderHistoryIndex = 1.obs;

  final progressStatus = ProgressStatus.IDLE.obs;

  final Rx<Orders> selectedOrders = Orders().obs;

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
        getOrderList(
          isRefresh: true,
          isInitial: true,
        ),
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

  Future<void> getOrderList({
    bool isRefresh = true,
    bool isInitial = false,
  }) async {
    String keyword = '?page=${isRefresh ? 1 : orderHistoryIndex.value}';

    showProgressBar();
    await DataRepository.fetchOrderList(keyword)
        .then((value) => {
              {
                if (isRefresh && !isInitial)
                  {
                    if (value.isEmpty)
                      {
                        orderHistoryList.value = [].obs,
                        orderHistoryIndex.value = 2,
                      }
                    else
                      {
                        orderHistoryList.value = value,
                        orderHistoryIndex.value = 2,
                        ordersList.value = value,
                      }
                  }
                else if (isRefresh && isInitial)
                  {
                    if (value.isEmpty)
                      {
                        ordersList.value = [].obs,
                        orderHistoryList.value = [].obs,
                        orderHistoryIndex.value = 2,
                      }
                    else
                      {
                        ordersList.value = value,
                        orderHistoryIndex.value = 2,
                        orderHistoryList.value = value,
                      }
                  }
                else
                  {
                    {
                      orderHistoryList.addAll(value),
                      orderHistoryIndex.value++,
                    }
                  }
              }
            })
        .then((value) => hideProgressBar())
        .catchError(
      (error) {
        authError.value = error.toString();
        log('Auth Error is ${authError}');
        hideProgressBar();
      },
    );
  }
}
