import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import '../../../data/models/hot_sales_model.dart';
import '../../../data/repositories/shop_respository.dart';

class AllProductsController extends GetxController {
  final searchText = ''.obs;
  final selectedCategory = ''.obs;
  final selectedOrder = ''.obs;

  final pagingController = PagingController<int, HotSales>(
    firstPageKey: 0,
  );

  @override
  void onInit() {
    super.onInit();
    pagingController.addPageRequestListener((pageKey) {
      _fetchProducts(pageKey);
    });
  }

  Future<void> _fetchProducts(int pageKey) async {
    try {
      final products = await ShopRepository.fetchAllProductsNew(
        startIndex: pageKey,
        limit: 10,
        searchKeyword: searchText.value,
        categories: selectedCategory.value,
        ordering: selectedOrder.value,
      );
      final isLastPage = products.isEmpty;
      if (isLastPage) {
        pagingController.appendLastPage(products);
      } else {
        final nextPageKey = pageKey + 1;
        pagingController.appendPage(products, nextPageKey);
      }
    } catch (error) {
      pagingController.error = error;
    }
  }

  void onSearch(String value) {
    searchText.value = value;
    pagingController.refresh();
  }

  void onCategorySelect(String value) {
    selectedCategory.value = value;
    pagingController.refresh();
  }

  void onOrderSelect(String value) {
    selectedOrder.value = value;
    pagingController.refresh();
  }

  @override
  void onClose() {
    pagingController.dispose();
    super.onClose();
  }
}
