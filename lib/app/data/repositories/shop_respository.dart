import 'dart:developer';

import 'package:adora_baby/app/config/constants.dart';
import 'package:adora_baby/app/data/models/trending_images.dart';
import '../models/stages_brands.dart';
import '../models/tips_model.dart';
import '../network/dio_client.dart';
import '../network/network_helper.dart';
import '../models/hot_sales_model.dart';
import '../../utils/secure_storage.dart';

class ShopRepository {
  static Future<List<HotSales>> fetchHotSales(String keyword) async {
    final url = '$BASE_URL/shops/hot_sale/$keyword';

    final status = await DioHelper.getRequest(
      url,
      true,
      await SecureStorage.returnHeader(),
    );

    if (status is Map<dynamic, dynamic>) {
      List<HotSales> hotSales =
          (status['data'] as List).map((i) => HotSales.fromJson(i)).toList();
      // bool isFeaturedImage(ProductImage? image) {
      //   return image?.isFeaturedImage == true;
      // }
      //
      // for (var hotSale in hotSales) {
      //   hotSale.productImages?.sort((a, b) {
      //     bool isFeaturedImageA = isFeaturedImage(a);
      //     bool isFeaturedImageB = isFeaturedImage(b);
      //
      //     if (isFeaturedImageA && !isFeaturedImageB) {
      //       return -1;
      //     } else if (!isFeaturedImageA && isFeaturedImageB) {
      //       return 1;
      //     }
      //
      //     return (hotSale.productImages?.indexOf(a) ?? 0)
      //         .compareTo(hotSale.productImages?.indexOf(b) ?? 0);
      //   });
      // }

      hotSales.forEach((hotSale) {
        hotSale.productImages = sortProductImages(hotSale.productImages);
      });
      return hotSales;
    }

    return Future.error('Error $status');
  }

  static bool isFeaturedImage(ProductImage? image) {
    return image?.isFeaturedImage == true;
  }

  static List<ProductImage?>? sortProductImages(List<ProductImage?>? images) {
    if (images == null || images.isEmpty) {
      return images;
    }

    List<ProductImage?> featuredImages = [];
    List<ProductImage?> nonFeaturedImages = [];

    for (var image in images) {
      if (isFeaturedImage(image)) {
        featuredImages.add(image);
      } else {
        nonFeaturedImages.add(image);
      }
    }

    return [...featuredImages, ...nonFeaturedImages];
  }

  static Future<List<HotSales>> fetchNotifications(String keyword) async {
    final url = '$BASE_URL/notification/$keyword';

    final status = await DioHelper.getRequest(
      url,
      true,
      await SecureStorage.returnHeaderWithToken(),
    );

    if (status is Map<dynamic, dynamic>) {
      List<HotSales> hotSales =
          (status['data'] as List).map((i) => HotSales.fromJson(i)).toList();
      hotSales.forEach((hotSale) {
        hotSale.productImages = sortProductImages(hotSale.productImages);
      });
      return hotSales;
    }

    return Future.error('Error $status');
  }

  static Future<List<HotSales>> getIndividualProduct(String id) async {
    final url = '$BASE_URL/shops/$id';

    final response = await NetworkHelper().getRequest(url);

    final data = response.data;

    if (response.statusCode == 200) {
      List<HotSales> hotSales = (response.data["data"] as List)
          .map((i) => HotSales.fromJson(i))
          .toList();
      hotSales.forEach((hotSale) {
        hotSale.productImages = sortProductImages(hotSale.productImages);
      });
      return hotSales;
    } else {
      return Future.error(data['message']);
    }
  }

  static Future<List<HotSales>> fetchAllProducts(String keyword) async {
    final url = '$BASE_URL/shops/$keyword';

    final status = await DioHelper.getRequest(
      url,
      true,
      await SecureStorage.returnHeader(),
    );
    if (status is Map<dynamic, dynamic>) {
      List<HotSales> hotSales =
          (status['data'] as List).map((i) => HotSales.fromJson(i)).toList();
      hotSales.forEach((hotSale) {
        hotSale.productImages = sortProductImages(hotSale.productImages);
      });
      return hotSales;
    }

    return Future.error('Error $status');
  }

  static Future<HotSales> fetchIndividualProduct(String id) async {
    final url = '$BASE_URL/shops/$id/';

    final status = await DioHelper.getRequest(
      url,
      true,
      await SecureStorage.returnHeader(),
    );
    if (status is Map<String, dynamic>) {
      HotSales hotSale = HotSales.fromJson(
        status,
      );
      return hotSale;
    }

    return Future.error('Error $status');
  }

  static Future<List<HotSales>> fetchAllProductsNew({
    required int startIndex,
    required int limit,
    required String searchKeyword,
    required String categories,
    required String ordering,
    required String url,
  }) async {
    try {
      final queryParameters = {
        if (searchKeyword.isNotEmpty) 'search': searchKeyword,
        if (categories.isNotEmpty) 'categories': categories,
        if (ordering.isNotEmpty) 'ordering': ordering,
        'page': startIndex.toString(),
        'limit': limit.toString(),
      };

      // final uri = "https://f3ec-27-34-51-137.ngrok-free.app/api/v1/search/?search=$searchKeyword";
      //
      final uri = '$BASE_URL/$url/${Uri(queryParameters: queryParameters)}';

      final status = await DioHelper.getRequest(
        uri,
        true,
        await SecureStorage.returnHeader(),
      );

      if (status is Map<dynamic, dynamic>) {
        List<HotSales> hotSales =
            (status['data'] as List).map((i) => HotSales.fromJson(i)).toList();
        hotSales.forEach((hotSale) {
          hotSale.productImages = sortProductImages(hotSale.productImages);
        });
        return hotSales;
      } else {
        return Future.error('$status');
      }
    } catch (e) {
      return Future.error(
          '${e.toString() == 'P' ? 'Server Error. Please contact support' : e}');
    }
  }

  static Future<List<Tips>> fetchTips(String keyword) async {
    final url = '$BASE_URL/tips/$keyword';

    final status = await DioHelper.getRequest(
      url,
      true,
      await SecureStorage.returnHeaderWithToken(),
    );
    if (status is Map<dynamic, dynamic>) {
      List<Tips> tips =
          (status['data'] as List).map((i) => Tips.fromJson(i)).toList();
      return tips;
    }

    return Future.error('Error $status');
  }

  static Future<List<Filters>> fetchBrands() async {
    const url = '$BASE_URL/shop-categories?is_product_category=true';

    final status = await DioHelper.getRequest(
      url,
      true,
      await SecureStorage.returnHeader(),
    );
    if (status is Map<dynamic, dynamic>) {
      List<Filters> brands =
          (status['data'] as List).map((i) => Filters.fromJson(i)).toList();
      return brands;
    }

    return Future.error('Error $status');
  }

  static Future<List<Filters>> fetchStages() async {
    const url = '$BASE_URL/shop-categories?is_product_category=false';

    final status = await DioHelper.getRequest(
      url,
      true,
      await SecureStorage.returnHeader(),
    );
    if (status is Map<dynamic, dynamic>) {
      List<Filters> stages =
          (status['data'] as List).map((i) => Filters.fromJson(i)).toList();
      stages.insert(
        0,
        Filters(id: '9-9..', name: 'All Stages'),
      );
      return stages;
    }

    return Future.error('Error $status');
  }

  static Future<List<TrendingImages>> fetchTrendingImages() async {
    const url = '$baseUrl/trending-images/?is_active=true';
    final status = await DioHelper.getRequest(
      url,
      true,
      await SecureStorage.returnHeader(),
    );

    if (status is Map<dynamic, dynamic>) {
      List<TrendingImages> trendingImages = (status['data'] as List)
          .map((i) => TrendingImages.fromJson(i))
          .toList();
      return trendingImages;
    }

    return Future.error('Error $status');
  }
}
