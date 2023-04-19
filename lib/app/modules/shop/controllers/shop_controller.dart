import 'dart:developer';
import 'dart:io';

import 'package:adora_baby/app/config/app_theme.dart';
import 'package:adora_baby/app/data/repositories/data_repository.dart';
import 'package:adora_baby/app/data/repositories/shop_respository.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../main.dart';
import '../../../data/models/hot_sales_model.dart';
import '../../../data/models/reviews.dart';
import '../../../data/models/stages_brands.dart';
import '../../../data/repositories/cart_repository.dart';
import '../../../widgets/buttons.dart';
import '../../../widgets/radio_buttons.dart';
import '../../../enums/progress_status.dart';
import '../../profile/controllers/profile_controller.dart';

class ShopController extends GetxController {
  var stagesValue = "true".obs;
  var allStages = "false";
  var supportedSitter = "true";
  var crawler = "crawler";
  var toddler = "toddler";
  final isSelected = false.obs;
  final authError = ''.obs;
  final trendingImagesList = [].obs;

  final countingReview = 0.obs;

  final Rx<HotSales> productSelected = HotSales().obs;

  final stagesList = [].obs;

  final hotSales = [].obs;

  final allProducts = [].obs;

  final tipsList = [].obs;
  final tipsListFiltered = [].obs;

  final allProductsFiltered = [].obs;
  final allProductsSearched = [].obs;
  final hotSalesFiltered = [].obs;
  final notificationsList = [].obs;

  final counter = 1.obs;

  final progressStatus = ProgressStatus.idle.obs;

  final progressStatusReview = ProgressStatus.idle.obs;

  final TextEditingController searchController = TextEditingController();

  final TextEditingController reviewController = TextEditingController();

  @override
  void onInit() {
    fetchData();
    super.onInit();
  }

  final hotSalesIndex = 1.obs;
  final allProductsIndex = 1.obs;
  final notificationsIndex = 1.obs;

  final tipsIndex = 1.obs;

  final allProductsSearchedIndex = 1.obs;

  final selectedStages = 10.obs;
  final selectedFilter = 0.obs;

  final filtersList = [
    ' Sort by Price: High to Low',
    'Sort by Price: Low to High'
  ].obs;

  final productDetailProgress = ProgressStatus.idle.obs;

  showProgressBarDetail() =>
      productDetailProgress.value = ProgressStatus.loading;

  hideProgressBarDetail() => productDetailProgress.value = ProgressStatus.idle;

  showProgressBarReview() =>
      progressStatusReview.value = ProgressStatus.loading;

  hideProgressBarReview() => progressStatusReview.value = ProgressStatus.idle;

  showProgressBar() => progressStatus.value = ProgressStatus.loading;

  hideProgressBar() => progressStatus.value = ProgressStatus.idle;

  showErrorBar() => progressStatus.value = ProgressStatus.error;

  hideErrorBar() => progressStatus.value = ProgressStatus.idle;

  incrementCounter(int stockQuantity) {
    log('Pressed');
    if (counter.value > 0) {
      if (counter.value < stockQuantity) {
        counter.value++;
      }
    } else {
      counter.value = 1;
    }
    update(['shopIncremenet']);
  }

  decrementCounter() {
    if (counter.value > 2) {
      counter.value--;
    } else {
      counter.value = 1;
    }

    update(['shopIncremenet']);
  }

  Future<void> fetchData() async {
    await Future.wait(
      [
        getTrendingImages(),
        getHotSales(true, ),
        getAllProducts(true),
        getStages(),
        getTips(true, true),
      ],
    );
  }

  @override
  void onReady() {
    super.onReady();
  }

  Future<void> getTrendingImages() async {
    try {
      showProgressBar();
      await ShopRepository.fetchTrendingImages()
          .then(
            (value) => trendingImagesList.value = value,
          )
          .then((value) => hideProgressBar());
    } catch (error) {
      authError.value = error.toString();
      showErrorBar();
      Future.delayed(const Duration(seconds:0)).then(
        (value) => hideProgressBar(),
      );
    }
  }

  Future<void> getStages() async {
    try {
      showProgressBar();
      await ShopRepository.fetchStages()
          .then(
            (value) => stagesList.value = value,
          )
          .then((value) => hideProgressBar());
    } catch (error) {
      authError.value = error.toString();
      showErrorBar();
      Future.delayed(const Duration(seconds: 0)).then(
        (value) => hideProgressBar(),
      );
    }
  }

  Future<void> getHotSales(bool isRefresh) async {
    try {
      showProgressBar();
      String keyword = '?page=1&ordering=-regular_price';

      await ShopRepository.fetchHotSales(keyword)
          .then((value) => {
                if (isRefresh)
                  {
                    if (value.isEmpty)
                      {hotSales.value = [].obs, hotSalesIndex.value = 2}
                    else
                      {hotSales.value = value, hotSalesIndex.value = 2}
                  }
                else
                  {hotSales.addAll(value), hotSalesIndex.value++}
              })
          .then((value) => hideProgressBar());
    } catch (error) {
      authError.value = error.toString();
      showErrorBar();
      Future.delayed(const Duration(seconds: 0)).then(
        (value) => hideProgressBar(),
      );
    }
  }

  Future<List<Reviews>> initiateGetReviews(int val) async {
    try {
      final response =
      await DataRepository.fetchReviews(productSelected.value.id ?? '');

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

  Future<void> getNotifications(bool isRefresh,) async {
    try {
      showProgressBar();

      String keyword = '?page=${isRefresh ? 1 : notificationsIndex.value}';

      await ShopRepository.fetchHotSales(keyword)
          .then((value) => {
        if (isRefresh)
          {
            if (value.isEmpty)
              {notificationsList.value = [].obs, notificationsIndex.value = 2}
            else
              {notificationsList.value = value, notificationsIndex.value = 2}
          }
        else
          {notificationsList.addAll(value), notificationsIndex.value++}
      })
          .then((value) => hideProgressBar());
    } catch (error) {
      authError.value = error.toString();
      showErrorBar();
      Future.delayed(const Duration(seconds: 0)).then(
            (value) => hideProgressBar(),
      );
    }
  }

  Future<void> getHotSalesFiltered(bool isRefresh,
      {bool isFilter = false,
      bool isSearch = false,
      String searchKeyword = '',
      String filterId = '',
      bool isOrdered = false,
      String ordering = '-regular_price'}) async {
    try {
      showProgressBar();
      if (isSearch || isOrdered || isFilter) {
        progressStatus.value = ProgressStatus.searching;
      }

      String keyword = '?page=${isRefresh ? 1 : hotSalesIndex.value}';
      keyword = '$keyword${isSearch ? '&search=$searchKeyword' : ''}';
      keyword = '$keyword${isFilter ? '&categories=$filterId' : ''}';
      keyword = '$keyword${isOrdered ? '&ordering=$ordering' : ''}';

      await ShopRepository.fetchHotSales(keyword)
          .then((value) => {
                if (isRefresh & (isSearch || isOrdered || isFilter))
                  {
                    if (value.isEmpty)
                      {hotSalesFiltered.value = [].obs, hotSalesIndex.value = 2}
                    else
                      {log('hehe'),
                        hotSalesFiltered.value = value, hotSalesIndex.value = 2}
                  }
                else
                  {hotSalesFiltered.addAll(value), hotSalesIndex.value++}
              })
          .then((value) => hideProgressBar());
    } catch (error) {
      authError.value = error.toString();
      showErrorBar();
      Future.delayed(const Duration(seconds: 0)).then(
        (value) => hideProgressBar(),
      );
    }
  }

  Future<void> searchProducts(bool isRefresh,
      {bool isFilter = false,
      bool isSearch = false,
      String searchKeyword = '',
      String filterId = '',
      bool isOrdered = false,
      String ordering = '-regular_price'}) async {
    try {
      showProgressBar();
      if (isSearch || isOrdered || isFilter) {
        progressStatus.value = ProgressStatus.searching;
      }

      String keyword =
          '?page=${isRefresh ? 1 : allProductsSearchedIndex.value}';
      keyword = '$keyword${isSearch ? '&search=$searchKeyword' : ''}';
      keyword = '$keyword${isFilter ? '&categories=$filterId' : ''}';
      keyword = '$keyword${isOrdered ? '&ordering=$ordering' : ''}';

      await ShopRepository.fetchAllProducts(keyword)
          .then((value) => {
                if (isRefresh & (isSearch || isOrdered || isFilter))
                  {
                    if (value.isEmpty)
                      {
                        allProductsSearched.value = [].obs,
                        allProductsSearchedIndex.value = 2
                      }
                    else
                      {
                        allProductsSearched.value = value,
                        allProductsSearchedIndex.value = 2
                      }
                  }
                else
                  {
                    allProductsSearched.addAll(value),
                    allProductsSearchedIndex.value++
                  }
              })
          .then((value) => hideProgressBar());
    } catch (error) {
      authError.value = error.toString();
      showErrorBar();
      Future.delayed(const Duration(seconds: 0)).then(
        (value) => hideProgressBar(),
      );
    }
  }

  Future<void> getAllProducts(bool isRefresh) async {
    try {
      showProgressBar();
      String keyword = '?page=1&ordering=-regular_price';

      await ShopRepository.fetchAllProducts(keyword)
          .then((value) => {
                if (isRefresh)
                  {
                    if (value.isEmpty)
                      {allProducts.value = [].obs, allProductsIndex.value = 2}
                    else
                      {allProducts.value = value, allProductsIndex.value = 2}
                  }
                else
                  {allProducts.addAll(value), allProductsIndex.value++}
              })
          .then((value) => hideProgressBar());
    } catch (error) {
      authError.value = error.toString();
      showErrorBar();
      Future.delayed(const Duration(seconds: 0)).then(
        (value) => hideProgressBar(),
      );
    }
  }

  Future<void> getTips(bool isRefresh, bool isInitial) async {
    try {
      showProgressBar();

      String keyword = '?page=$tipsIndex';

      await ShopRepository.fetchTips(isRefresh ? '?page=1' : '?page=$tipsIndex')
          .then((value) => {
                if (isRefresh)
                  {
                    if (value.isEmpty)
                      {
                        tipsListFiltered.value = [].obs,
                        tipsIndex.value = 2,
                        tipsList.value = [].obs,
                      }
                    else
                      {
                        tipsListFiltered.value = value,
                        tipsIndex.value = 2,
                        tipsList.value = value,
                      }
                  }
                else
                  {
                    tipsListFiltered.addAll(value),
                    tipsIndex.value++,
                  }
              })
          .then((value) => hideProgressBar());
    } catch (error) {
      authError.value = error.toString();
      showErrorBar();
      Future.delayed(const Duration(seconds: 0)).then(
        (value) => hideProgressBar(),
      );
    }
  }

  Future<void> getAllProductsFiltered(bool isRefresh,
      {bool isFilter = false,
      bool isSearch = false,
      String searchKeyword = '',
      String filterId = '',
      bool isOrdered = false,
      String ordering = '-regular_price'}) async {
    try {
      showProgressBar();
      if (isSearch || isOrdered || isFilter) {
        progressStatus.value = ProgressStatus.searching;
      }

      String keyword = '?page=${isRefresh ? 1 : allProductsIndex.value}';
      keyword = '$keyword${isSearch ? '&search=$searchKeyword' : ''}';
      keyword = '$keyword${isFilter ? '&categories=$filterId' : ''}';
      keyword = '$keyword${isOrdered ? '&ordering=$ordering' : ''}';

      await ShopRepository.fetchAllProducts(keyword)
          .then((value) => {
                if (isRefresh & (isSearch || isOrdered || isFilter))
                  {
                    if (value.isEmpty)
                      {
                        allProductsFiltered.value = [].obs,
                        allProductsIndex.value = 2
                      }
                    else
                      {
                        allProductsFiltered.value = value,
                        allProductsIndex.value = 2
                      }
                  }
                else
                  {allProductsFiltered.addAll(value), allProductsIndex.value++}
              })
          .then((value) => hideProgressBar());
    } catch (error) {
      authError.value = error.toString();
      showErrorBar();
      Future.delayed(const Duration(seconds: 0)).then(
        (value) => hideProgressBar(),
      );
    }
  }

  Future<bool> requestAddToCart(String name) async {
    try {
      final status = await CartRepository.addToCart(
          name.toString(), counter.toString().trim());
      if (status) {
        return true;
      } else {
        return false;
      }
    } catch (error) {
      authError.value = '$error';
      return false;
    }
  }

  final ratingsReview = 0.0.obs;

  Future<bool> initiateReview(String productId) async {
    try {
      if (ratingsReview.value == 0.0) {
        authError.value = 'Please provide a rating.';
        return false;
      } else if (reviewController.text.trim().isEmpty) {
        authError.value = 'Please write a review.';
        return false;
      }
      final status = await CartRepository.postReview(
          ratingsReview.value.toStringAsPrecision(1), reviewController.text.trim(), productId);

      if (status) {
        return true;
      } else {
        return false;
      }
    } catch (error) {
      authError.value = '$error';
      return false;
    }
  }
}
