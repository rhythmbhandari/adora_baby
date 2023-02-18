import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:adora_baby/app/data/models/stages_brands.dart';
import 'package:adora_baby/app/data/models/get_carts_model.dart' as a;
import 'package:adora_baby/app/data/network/dio_client.dart';
import 'package:adora_baby/app/widgets/custom_progress_bar.dart';
import 'package:adora_baby/app/widgets/shimmer_widget.dart';
import 'package:adora_baby/main.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../config/app_colors.dart';
import '../../config/constants.dart';
import 'package:http/http.dart' as http;

import '../../utils/secure_storage.dart';
import '../models/cart_model.dart';
import '../models/city_model.dart';
import '../network/network_helper.dart';

class CartRepository {
  static Future<bool> addToCart(String product, String quantity) async {
    const url = '$BASE_URL/cart/add_to_cart/';
    final body = jsonEncode({"product_id": product, "quantity": quantity});
    print(await SecureStorage.returnHeaderWithToken());
    try {
      final response = await http.post(Uri.parse(url),
          body: body, headers: await SecureStorage.returnHeaderWithToken());

      if (response.statusCode == 200) {
        print('Response is $response');
        return true;
      } else {
        print(response.statusCode);

        return Future.error(response.statusCode);
      }
    } on SocketException {
      return Future.error(
          'Please check your internet connection and try again.');
    } catch (e) {
      return Future.error("Exception");
    }
  }

  static Future<bool> updateCart(String id, int quantity) async {
    const url = '$BASE_URL/cart/update_to_cart/';
    final body = jsonEncode({"cart_id": id, "quantity": quantity});
    try {
      final response = await DioHelper.postRequest(
          url, body, false, await SecureStorage.returnHeaderWithToken());
      if (response) {
        return true;
      } else {
        return Future.error('Could not update cart.');
      }
    } on SocketException {
      return Future.error(
          'Please check your internet connection and try again.');
    } catch (e) {
      return Future.error(
          'Please check your internet connection and try again.');
    }
  }

  static Future<bool> deleteCart(String id) async {
    const url = '$BASE_URL/cart/delete/';
    final body = jsonEncode({
      "cart_id": id,
    });
    try {
      final response = await DioHelper.postRequest(url,
          body, false, await SecureStorage.returnHeaderWithToken());
      if (response) {
        return true;
      } else {
        return Future.error(response);
      }
    } on SocketException {
      return Future.error(
          'Please check your internet connection and try again.');
    } catch (e) {
      return Future.error(
          'Please check your internet connection and try again.');
    }
  }

  static Future<List<CartModel>> getCart() async {
    const url = '$BASE_URL/cart/';

    final response = await NetworkHelper().getRequest(url,
        contentType: await SecureStorage.returnHeaderWithToken());

    final data = response.data;

    if (response.statusCode == 200) {
      log("Response : ${response.data}");
      List<CartModel> cartList = (response.data["data"] as List)
          .map((i) => CartModel.fromJson(i))
          .toList();
      return cartList;
    } else {
      log(response.statusMessage ?? '');
      return Future.error(data['message']);
    }
  }

  static Future<List<Cities>> getCities() async {
    const url = '$BASE_URL/city/';

    final response = await NetworkHelper().getRequest(url,
        contentType: await SecureStorage.returnHeaderWithToken());

    final data = response.data;

    if (response.statusCode == 200) {
      log("Response : ${response.data}");
      List<Cities> citiesList = (response.data["data"] as List)
          .map((i) => Cities.fromJson(i))
          .toList();
      return citiesList;
    } else {
      log(response.statusMessage ?? '');
      return Future.error(data['message']);
    }
  }
}
