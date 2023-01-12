import 'dart:convert';
import 'dart:io';

import 'package:adora_baby/app/data/models/stages_brands.dart';
import 'package:adora_baby/app/data/models/get_carts_model.dart' as a;

import '../../config/constants.dart';
import 'package:http/http.dart' as http;

import '../../utils/secure_storage.dart';
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

  static Future<bool> updateCart(String id, String quantity) async {
    const url = '$BASE_URL/cart/update_to_cart/';
    final body = jsonEncode({"cart_id": id, "quantity": quantity});
    try {
      final response = await http.post(Uri.parse(url),
          body: body, headers: await SecureStorage.returnHeaderWithToken());
      var decodedResponse = jsonDecode(utf8.decode(response.bodyBytes)) as Map;
      if (response.statusCode == 200) {
        print('Response is $response');
        return true;
      } else {
        return Future.error('${decodedResponse["error"]}');
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
      final response = await http.post(Uri.parse(url),
          body: body, headers: await SecureStorage.returnHeaderWithToken());
      var decodedResponse = jsonDecode(utf8.decode(response.bodyBytes)) as Map;
      if (response.statusCode == 200) {
        print('Response is $response');
        return true;
      } else {
        return Future.error('${decodedResponse["error"]}');
      }
    } on SocketException {
      return Future.error(
          'Please check your internet connection and try again.');
    } catch (e) {
      return Future.error(
          'Please check your internet connection and try again.');
    }
  }
  static Future<List<a.Datum>> getCart() async {
    print(await SecureStorage.returnHeaderWithToken());
    const url = '$BASE_URL/cart/';

    final response = await NetworkHelper().getRequest(url, contentType: await SecureStorage.returnHeaderWithToken());

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
}
