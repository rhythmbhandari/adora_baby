import 'dart:developer';

import 'package:adora_baby/app/data/models/user_model.dart';
import 'package:adora_baby/app/enums/date_type.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

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

  final orderHistoryListWeek = [].obs;
  final orderHistoryListHalfMonth = [].obs;
  final orderHistoryListMonth = [].obs;

  final orderHistoryIndex = 1.obs;

  final progressStatus = ProgressStatus.IDLE.obs;

  final Rx<Orders> selectedOrders = Orders().obs;

  final dateType = DateType.WEEK.obs;

  final currentPageOrder = 0.obs;

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
        getOrderList(isRefresh: true, isInitial: true, [].obs, index: 0),
      ],
    );
  }

  Future<void> fetchOrders() async {
    await Future.wait(
      [
        getOrderList(isRefresh: true, isInitial: true, orderHistoryListWeek),
        getOrderList(
            isRefresh: true, isInitial: true, orderHistoryListHalfMonth),
        getOrderList(isRefresh: true, isInitial: true, orderHistoryListMonth),
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

  ScrollController scrollController = new ScrollController();

  void scroll(double position) {
    scrollController.jumpTo(position);
  }

  void animateTab(double position) {
    if (position == 3.0) {
      scrollController.animateTo(position + 55,
          duration: Duration(milliseconds: 500), curve: Curves.easeIn);
    } else {
      scrollController.animateTo(position,
          duration: Duration(milliseconds: 500), curve: Curves.easeIn);
    }
  }

  void updateSelectedBookingPage(DateType _datetype) {
    switch (_datetype) {
      case DateType.WEEK:
        dateType.value = DateType.WEEK;
        currentPageOrder.value = 0;
        break;
      case DateType.HALFMONTH:
        dateType.value = DateType.HALFMONTH;
        currentPageOrder.value = 1;
        break;

      case DateType.MONTH:
        dateType.value = DateType.MONTH;
        currentPageOrder.value = 2;
        break;
    }
    animatePage();
  }

  final pageController = PageController(initialPage: 0, keepPage: true).obs;

  void animatePage() {
    pageController.value.animateToPage(currentPageOrder.value,
        duration: Duration(milliseconds: 500), curve: Curves.easeIn);
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

  Future<void> getOrderList(RxList list,
      {bool isRefresh = true, bool isInitial = false, int index = 0}) async {
    int time = index == 0
        ? 7
        : index == 1
            ? 14
            : 30;
    String keyword =
        '?datetime_range_before=${DateTime.now().year}-${DateTime.now().month}-${DateTime.now().day}T23:59:59&datetime_range_after=${DateTime.now().subtract(Duration(days: time)).year}-${DateTime.now().subtract(Duration(days: time)).month}-${DateTime.now().subtract(Duration(days: time)).day}T00:00:00&page=${isRefresh ? 1 : orderHistoryIndex.value}';

    showProgressBar();
    await DataRepository.fetchOrderList(keyword)
        .then((value) => {
              {
                if (isRefresh && !isInitial)
                  {
                    if (value.isEmpty)
                      {
                        list.value = [].obs,
                        orderHistoryIndex.value = 2,
                      }
                    else
                      {
                        list.value = value,
                        orderHistoryIndex.value = 2,
                        ordersList.value = value,
                      }
                  }
                else if (isRefresh && isInitial)
                  {
                    if (value.isEmpty)
                      {
                        ordersList.value = [].obs,
                        list.value = [].obs,
                        orderHistoryIndex.value = 2,
                      }
                    else
                      {
                        ordersList.value = value,
                        orderHistoryIndex.value = 2,
                        list.value = value,
                      }
                  }
                else
                  {
                    {
                      list.addAll(value),
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

  Future<void> getDiamonds(RxList list,
      {bool isRefresh = true, bool isInitial = false, int index = 0}) async {
    int time = index == 0
        ? 7
        : index == 1
            ? 14
            : 30;
    String keyword =
        '?datetime_range_before=${DateTime.now().year}-${DateTime.now().month}-${DateTime.now().day}T23:59:59&datetime_range_after=${DateTime.now().subtract(Duration(days: time)).year}-${DateTime.now().subtract(Duration(days: time)).month}-${DateTime.now().subtract(Duration(days: time)).day}T00:00:00&page=${isRefresh ? 1 : orderHistoryIndex.value}';

    showProgressBar();
    await DataRepository.fetchOrderList(keyword)
        .then((value) => {
              {
                if (isRefresh && !isInitial)
                  {
                    if (value.isEmpty)
                      {
                        list.value = [].obs,
                        orderHistoryIndex.value = 2,
                      }
                    else
                      {
                        list.value = value,
                        orderHistoryIndex.value = 2,
                        ordersList.value = value,
                      }
                  }
                else if (isRefresh && isInitial)
                  {
                    if (value.isEmpty)
                      {
                        ordersList.value = [].obs,
                        list.value = [].obs,
                        orderHistoryIndex.value = 2,
                      }
                    else
                      {
                        ordersList.value = value,
                        orderHistoryIndex.value = 2,
                        list.value = value,
                      }
                  }
                else
                  {
                    {
                      list.addAll(value),
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
