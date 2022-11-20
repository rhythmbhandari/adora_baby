import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../main.dart';
import '../../../config/constants.dart';

class WalkthroughController extends GetxController {
  final _currentIndex = 0.obs;

  incrementCurrentIndex() => _currentIndex.value++;

  onPageChange(int index) => _currentIndex.value = index;

  int get currentIndex => _currentIndex.value;

  callNextPage(pageController) {
    incrementCurrentIndex();
    pageController.animateToPage(currentIndex,
        duration: Duration(milliseconds: 800), curve: Curves.ease);
  }

  @override
  void onInit() {
    storage.writeData(Constants.WALK_THROUGH_STATE, 'yes');
    super.onInit();
  }
}
