import 'dart:developer';
import 'dart:io';

import 'package:adora_baby/app/config/app_theme.dart';
import 'package:adora_baby/app/data/repositories/data_repository.dart';
import 'package:adora_baby/app/data/repositories/shop_respository.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../main.dart';
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

  final stagesList = [].obs;

  final hotSales = [].obs;

  final allProducts = [].obs;

  final tipsList = [].obs;
  final tipsListFiltered = [].obs;

  final allProductsFiltered = [].obs;
  final allProductsSearched = [].obs;
  final hotSalesFiltered = [].obs;

  final counter = 1.obs;

  final progressStatus = ProgressStatus.idle.obs;

  final TextEditingController searchController = TextEditingController();

  @override
  void onInit() {
    fetchData();
    super.onInit();
  }

  final hotSalesIndex = 1.obs;
  final allProductsIndex = 1.obs;

  final tipsIndex = 1.obs;

  final allProductsSearchedIndex = 1.obs;

  final selectedStages = 10.obs;
  final selectedFilter = 0.obs;

  final filtersList = [
    // 'Recently Added',
    // 'Sort by Popularity',
    ' Sort by Price: High to Low',
    'Sort by Price: Low to High'
  ].obs;

  final productDetailProgress = ProgressStatus.idle.obs;


  showProgressBarDetail() => productDetailProgress.value = ProgressStatus.loading;

  hideProgressBarDetail() => productDetailProgress.value = ProgressStatus.idle;


  showProgressBar() => progressStatus.value = ProgressStatus.loading;

  hideProgressBar() => progressStatus.value = ProgressStatus.idle;

  showErrorBar() => progressStatus.value = ProgressStatus.error;

  hideErrorBar() => progressStatus.value = ProgressStatus.idle;

  incrementCounter(int stockQuantity) {
    log('Pressed');
    if(counter.value > 0){
      if(counter.value < stockQuantity){
        counter.value++;
      }
    }else{
      counter.value = 1;
    }
    update(['shopIncremenet']);
  }

  decrementCounter() {
    if(counter.value > 2){

      counter.value--;
    }else{
      counter.value = 1;
    }

    update(['shopIncremenet']);
  }

  Future<void> fetchData() async {
    await Future.wait(
      [
        getTrendingImages(),
        getHotSales(true),
        getAllProducts(true),
        getStages(),
        DataRepository.fetchProfileDetail(),
        getTips(true, true),
      ],
    );
  }

  @override
  void onReady() {
    super.onReady();
  }

  Future<void> getTrendingImages() async {
    showProgressBar();
    await ShopRepository.fetchTrendingImages()
        .then(
          (value) => trendingImagesList.value = value,
        )
        .then((value) => hideProgressBar())
        .catchError(
      (error, stackTrace) {
        authError.value = error.toString();
        showErrorBar();
        Future.delayed(const Duration(seconds: 2)).then(
          (value) => hideProgressBar(),
        );
      },
    );
  }

  Future<void> getStages() async {
    showProgressBar();
    await ShopRepository.fetchStages()
        .then(
          (value) => stagesList.value = value,
        )
        .then((value) => hideProgressBar())
        .catchError(
      (error, stackTrace) {
        authError.value = error.toString();
        showErrorBar();
        Future.delayed(const Duration(seconds: 2)).then(
          (value) => hideProgressBar(),
        );
      },
    );
  }

  Future<void> getHotSales(bool isRefresh) async {
    showProgressBar();
    String keyword = '?page=1';

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
        .then((value) => hideProgressBar())
        .catchError(
      (error, stackTrace) {
        authError.value = error.toString();
        showErrorBar();
        Future.delayed(const Duration(seconds: 2)).then(
          (value) => hideProgressBar(),
        );
      },
    );
  }

  Future<void> getHotSalesFiltered(bool isRefresh,
      {bool isFilter = false,
      bool isSearch = false,
      String searchKeyword = '',
      String filterId = '',
      bool isOrdered = false,
      String ordering = 'regular_price'}) async {
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
                    {hotSalesFiltered.value = value, hotSalesIndex.value = 2}
                }
              else
                {hotSalesFiltered.addAll(value), hotSalesIndex.value++}
            })
        .then((value) => hideProgressBar())
        .catchError(
      (error, stackTrace) {
        authError.value = error.toString();
        showErrorBar();
        Future.delayed(const Duration(seconds: 2)).then(
          (value) => hideProgressBar(),
        );
      },
    );
  }

  Future<void> searchProducts(bool isRefresh,
      {bool isFilter = false,
      bool isSearch = false,
      String searchKeyword = '',
      String filterId = '',
      bool isOrdered = false,
      String ordering = 'regular_price'}) async {
    showProgressBar();
    if (isSearch || isOrdered || isFilter) {
      progressStatus.value = ProgressStatus.searching;
    }

    String keyword = '?page=${isRefresh ? 1 : allProductsSearchedIndex.value}';
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
        .then((value) => hideProgressBar())
        .catchError(
      (error, stackTrace) {
        authError.value = error.toString();
        showErrorBar();
        Future.delayed(const Duration(seconds: 2)).then(
          (value) => hideProgressBar(),
        );
      },
    );
  }

  Future<void> getAllProducts(bool isRefresh) async {
    showProgressBar();
    String keyword = '?page=1';

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
        .then((value) => hideProgressBar())
        .catchError(
      (error, stackTrace) {
        authError.value = error.toString();
        showErrorBar();
        Future.delayed(const Duration(seconds: 2)).then(
          (value) => hideProgressBar(),
        );
      },
    );
  }

  Future<void> getTips(bool isRefresh, bool isInitial) async {
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
        .then((value) => hideProgressBar())
        .catchError(
      (error, stackTrace) {
        authError.value = error.toString();
        showErrorBar();
        Future.delayed(const Duration(seconds: 2)).then(
          (value) => hideProgressBar(),
        );
      },
    );
  }

  Future<void> getAllProductsFiltered(bool isRefresh,
      {bool isFilter = false,
      bool isSearch = false,
      String searchKeyword = '',
      String filterId = '',
      bool isOrdered = false,
      String ordering = 'regular_price'}) async {
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
        .then((value) => hideProgressBar())
        .catchError(
      (error, stackTrace) {
        authError.value = error.toString();
        showErrorBar();
        Future.delayed(const Duration(seconds: 2)).then(
          (value) => hideProgressBar(),
        );
      },
    );
  }

  Future<bool> requestAddToCart(String name) async {
    TextEditingController quantityController =
        TextEditingController(text: counter.toString());

    try {
      final status = await CartRepository.addToCart(
              name.toString(), quantityController.text.trim());

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
