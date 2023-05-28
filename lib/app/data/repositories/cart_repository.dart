import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:adora_baby/app/data/network/dio_client.dart';

import '../../config/constants.dart';

import '../../utils/secure_storage.dart';
import '../models/cart_model.dart';
import '../models/city_model.dart';
import '../network/network_helper.dart';

class CartRepository {
  static Future<bool> addToCart(String product, String quantity) async {
    const url = '$BASE_URL/cart/add_to_cart/';
    final body = jsonEncode({"product_id": product, "quantity": quantity});
    try {
      final response = await DioHelper.postRequest(
          url, body, false, await SecureStorage.returnHeaderWithToken());
      if (response) {
        return true;
      } else {
        return Future.error('Error');
      }
    } on SocketException {
      return Future.error(
          'Please check your internet connection and try again.');
    } catch (e) {
      return Future.error("$e");
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

  static Future<bool> postReview(
    String grade,
    String review,
    String product,
  ) async {
    const url = '$BASE_URL/rating/';
    final body =
        jsonEncode({"grade": grade, "review": review, "product": product});
    try {
      final response = await DioHelper.postRequest(
          url, body, false, await SecureStorage.returnHeaderWithToken());
      if (response) {
        return true;
      } else {
        return Future.error('Could not post review.');
      }
    } on SocketException {
      return Future.error(
          'Please check your internet connection and try again.');
    } catch (e) {
      return Future.error('$e');
    }
  }

  static Future<bool> deleteCart(List ofId) async {
    const url = '$BASE_URL/cart/delete/';
    final body = jsonEncode({
      "cart_id": ofId,
    });
    try {
      final response = await DioHelper.postRequest(
          url, body, false, await SecureStorage.returnHeaderWithToken());
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
      List<CartModel> cartList = (response.data["data"] as List)
          .map((i) => CartModel.fromJson(i))
          .toList();
      return cartList;
    } else {
      return Future.error(data['message']);
    }
  }

  static Future<List<Cities>> getCities() async {
    const url = '$BASE_URL/city/all/';

    final response = await DioHelper.getRequest(
        url, true, await SecureStorage.returnHeaderWithToken());

    if (response is Map<dynamic, dynamic>) {
      List<Cities> citiesList =
          (response["data"] as List).map((i) => Cities.fromJson(i)).toList();
      return citiesList;
    } else {
      return Future.error(response['message']);
    }
  }
}
