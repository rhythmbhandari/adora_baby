import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:adora_baby/app/config/constants.dart';
import 'package:adora_baby/app/data/models/trending_images.dart';
import 'package:adora_baby/app/modules/shop/controllers/shop_controller.dart';

import 'package:get/get.dart';

import '../../widgets/custom_progress_bar.dart';
import '../models/stages_brands.dart';
import '../models/tips_model.dart';
import '../network/dio_client.dart';
import '../network/network_helper.dart';

import '../models/hot_sales_model.dart';
import '../models/stages_brands.dart' as a;

import '../../utils/secure_storage.dart';
import 'package:http/http.dart' as http;

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
      hotSales.sort((a, b) {
        // Check if either productImages is null, treat it as having no featured image
        bool aHasFeatured =
            a.productImages?.any((pi) => pi?.isFeaturedImage ?? false) ?? false;
        bool bHasFeatured =
            b.productImages?.any((pi) => pi?.isFeaturedImage ?? false) ?? false;

        // Sort by whether there is a featured image, then by the name
        if (aHasFeatured && !bHasFeatured) {
          return -1;
        } else if (!aHasFeatured && bHasFeatured) {
          return 1;
        } else {
          return 0;
        }
      });

      log('Reached here');
      return hotSales;
    }

    return Future.error('Error $status');
  }

  static Future<List<HotSales>> fetchNotifications(String keyword) async {
    final url = '$BASE_URL/notification/$keyword';

    final status = await DioHelper.getRequest(
      url,
      true,
      await SecureStorage.returnHeader(),
    );

    if (status is Map<dynamic, dynamic>) {
      List<HotSales> hotSales =
          (status['data'] as List).map((i) => HotSales.fromJson(i)).toList();
      log('Reached here');
      return hotSales;
    }

    return Future.error('Error $status');
  }

  static Future<List<HotSales>> getIndividualProduct(String id) async {
    final url = '$BASE_URL/shops/$id';

    final response = await NetworkHelper().getRequest(url);

    final data = response.data;

    if (response.statusCode == 200) {
      print("Response : ${response.data}");

      List<HotSales> datas = (response.data["data"] as List)
          .map((i) => HotSales.fromJson(i))
          .toList();
      return datas;
    } else {
      print(response.statusMessage);
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
    log('Status received is $status');
    if (status is Map<dynamic, dynamic>) {
      List<HotSales> hotSales =
          (status['data'] as List).map((i) => HotSales.fromJson(i)).toList();
      log('Reached here $hotSales');
      return hotSales;
    }

    return Future.error('Error $status');
  }

  static Future<HotSales> fetchProduct(String id) async {
    final url = '$BASE_URL/shops/$id/';

    final status = await DioHelper.getRequest(
      url,
      true,
      await SecureStorage.returnHeader(),
    );
    log('Status received is $status');
    if (status is Map<String, dynamic>) {
      HotSales hotSale = HotSales.fromJson(
        status,
      );
      return hotSale;
    }

    return Future.error('Error $status');
  }

  static Future<List<Tips>> fetchTips(String keyword) async {
    final url = '$BASE_URL/tips/$keyword';

    final status = await DioHelper.getRequest(
      url,
      true,
      await SecureStorage.returnHeader(),
    );
    log('Status received is $status');
    if (status is Map<dynamic, dynamic>) {
      List<Tips> tips =
          (status['data'] as List).map((i) => Tips.fromJson(i)).toList();
      log('Reached here $tips');
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
    log('Status received is $status');
    if (status is Map<dynamic, dynamic>) {
      List<Filters> brands =
          (status['data'] as List).map((i) => Filters.fromJson(i)).toList();
      log('Reached here $brands');
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
    log('Status received is $status');
    if (status is Map<dynamic, dynamic>) {
      List<Filters> stages =
          (status['data'] as List).map((i) => Filters.fromJson(i)).toList();
      log('Reached here $stages');
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
