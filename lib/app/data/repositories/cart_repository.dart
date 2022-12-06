import 'dart:convert';
import 'dart:io';

import '../../config/constants.dart';
import 'package:http/http.dart' as http;

import '../../utils/secure_storage.dart';

class CartRepository{
  static Future<bool> addToCart(
      String product, String quantity) async {
    const url = '$BASE_URL/cart/add_to_cart/';
    final body = jsonEncode(
        {"product": product,
          "quantity": quantity});
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

  static Future<bool> updateCart(
      String id, String quantity) async {
    const url = '$BASE_URL/cart/update_to_cart/';
    final body = jsonEncode(
        { "cart_id": id,
          "quantity": quantity});
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


  static Future<bool> deleteCart(
      String id) async {
    const url = '$BASE_URL/cart/delete/';
    final body = jsonEncode(
        { "cart_id": id,
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

}
