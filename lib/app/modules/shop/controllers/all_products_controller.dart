
import 'package:adora_baby/app/modules/shop/enums/all_filters_enum.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import '../../../data/models/hot_sales_model.dart';
import '../../../data/repositories/shop_respository.dart';

class AllProductsController extends GetxController {
  String url;

  AllProductsController({this.url = 'shop/hot_sale'});

  final searchText = ''.obs;
  final selectedStages = '9-9..'.obs;
  final selectedFilter = Rx<AllFilters>(AllFilters.high);

  final pagingController = PagingController<int, HotSales>(
    firstPageKey: 1,
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
        categories: selectedStages.value == '9-9..' ? '': selectedStages.value,
        ordering: selectedFilter.value.filterSend,
        url: url,
      );
      final isLastPage = products.isEmpty;
      if (isLastPage) {
        pagingController.appendLastPage(products);
      } else {
        final nextPageKey = pageKey + 1;
        pagingController.appendPage(products, nextPageKey);
      }
    } catch (error) {
      if(error.toString().contains('Invalid page')){
        pagingController.appendLastPage([]);
      }else{
        pagingController.error = error;
      }
    }
  }

  void onSearch(String value) {
    searchText.value = value;
    pagingController.refresh();
  }

  void onCategorySelect(String value) {
    selectedStages.value = value;
    pagingController.refresh();
  }

  void onOrderSelect() {
    pagingController.refresh();
  }

  @override
  void onClose() {
    pagingController.dispose();
    super.onClose();
  }
}
