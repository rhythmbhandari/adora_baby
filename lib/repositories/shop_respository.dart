import 'dart:convert';
import 'dart:io';

import 'package:adora_baby/app/config/constants.dart';

import '../app/network/network_helper.dart';

import '../models/hot_sales_model.dart';
import '../utils/secure_storage.dart';


class ShopRepository {
  static Future<dynamic> hotSales() async {
    const url = '$BASE_URL/shops/hot_sale';

    final response = await NetworkHelper().getRequest(url,
        contentType: await SecureStorage.returnHeaderWithToken());
    print('Token is ${await SecureStorage.returnHeaderWithToken()}');
    final data = response.data;
    print(data);
    if (response.statusCode == 200) {
      print("Response : ${response.data}");


      return Hot.fromJson(response.data);
    } else {
      print(response.statusMessage);
      return Future.error(data['message']);
    }
  }

}