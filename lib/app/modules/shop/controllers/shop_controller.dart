import 'dart:io';

import 'package:adora_baby/app/config/app_theme.dart';
import 'package:adora_baby/app/data/repositories/shop_respository.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../main.dart';
import '../../../data/models/stages_brands.dart';
import '../../../widgets/buttons.dart';
import '../../../widgets/radio_buttons.dart';
import '../../../enums/progress_status.dart';

class ShopController extends GetxController {
  var stagesValue = "true".obs;
  var allStages = "false";
  var supportedSitter = "true";
  var crawler = "crawler";
  var toddler = "toddler";
  final isSelected = false.obs;
  final authError = ''.obs;
  final trendingImagesList = [].obs;

  final hotSales = [].obs;

  final allProducts = [].obs;

  final allProductsFiltered = [].obs;
  final hotSalesFiltered = [].obs;

  final progressStatus = ProgressStatus.IDLE.obs;

  final TextEditingController searchController = TextEditingController();

  @override
  void onInit() {
    fetchData();
    super.onInit();
  }

  final hotSalesIndex = 1.obs;
  final allProductsIndex = 1.obs;

  showProgressBar() => progressStatus.value = ProgressStatus.LOADING;

  hideProgressBar() => progressStatus.value = ProgressStatus.IDLE;

  showErrorBar() => progressStatus.value = ProgressStatus.ERROR;

  hideErrorBar() => progressStatus.value = ProgressStatus.IDLE;

  showAlertDialog(BuildContext context) {
    // Create AlertDialog
    showGeneralDialog(
      context: context,
      barrierColor: Colors.black.withOpacity(0.5),
      pageBuilder: (_, __, ___) {
        return Material(
          color: Colors.transparent,
          child: Center(
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(20)),
              padding: const EdgeInsets.only(top: 20, bottom: 20),
              width: double.infinity,
              // Dialog background
              // Dialog height
              child: SingleChildScrollView(
                child: Column(children: [
                  Obx(() => RadioButtonWidget<String>(
                      value: allStages,
                      groupValue: stagesValue.value,
                      leading: '',
                      title: Text('All Stages',
                          style: kThemeData.textTheme.bodyLarge),
                      onChanged: (value) {
                        FocusScopeNode currentFocus = FocusScope.of(context);
                        if (!currentFocus.hasPrimaryFocus) {
                          currentFocus.unfocus();
                        }

                        stagesValue.value = value.toString();
                        print(value);
                      })),
                  Obx(() => RadioButtonWidget<String>(
                      value: supportedSitter,
                      groupValue: stagesValue.value,
                      leading: '',
                      title: Text('Supported Sitter',
                          style: kThemeData.textTheme.bodyLarge),
                      onChanged: (value) {
                        FocusScopeNode currentFocus = FocusScope.of(context);
                        if (!currentFocus.hasPrimaryFocus) {
                          currentFocus.unfocus();
                        }
                        print(value);

                        stagesValue.value = value.toString();
                      })),
                  Obx(() => RadioButtonWidget<String>(
                      value: crawler,
                      groupValue: stagesValue.value,
                      leading: '',
                      title: Text('Crawler',
                          style: kThemeData.textTheme.bodyLarge),
                      onChanged: (value) {
                        FocusScopeNode currentFocus = FocusScope.of(context);
                        if (!currentFocus.hasPrimaryFocus) {
                          currentFocus.unfocus();
                        }
                        print(value);

                        stagesValue.value = value.toString();
                      })),
                  Obx(() => RadioButtonWidget<String>(
                      value: toddler,
                      groupValue: stagesValue.value,
                      leading: '',
                      title: Text('Toddler',
                          style: kThemeData.textTheme.bodyLarge),
                      onChanged: (value) {
                        FocusScopeNode currentFocus = FocusScope.of(context);
                        if (!currentFocus.hasPrimaryFocus) {
                          currentFocus.unfocus();
                        }
                        print(value);

                        stagesValue.value = value.toString();
                      })),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: ButtonsWidget(
                      name: 'APPLY FILTER',
                      onPressed: () {
                        ShopRepository.stages();
                      },
                    ),
                  )
                ]),
              ),
            ),
          ),
        );
      },
    ).then((value) => Get.back());
  }

  Future<void> fetchData() async {
    await Future.wait([
      getTrendingImages(),
      getHotSales(true),
      getAllProducts(true),
    ]);
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
        Future.delayed(const Duration(seconds: 5)).then(
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
        Future.delayed(const Duration(seconds: 5)).then(
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
      progressStatus.value = ProgressStatus.SEARCHING;
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
        Future.delayed(const Duration(seconds: 5)).then(
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
        Future.delayed(const Duration(seconds: 5)).then(
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
      progressStatus.value = ProgressStatus.SEARCHING;
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
        Future.delayed(const Duration(seconds: 5)).then(
          (value) => hideProgressBar(),
        );
      },
    );
  }
}
