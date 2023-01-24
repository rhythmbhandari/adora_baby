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

  final diamondIndex = 1.obs;

  final diamondListWeek = [].obs;
  final diamondHalfMonth = [].obs;
  final diamondListMonth = [].obs;

  final diamondListWeekOverview = [].obs;
  final diamondHalfMonthOverview = [].obs;
  final diamondListMonthOverview = [].obs;

  final progressStatus = ProgressStatus.IDLE.obs;

  final Rx<Orders> selectedOrders = Orders().obs;

  final dateTypeOrder = DateType.WEEK.obs;

  final dateTypeOverview = DateType.WEEK.obs;

  final dateTypeStatement = DateType.WEEK.obs;

  final currentPageOrder = 0.obs;
  final currentPageStatement = 0.obs;
  final currentPageOverview = 0.obs;

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
        getOrderList(
            isRefresh: true, isInitial: true, orderHistoryListWeek, index: 0),
        getOrderList(
            isRefresh: true,
            isInitial: true,
            orderHistoryListHalfMonth,
            index: 1),
        getOrderList(
            isRefresh: true, isInitial: true, orderHistoryListMonth, index: 2),
      ],
    );
  }

  Map<String, double> dataMap = {
    "Diamonds Earned": 0.0,
    "Diamonds Spent": 0.0,
  }.obs;

  Map<String, double> dataMapHalfMonth = {
    "Diamonds Earned": 0.0,
    "Diamonds Spent": 0.0,
  }.obs;

  Map<String, double> dataMapMonth = {
    "Diamonds Earned": 0.0,
    "Diamonds Spent": 0.0,
  }.obs;

  Future<void> fetchDiamonds() async {
    await Future.wait(
      [
        getDiamonds(isRefresh: true, isInitial: true, diamondListWeekOverview),
        getDiamonds(isRefresh: true, isInitial: true, diamondHalfMonthOverview),
        getDiamonds(isRefresh: true, isInitial: true, diamondListMonthOverview),
        getDiamonds(
            isRefresh: true, isInitial: true, diamondListWeek, index: 0),
        getDiamonds(
            isRefresh: true, isInitial: true, diamondHalfMonth, index: 1),
        getDiamonds(
            isRefresh: true, isInitial: true, diamondListMonth, index: 2),
      ],
    );
    pieChartCalculateWeek();
    pieChartCalculateHalfMonth();
    pieChartCalculateMonth();

    update();
  }

  void pieChartCalculateMonth() async {
    if (diamondListMonthOverview.isNotEmpty) {
      double diamondsSpent = 0.0;
      double diamondsEarned = 0.0;
      for (var i in diamondListMonthOverview) {
        if (i.types.toString().toLowerCase().contains('earned')) {
          diamondsEarned = diamondsEarned + i.amount;
        } else {
          diamondsSpent = diamondsSpent + i.amount;
        }
      }

      dataMapMonth = {
        "Diamonds Earned": diamondsEarned,
        "Diamonds Spent": diamondsSpent,
      };
      log('Earned ${dataMapMonth['Diamonds Earned']}');
    }
  }

  void pieChartCalculateHalfMonth() async {
    if (diamondHalfMonthOverview.isNotEmpty) {
      double diamondsSpent = 0.0;
      double diamondsEarned = 0.0;
      for (var i in diamondHalfMonthOverview) {
        if (i.types.toString().toLowerCase().contains('earned')) {
          diamondsEarned = diamondsEarned + i.amount;
        } else {
          diamondsSpent = diamondsSpent + i.amount;
        }
      }

      dataMapHalfMonth = {
        "Diamonds Earned": diamondsEarned,
        "Diamonds Spent": diamondsSpent,
      };
      log('Earned ${dataMapHalfMonth['Diamonds Earned']}');
    }
  }

  void pieChartCalculateWeek() async {
    if (diamondListWeekOverview.isNotEmpty) {
      double diamondsSpent = 0.0;
      double diamondsEarned = 0.0;
      for (var i in diamondListWeekOverview) {
        if (i.types.toString().toLowerCase().contains('earned')) {
          diamondsEarned = diamondsEarned + i.amount;
        } else {
          diamondsSpent = diamondsSpent + i.amount;
        }
      }

      dataMap = {
        "Diamonds Earned": diamondsEarned,
        "Diamonds Spent": diamondsSpent,
      };
      log('Earned ${dataMap['Diamonds Earned']}');
    }
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
  ScrollController scrollControllerOverview = new ScrollController();
  ScrollController scrollControllerStatement = new ScrollController();

  void scroll(double position, ScrollController scrollController) {
    scrollController.jumpTo(position);
  }

  void animateTab(double position, ScrollController scrollController) {
    if (position == 3.0) {
      scrollController.animateTo(position + 55,
          duration: Duration(milliseconds: 500), curve: Curves.easeIn);
    } else {
      scrollController.animateTo(position,
          duration: Duration(milliseconds: 500), curve: Curves.easeIn);
    }
  }

  void updateSelectedBookingPage(
    DateType _datetype,
    Rx<PageController> pageController,
    Rx<DateType> dateType,
    RxInt currentPageOrder,
  ) {
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
    animatePage(
      pageController,
      currentPageOrder,
    );
  }

  final pageController = PageController(initialPage: 0, keepPage: true).obs;

  final pageControllerStatement =
      PageController(initialPage: 0, keepPage: true).obs;

  final pageControllerOverview =
      PageController(initialPage: 0, keepPage: true).obs;

  void animatePage(
    Rx<PageController> pageController,
    RxInt currentPageOrder,
  ) {
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
      {bool isRefresh = true,
      bool isInitial = false,
      int index = 0,
      bool isOverview = false}) async {
    int time = index == 0
        ? 7
        : index == 1
            ? 14
            : 30;
    String keyword =
        '?datetime_range_before=${DateTime.now().year}-${DateTime.now().month}-${DateTime.now().day}T23:59:59&datetime_range_after=${DateTime.now().subtract(Duration(days: time)).year}-${DateTime.now().subtract(Duration(days: time)).month}-${DateTime.now().subtract(Duration(days: time)).day}T00:00:00';

    keyword = !isOverview
        ? '$keyword&page=${isRefresh ? 1 : orderHistoryIndex.value}'
        : '$keyword&limit=10000';

    showProgressBar();
    await DataRepository.fetchDiamonds(keyword)
        .then((value) => {
              {
                if (isRefresh && !isInitial)
                  {
                    if (value.isEmpty)
                      {
                        list.value = [].obs,
                        diamondIndex.value = 2,
                      }
                    else
                      {
                        list.value = value,
                        diamondIndex.value = 2,
                      }
                  }
                else if (isRefresh && isInitial)
                  {
                    if (value.isEmpty)
                      {
                        list.value = [].obs,
                        diamondIndex.value = 2,
                      }
                    else
                      {
                        diamondIndex.value = 2,
                        list.value = value,
                      }
                  }
                else
                  {
                    {
                      list.addAll(value),
                      diamondIndex.value++,
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

  Future<bool> cancelBooking() async {
    try {
      showProgressBar();
      final status = await DataRepository.cancel(selectedOrders.value.id)
          .catchError((error) {
        authError.value = error;
        return false;
      });

      if (status) {
        hideProgressBar();
        return true;
      } else {
        hideProgressBar();
        return false;
      }
    } catch (e) {
      authError.value = e.toString();
      log('Auth Error is ${authError}');
      hideProgressBar();
      return false;
    }
  }
}
