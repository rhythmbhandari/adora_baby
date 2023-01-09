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

  final progressStatus = ProgressStatus.IDLE.obs;

  @override
  void onInit() {
    fetchData();
    super.onInit();
  }

  final hotSalesIndex = 1.obs;

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
      getAllProducts(),
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
    await ShopRepository.fetchHotSales(isRefresh? 1 : hotSalesIndex.value)
        .then((value) => {
              if (isRefresh)
                {hotSales.value = value, hotSalesIndex.value = 2}
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

  Future<void> getAllProducts() async {
    showProgressBar();
    await ShopRepository.fetchAllProducts()
        .then(
          (value) => allProducts.value = value,
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
}
