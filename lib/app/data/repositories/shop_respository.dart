import 'dart:convert';
import 'dart:io';

import 'package:adora_baby/app/config/constants.dart';
import 'package:adora_baby/app/modules/shop/controllers/shop_controller.dart';
import 'package:get/get.dart';

import '../network/network_helper.dart';

import '../models/hot_sales_model.dart';
import '../models/stages_brands.dart' as a;
import '../../utils/secure_storage.dart';


class ShopRepository {
  static Future<List<Datum>> hotSales() async {
    const url = '$BASE_URL/shops/hot_sale';

    final response = await NetworkHelper().getRequest(url
     );

    final data = response.data;

    if (response.statusCode == 200) {
      print("Response : ${response.data}");

      List<Datum> datas =
      (response.data["data"] as List)
          .map((i) => Datum.fromJson(i))
          .toList();
      return datas;
    } else {
      print(response.statusMessage);
      return Future.error(data['message']);
    }
  }
  static Future<List<a.Datum>> brands() async {


    var url = '$BASE_URL/shop-categories?is_product_category=true';

    final response = await NetworkHelper().getRequest(url
    );

    final data = response.data;

    if (response.statusCode == 200) {
      print("Response : ${response.data}");

      List<a.Datum> datas =
      (response.data["data"] as List)
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

    final response = await NetworkHelper().getRequest(url
    );

    final data = response.data;

    if (response.statusCode == 200) {
      print("Response : ${response.data}");

      List<a.Datum> datas =
      (response.data["data"] as List)
          .map((i) => a.Datum.fromJson(i))
          .toList();
      return datas;
    } else {
      print(response.statusMessage);
      return Future.error(data['message']);
    }
  }

}