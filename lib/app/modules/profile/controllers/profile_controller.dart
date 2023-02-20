import 'dart:developer';
import 'dart:io';

import 'package:adora_baby/app/data/models/user_model.dart';
import 'package:adora_baby/app/enums/date_type.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../data/models/order_logs_model.dart';
import '../../../data/models/orders_model.dart';
import '../../../data/repositories/auth_repository.dart';
import '../../../data/repositories/cart_repository.dart';
import '../../../data/repositories/checkout_repositories.dart';
import '../../../data/repositories/data_repository.dart';
import '../../../data/repositories/session_manager.dart';
import '../../../enums/progress_status.dart';
import '../../../utils/date_time_converter.dart';

class ProfileController extends GetxController {
  //TODO: Implement ProfileController

  final count = 0.obs;

  final authError = ''.obs;

  final babyMedicalCondition = [].obs;

  final imageBoolMain = false.obs;
  final imageBoolChild = false.obs;

  final isEditAddress = false.obs;

  final selectedTags = [].obs;

  final fullName = ''.obs;
  final phoneNumber = ''.obs;

  final ordersList = [].obs;

  final orderHistoryListWeek = [].obs;
  final orderHistoryListHalfMonth = [].obs;
  final orderHistoryListMonth = [].obs;

  final selectedCity = '0'.obs;

  final editAddressId = '0'.obs;

  TextEditingController addNameController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController landMarkController = TextEditingController();

  File? imagesMain;
  File? imagesChild;

  final imagePicker = ImagePicker();

  final orderHistoryIndex = 1.obs;

  final orderHistoryIndexWeek = 1.obs;

  final orderHistoryIndexMonth = 1.obs;

  final orderHistoryIndexDays = 1.obs;

  final diamondIndex = 1.obs;

  final diamondListWeek = [].obs;
  final diamondHalfMonth = [].obs;
  final diamondListMonth = [].obs;

  final diamondListWeekOverview = [].obs;
  final diamondHalfMonthOverview = [].obs;
  final diamondListMonthOverview = [].obs;

  final progressStatus = ProgressStatus.idle.obs;

  final progressStatusOrderProfile = ProgressStatus.idle.obs;

  final progressStatusOrderWeek = ProgressStatus.idle.obs;

  final progressStatusOrderHalfMonths = ProgressStatus.idle.obs;

  final progressStatusOrderMonth = ProgressStatus.idle.obs;

  final progressStatusDiamondWeek = ProgressStatus.idle.obs;

  final progressStatusDiamondHalfMonths = ProgressStatus.idle.obs;

  final progressStatusDiamondMonth = ProgressStatus.idle.obs;

  final progressStatusDiamondWeekStatement = ProgressStatus.idle.obs;

  final progressStatusDiamondHalfMonthsStatement = ProgressStatus.idle.obs;

  final progressStatusDiamondMonthStatement = ProgressStatus.idle.obs;

  final Rx<Orders> selectedOrders = Orders().obs;

  final dateTypeOrder = DateType.WEEK.obs;

  final dateTypeOverview = DateType.WEEK.obs;

  final dateTypeStatement = DateType.WEEK.obs;

  final currentPageOrder = 0.obs;
  final currentPageStatement = 0.obs;
  final currentPageOverview = 0.obs;

  final RxList addressList = [].obs;

  final RxList citiesList = [].obs;
  final RxList citiesId = [].obs;

  TextEditingController fullNameController = TextEditingController();
  TextEditingController contactInformationController = TextEditingController();

  TextEditingController babyNameController = TextEditingController();
  TextEditingController babyDobController = TextEditingController();
  TextEditingController specialNoteController = TextEditingController();

  String? _dob;

  setDate(String date) => _dob = date;

  showLoading(Rx<ProgressStatus> status) =>
      status.value = ProgressStatus.loading;

  showSearching(Rx<ProgressStatus> status) =>
      status.value = ProgressStatus.searching;

  completeLoading(Rx<ProgressStatus> progressStatus, bool isEmpty) => {
        if (isEmpty)
          {
            progressStatus.value = ProgressStatus.empty,
          }
        else
          {
            progressStatus.value = ProgressStatus.success,
          }
      };

  final progressBarStatusEditProfile = ProgressStatus.idle.obs;

  final progressBarStatusAddAddress = ProgressStatus.idle.obs;

  final progressBarStatusOrderDetails = false.obs;

  showNetworkError(
    Rx<ProgressStatus> progressStatus,
  ) =>
      progressStatus.value = ProgressStatus.internetError;

  showError(
    Rx<ProgressStatus> progressStatus,
  ) =>
      progressStatus.value = ProgressStatus.error;

  hideError(
    Rx<ProgressStatus> progressStatus,
  ) =>
      progressStatus.value = ProgressStatus.idle;

  final Rx<Users> user = Users(
    fullName: '',
    babyName: '',
    phoneNumber: '',
  ).obs;

  setUserData() {
    hideProgressBar();
    if (SessionManager.instance.user != null) {
      user.value = SessionManager.instance.user ?? Users();
    }
    fullNameController.text = user.value.fullName ?? '';
    contactInformationController.text = user.value.phoneNumber ?? '';
    babyNameController.text = user.value.babyName ?? '';
    babyDobController.text =
        DateFormat('yyyy-MM-dd').format(user.value.babyDob ?? DateTime.now()) ??
            '';
    selectedTags.value = [].obs;
    for (var i in user.value.accountMedicalConditiob == null
        ? []
        : user.value.accountMedicalConditiob!) {
      selectedTags.addAll(i.medicalCondition);
    }
    update(
      ['homePageProfile'],
    );
  }

  setChildData() {}

  final progressBarStatus = false.obs;

  showProgressBar() => progressBarStatus.value = true;

  hideProgressBar() => progressBarStatus.value = false;

  Future getImage(ImageSource imageSource) async {
    try {
      final image = await imagePicker.pickImage(source: imageSource);
      cropPickedImage(image!.path);
    } catch (e) {
      debugPrint('Exception caught $e');
    }
  }

  cropPickedImage(filePath) async {
    final croppedImage = await ImageCropper().cropImage(
        sourcePath: filePath,
        maxWidth: 1080,
        maxHeight: 1080,
        aspectRatio: const CropAspectRatio(ratioX: 1.0, ratioY: 1.0));
    if (croppedImage != null) {
      imagesMain = File(croppedImage.path);
      imagesMain == null
          ? imageBoolMain.value = false
          : imageBoolMain.value = true;
      updatePhoto(
        imagesMain!,
        'PARENTS',
      );
      update();
    }
  }

  Future getImageChild(ImageSource imageSource) async {
    try {
      final imageChilds = await imagePicker.pickImage(source: imageSource);
      cropPickedImageChild(imageChilds!.path);
    } catch (e) {
      debugPrint('Exception caught $e');
    }
  }

  cropPickedImageChild(filePath) async {
    final croppedImage = await ImageCropper().cropImage(
        sourcePath: filePath,
        maxWidth: 1080,
        maxHeight: 1080,
        aspectRatio: const CropAspectRatio(ratioX: 1.0, ratioY: 1.0));
    if (croppedImage != null) {
      imagesChild = File(croppedImage.path);
      imagesChild == null
          ? imageBoolChild.value = false
          : imageBoolChild.value = true;
      updatePhoto(
        imagesChild!,
        'CHILD',
      );
      update();
    }
  }

  final isPrimaryAddAddress = false.obs;

  @override
  void onInit() {
    fetchData();
    super.onInit();
  }

  Future<void> fetchData() async {
    showLoading(progressStatus);
    final status = await Future.wait(
      [
        getUserDetails(),
        getOrderList(
          isRefresh: true,
          isInitial: true,
          ordersList,
          orderHistoryIndex,
          progressStatusOrderProfile,
          index: 0,
        ),
        getAddressList(),
        getCities(),
      ],
    );
    if(status.contains(false)){
      completeLoading(progressStatus, true);
    }else{
      completeLoading(progressStatus, false);
    }

  }

  Future<bool> validateAddress() async {
    bool isValid = true;

    String addressName = addNameController.text.trim();
    String cityName = selectedCity.value;
    String nearestLandmark = landMarkController.text.trim();
    if (addressName.isEmpty) {
      authError.value = 'Please enter address name.';
      isValid = false;
      return isValid;
    } else if (cityName.isEmpty || cityName == '0') {
      authError.value = 'Please select city.';
      isValid = false;
      return isValid;
    } else if (nearestLandmark.isEmpty) {
      authError.value = 'Please enter nearest landmark.';
      isValid = false;
      return isValid;
    }
    final status = isEditAddress.value
        ? await requestToEditAddress(
            cityName, nearestLandmark, addressName, isPrimaryAddAddress.value)
        : await requestToAddAddress(
            cityName, nearestLandmark, addressName, isPrimaryAddAddress.value);
    if (status) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> requestToAddAddress(
    String city,
    String landmark,
    String addressName,
    bool isPrimary,
  ) async {
    try {
      final status = await CheckOutRepository.addAddress(
        addressName,
        city,
        landmark,
        isPrimary,
      );

      if (status) {
        getAddressList();
        return true;
      } else {
        authError.value = 'Could not add address.';
        return false;
      }
    } catch (e) {
      authError.value = e.toString();
      return false;
    }
  }

  Future<bool> requestToEditAddress(
    String city,
    String landmark,
    String addressName,
    bool isPrimary,
  ) async {
    try {
      final status = await CheckOutRepository.updateAddress(
        addressName,
        city,
        landmark,
        isPrimary,
        editAddressId.value,
      );
      if (status) {
        getAddressList();
        return true;
      } else {
        authError.value = 'Could not add address.';
        return false;
      }
    } catch (e) {
      authError.value = e.toString();
      return false;
    }
  }

  Future<bool> getCities() async {
    try {
      showSearching(progressBarStatusAddAddress);
      final response = await CartRepository.getCities();
      if (response.isNotEmpty) {
        // for (var listItem in response) {
        //   citiesList.add(listItem);
        //   // citiesId.add(listItem.id);
        // }
        citiesList.value = response;
        selectedCity.value = citiesList[0].id;
        completeLoading(progressBarStatusAddAddress, false);
        return true;
      } else {
        completeLoading(
          progressBarStatusAddAddress,
          true,
        );
        return false;
      }
    } catch (e) {
      showError(
        progressBarStatusAddAddress,
      );
      return false;
    }
  }

  Future<bool> getAddressList() async {
    try {
      showSearching(progressBarStatusEditProfile);
      final response = await CheckOutRepository.getAddress();
      if (response.isNotEmpty) {
        addressList.value = response;
        addressList[0].checked = true;
        completeLoading(progressBarStatusEditProfile, false);
        return true;
      } else {
        completeLoading(
          progressBarStatusEditProfile,
          true,
        );
        return false;
      }
    } catch (e) {
      showError(
        progressBarStatusEditProfile,
      );
      return false;
    }
  }

  Future<void> fetchOrders() async {
    await Future.wait(
      [
        getOrderList(
            isRefresh: true,
            isInitial: true,
            orderHistoryListWeek,
            orderHistoryIndexWeek,
            progressStatusOrderWeek,
            index: 0),
        getOrderList(
            isRefresh: true,
            isInitial: true,
            orderHistoryListHalfMonth,
            orderHistoryIndexDays,
            progressStatusOrderHalfMonths,
            index: 1),
        getOrderList(
          isRefresh: true,
          isInitial: true,
          orderHistoryListMonth,
          orderHistoryIndexMonth,
          progressStatusOrderMonth,
          index: 2,
        ),
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
        getDiamonds(
          isRefresh: true,
          isInitial: true,
          diamondListWeekOverview,
          progressStatusDiamondWeek,
        ),
        getDiamonds(
          isRefresh: true,
          isInitial: true,
          diamondHalfMonthOverview,
          progressStatusDiamondHalfMonths,
        ),
        getDiamonds(
          isRefresh: true,
          isInitial: true,
          diamondListMonthOverview,
          progressStatusDiamondMonth,
        ),
        getDiamonds(
          isRefresh: true,
          isInitial: true,
          diamondListWeek,
          index: 0,
          progressStatusDiamondMonthStatement,
        ),
        getDiamonds(
          isRefresh: true,
          isInitial: true,
          diamondHalfMonth,
          index: 1,
          progressStatusDiamondHalfMonthsStatement,
        ),
        getDiamonds(
          isRefresh: true,
          isInitial: true,
          diamondListMonth,
          index: 2,
          progressStatusDiamondMonthStatement,
        ),
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
    try {
      showProgressBar();
      // final firebaseMessaging = FirebaseMessaging.instance;
      // String? deviceToken = await firebaseMessaging.getToken();
      await DataRepository.fetchProfileDetail().then(
        (value) => setUserData(),
      );

      hideProgressBar();
    } catch (error) {
      authError.value = '$error';

      hideProgressBar();
    }
  }

  Future<void> getOrderList(
    RxList list,
    RxInt orderIndex,
    Rx<ProgressStatus> progressStatus, {
    bool isRefresh = false,
    bool isInitial = false,
    int index = 0,
  }) async {
    try {
      int time = index == 0
          ? 7
          : index == 1
              ? 14
              : 30;
      String keyword =
          '?datetime_range_before=${DateTime.now().year}-${DateTime.now().month}-${DateTime.now().day}T23:59:59&datetime_range_after=${DateTime.now().subtract(Duration(days: time)).year}-${DateTime.now().subtract(Duration(days: time)).month}-${DateTime.now().subtract(Duration(days: time)).day}T00:00:00&page=${isRefresh ? 1 : orderIndex.value}';

      if (isRefresh) {
        showLoading(progressStatus);
      }

      await DataRepository.fetchOrderList(keyword)
          .then((value) => {
                {
                  if (isRefresh && !isInitial)
                    {
                      if (value.isEmpty)
                        {
                          list.value = [].obs,
                          orderIndex.value = 2,
                        }
                      else
                        {
                          list.value = value,
                          orderIndex.value = 2,
                        }
                    }
                  else if (isRefresh && isInitial)
                    {
                      if (value.isEmpty)
                        {
                          list.value = [].obs,
                          orderIndex.value = 2,
                        }
                      else
                        {
                          list.value = value,
                          orderIndex.value = 2,
                        }
                    }
                  else
                    {
                      {
                        list.addAll(value),
                        orderIndex.value++,
                      }
                    }
                }
              })
          .then(
            (value) => completeLoading(
              progressStatus,
              list.isEmpty ? true : false,
            ),
          );
    } catch (error) {
      authError.value = error.toString();
      log('Auth Error is $authError');
      showError(
        progressStatus,
      );
    }
  }

  Future<void> getDiamonds(RxList list, Rx<ProgressStatus> progressStatus,
      {bool isRefresh = false,
      bool isInitial = false,
      int index = 0,
      bool isOverview = false}) async {
    try {
      if (isRefresh) {
        showLoading(progressStatus);
      }

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
          .then(
            (value) => completeLoading(
              progressStatus,
              list.isEmpty ? true : false,
            ),
          );
    } catch (error) {
      authError.value = error.toString();
      log('Auth Error is ${authError}');
      showError(
        progressStatus,
      );
    }
  }

  Future<bool> cancelBooking() async {
    try {
      showProgressBar();
      final status = await DataRepository.cancel(selectedOrders.value.id);

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

  Future<List> getMedicalCategories() async {
    try {
      final response = await AuthRepository.fetchMedicalCategories();

      if (response.isNotEmpty) {
        babyMedicalCondition.value = response;
        return response;
      } else {
        return [];
      }
    } catch (error) {
      authError.value = '$error';
      return [];
    }
  }

  Future<List<OrderLogsModel>> initiateTrackOrder() async {
    try {
      final response =
          await DataRepository.fetchOrderLogs(selectedOrders.value.id ?? '');

      log('Response is $response');
      if (response.isNotEmpty) {
        return response;
      } else {
        return [];
      }
    } catch (e) {
      log('Error is $e');
      return [];
    }
  }

  Future<bool> editProfile(String body) async {
    try {
      showProgressBar();
      await DataRepository.updateProfile(body)
          .then((value) async => await getUserDetails());
      return true;
    } catch (error) {
      authError.value = '$error';
      hideProgressBar();
      return false;
    }
  }

  Future<bool> addMedicalCondition() async {
    try {
      await AuthRepository.updateMedicalCondition(
              specialNoteController.text.trim().length < 2
                  ? 'empty'
                  : specialNoteController.text.trim(),
              selectedTags)
          .then((value) async => await getUserDetails());
      return true;
    } catch (error) {
      authError.value = '$error';
      return false;
    }
  }

  Future<bool> updatePhoto(File image, String pictureOf) async {
    try {
      await AuthRepository.updatePhoto(
        image,
        pictureOf,
      ).then((value) async => await getUserDetails());
      return true;
    } catch (error) {
      authError.value = '$error';
      return false;
    }
  }
}
