import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:adora_baby/app/config/constants.dart';
import 'package:adora_baby/app/data/models/trending_images.dart';
import 'package:adora_baby/app/modules/shop/controllers/shop_controller.dart';

import 'package:get/get.dart';

import '../../widgets/custom_progress_bar.dart';
import '../network/dio_client.dart';
import '../network/network_helper.dart';

import '../models/hot_sales_model.dart';
import '../models/stages_brands.dart' as a;


import '../../utils/secure_storage.dart';
import 'package:http/http.dart' as http;


class ShopRepository {
  static Future<List<HotSales>> fetchHotSales() async {
    const url = '$BASE_URL/shops/hot_sale';

    final status = await DioHelper.getRequest(
      url,
      true,
      await SecureStorage.returnHeader(),
    );

    if (status is Map<dynamic, dynamic>) {
      List<HotSales> hotSales = (status['data'] as List)
          .map((i) => HotSales.fromJson(i))
          .toList();
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

  static Future<List<HotSales>> fetchAllProducts() async {
    const url = '$BASE_URL/shops/';

    final status = await DioHelper.getRequest(
      url,
      true,
      await SecureStorage.returnHeader(),
    );

    if (status is Map<dynamic, dynamic>) {
      List<HotSales> hotSales = (status['data'] as List)
          .map((i) => HotSales.fromJson(i))
          .toList();
      log('Reached here');
      return hotSales;
    }

    return Future.error('Error $status');
  }

  static Future<List<a.Datum>> brands() async {
    var url = '$BASE_URL/shop-categories?is_product_category=true';

    final response = await NetworkHelper().getRequest(url);

    final data = response.data;
    CustomProgressBar();
    if (response.statusCode == 200) {
      print("Response : ${response.data}");

      List<a.Datum> datas = (response.data["data"] as List)
          .map((i) => a.Datum.fromJson(i))
          .toList();
      return datas;
    } else {
      print(response.statusMessage);
      return Future.error(data['message']);
    }
  }

  static Future<List<a.Datum>> stages() async {
    var url = '$BASE_URL/shop-categories?is_product_category=false';

    final response = await NetworkHelper().getRequest(url);

    final data = response.data;

    if (response.statusCode == 200) {
      print("Response : ${response.data}");

      List<a.Datum> datas = (response.data["data"] as List)
          .map((i) => a.Datum.fromJson(i))
          .toList();
      return datas;
    } else {
      print(response.statusMessage);
      return Future.error(data['message']);
    }
  }

  static Future<List<a.Datum>> getHomeData() async {
    var url = '$BASE_URL/shops/home/';

    final response = await NetworkHelper().getRequest(url);

    final data = response.data;

    if (response.statusCode == 200) {
      print("Response : ${response.data}");

      List<a.Datum> datas = (response.data["data"] as List)
          .map((i) => a.Datum.fromJson(i))
          .toList();
      return datas;
    } else {
      print(response.statusMessage);
      return Future.error(data['message']);
    }
  }


  static Future<List<TrendingImages>> fetchTrendingImages() async {
    const url =
        '$baseUrl/trending-images/?is_active=true';
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
