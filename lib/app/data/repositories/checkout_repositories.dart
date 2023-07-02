import 'dart:convert';
import 'dart:io';

import 'package:adora_baby/app/config/constants.dart';
import 'package:adora_baby/app/data/models/checkout_model.dart';
import 'package:adora_baby/app/data/models/get_address_model.dart';
import 'package:flutter/material.dart';
import '../../../main.dart';
import 'package:http/http.dart' as http;

import '../../utils/secure_storage.dart';
import '../models/get_single_order_model.dart';
import '../network/dio_client.dart';
import '../models/get_orders_model.dart' as o;

class CheckOutRepository {
  static Future<CheckoutModel> checkout(String fullName, String phoneNumber,
      String altPhone, String address, String notes, List cartList) async {
    const url = '$BASE_URL/checkout/';

    final body = jsonEncode({
      "cart": cartList,
      "full_name": fullName,
      "phone_number": phoneNumber,
      "alt_phone_number": altPhone,
      "address": address,
      "special_notes": notes
    });

    try {
      final response = await DioHelper.postRequest(
          url, body, true, await SecureStorage.returnHeaderWithToken());
      if (response is Map<String, dynamic>) {
        CheckoutModel checkoutModel = CheckoutModel.fromJson(
          response,
        );

        return checkoutModel;
      } else {
        return Future.error('$response');
      }
    } on SocketException {
      return Future.error(
          'Please check your internet connection and try again.');
    } catch (e) {

      return Future.error('${e.toString() == 'P'? 'Server Error. Please contact support': e}');    }
  }

  static Future<List<AddressModel>> getAllCities() async {
    const url = '$BASE_URL/city/';
    final status = await DioHelper.getRequest(
      url,
      true,
      await SecureStorage.returnHeader(),
    );
    if (status is Map<dynamic, dynamic>) {
      List<AddressModel> cities = (status['data'] as List)
          .map((i) => AddressModel.fromJson(i))
          .toList();

      return cities;
    }

    return Future.error('Error $status');
  }

  static Future<List<AddressModel>> getAddress() async {
    try {
      const url = '$BASE_URL/address/';
      final status = await DioHelper.getRequest(
        url,
        true,
        await SecureStorage.returnHeaderWithToken(),
      );
      if (status is Map<dynamic, dynamic>) {
        List<AddressModel> address = (status['data'] as List)
            .map((i) => AddressModel.fromJson(i))
            .toList();
        storage.saveCityId(address[0].city.id);
        return address;
      }
      return [];
    } catch (e) {

      return Future.error('${e.toString() == 'P'? 'Server Error. Please contact support': e}');    }
  }

  //add address

  static Future<bool> addAddress(
      String addressName, String city, String landmark, bool isPrimary) async {
    const url = '$BASE_URL/address/';
    final body = jsonEncode({
      "address_type": isPrimary ? 'PRIMARY' : 'SECONDARY',
      "city": city,
      "nearest_landmark": landmark.characters.take(49).toString(),
      "address": addressName,
    });
    try {
      final response = await DioHelper.postRequest(
          url, body, false, await SecureStorage.returnHeaderWithToken());
      if (response) {
        return true;
      } else {
        return Future.error('Error $response');
      }
    } on SocketException {
      return Future.error(
          'Please check your internet connection and try again.');
    } catch (e) {

      return Future.error('${e.toString() == 'P'? 'Server Error. Please contact support': e}');    }
  }

  static Future<bool> updateAddress(
    String addressName,
    String city,
    String landmark,
    bool isPrimary,
    String id,
  ) async {
    final url = '$BASE_URL/address/$id/';
    final body = jsonEncode({
      "address_type": isPrimary ? 'PRIMARY' : 'SECONDARY',
      "city": city,
      "nearest_landmark": landmark.characters.take(49).toString(),
      "address": addressName,
    });
    try {
      final response = await DioHelper.putRequest(
          url, body, false, await SecureStorage.returnHeaderWithToken());
      if (response) {
        return true;
      } else {
        return Future.error('Error $response');
      }
    } on SocketException {
      return Future.error(
          'Please check your internet connection and try again.');
    } catch (e) {

      return Future.error('${e.toString() == 'P'? 'Server Error. Please contact support': e}');    }
  }

  static Future<bool> deleteAddress(String id) async {
    var url = '$BASE_URL/address/$id';

    try {
      final response = await http.post(Uri.parse(url),
          headers: await SecureStorage.returnHeaderWithToken());
      var decodedResponse = jsonDecode(utf8.decode(response.bodyBytes)) as Map;
      if (response.statusCode == 200) {
        return true;
      } else {
        return Future.error(
            '${decodedResponse["error"] ?? decodedResponse["detail"] ?? 'Server Error'}');
      }
    } on SocketException {
      return Future.error(
          'Please check your internet connection and try again.');
    } catch (e) {

      return Future.error('${e.toString() == 'P'? 'Server Error. Please contact support': e}');    }
  }



  //checkout
  static Future<bool> placeOrder(String id) async {
    var url = '$BASE_URL/Order/';

    final body = {"check_out": id};

    try {
      final response = await DioHelper.postRequest(
          url, body, false, await SecureStorage.returnHeaderWithToken());
      if (response) {
        return true;
      } else {
        return Future.error('$response');
      }
    } on SocketException {
      return Future.error(
          'Please check your internet connection and try again.');
    } catch (e) {

      return Future.error('${e.toString() == 'P'? 'Server Error. Please contact support': e}');    }
  }


  static Future<CheckoutModel> updateCheckOut(
      String id, bool isDiamondUsed, String couponApplied) async {
    var url = '$BASE_URL/checkout/$id/';

    final body = {"is_dimond_use": isDiamondUsed, "coupon_code": couponApplied};

    try {
      final response = await DioHelper.putRequest(
          url, body, true, await SecureStorage.returnHeaderWithToken());
      if (response is Map<String, dynamic>) {
        CheckoutModel checkoutModel = CheckoutModel.fromJson(
          response,
        );
        return checkoutModel;
      } else {
        return Future.error('$response');
      }
    } on SocketException {
      return Future.error(
          'Please check your internet connection and try again.');
    } catch (e) {

      return Future.error('${e.toString() == 'P'? 'Server Error. Please contact support': e}');    }
  }
}
