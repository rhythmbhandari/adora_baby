import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:adora_baby/app/config/constants.dart';
import 'package:adora_baby/app/data/models/get_address_model.dart';
import 'package:get/get.dart';
import '../../../main.dart';
import 'package:http/http.dart' as http;

import '../../utils/secure_storage.dart';
import '../models/get_city_model.dart' as c;
import '../models/get_single_order_model.dart';
import '../network/dio_client.dart';
import '../models/get_orders_model.dart' as o;

class CheckOutRepository {
  //personal info
  static Future<bool> checkout(String fullName, String phoneNumber,
      String altPhone, String address, String notes) async {
    const url = '$BASE_URL/checkout/';
    print("this is id ${await storage.readCartId()}");

    final body = jsonEncode({
      "cart": [await storage.readCartId()],
      "full_name": fullName,
      "phone_number": phoneNumber,
      "alt_phone_number": altPhone,
      "address": address,
      "special_notes": notes
    });

    try {
      final response = await http.post(Uri.parse(url),
          body: body, headers: await SecureStorage.returnHeaderWithToken());
      var decodedResponse = jsonDecode(utf8.decode(response.bodyBytes)) as Map;
      if (response.statusCode == 201) {
        print('Response is ${response.statusCode}.');
        return true;
      } else {
        print('Response is ${response.statusCode}.');

        return Future.error('${decodedResponse["error"]}');
      }
    } on SocketException {
      return Future.error(
          'Please check your internet connection and try again.');
    } catch (e) {
      return Future.error(e);
    }
  }

  static Future<List<Datum>> getAllCities() async {
    const url = '$BASE_URL/city/';
    final status = await DioHelper.getRequest(
      url,
      true,
      await SecureStorage.returnHeader(),
    );
    log('Status received is $status');
    if (status is Map<dynamic, dynamic>) {
      List<Datum> cities =
          (status['data'] as List).map((i) => Datum.fromJson(i)).toList();

      return cities;
    }

    return Future.error('Error $status');
  }

  static Future<List<Datum>> getAddress() async {
    const url = '$BASE_URL/address/';
    final status = await DioHelper.getRequest(
      url,
      true,
      await SecureStorage.returnHeader(),
    );
    log('Status received is $status');
    if (status is Map<dynamic, dynamic>) {
      List<Datum> address =
          (status['data'] as List).map((i) => Datum.fromJson(i)).toList();
      storage.saveCityId(address[0].city.id);

      return address;
    }

    return Future.error('Error $status');
  }

  //add address

  static Future<bool> updateAddress(
    String city,
    String landmark,
    String type,
  ) async {
    const url = '$BASE_URL/address/';
    final body = jsonEncode({
      "city": city,
      "nearest_landmark": landmark,
      "address_type": type,
    });
    try {
      final response = await http.post(Uri.parse(url),
          body: body, headers: await SecureStorage.returnHeaderWithToken());
      var decodedResponse = jsonDecode(utf8.decode(response.bodyBytes)) as Map;
      if (response.statusCode == 200) {
        print("working");
        print('Response is ${response.statusCode}.');
        return true;
      } else {
        return Future.error('${decodedResponse["error"]}');
      }
    } on SocketException {
      return Future.error(
          'Please check your internet connection and try again.');
    } catch (e) {
      return Future.error(e);
    }
  }

  static Future<bool> deleteAddress(String id) async {
    var url = '$BASE_URL/address/$id';

    try {
      final response = await http.post(Uri.parse(url),
          headers: await SecureStorage.returnHeaderWithToken());
      var decodedResponse = jsonDecode(utf8.decode(response.bodyBytes)) as Map;
      if (response.statusCode == 200) {
        print('Response is ${response.statusCode}.');
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

  static Future<bool> removeCheckout(String id) async {
    var url = '$BASE_URL/checkout/$id';

    try {
      final response = await http.post(Uri.parse(url),
          headers: await SecureStorage.returnHeaderWithToken());
      var decodedResponse = jsonDecode(utf8.decode(response.bodyBytes)) as Map;
      if (response.statusCode == 200) {
        print('Response is ${response.statusCode}.');
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

  //checkout
  static Future<bool> placeOrder(String id) async {
    var url = '$BASE_URL/Order/$id';

    final body = {"check_out": id};

    try {
      final response = await http.post(Uri.parse(url),
          body: body, headers: await SecureStorage.returnHeaderWithToken());
      var decodedResponse = jsonDecode(utf8.decode(response.bodyBytes)) as Map;
      if (response.statusCode == 200) {
        print('Response is ${response.statusCode}.');
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

  static Future<List<o.Datum>> getOrders() async {
    const url = '$BASE_URL/Order/';
    final status = await DioHelper.getRequest(
      url,
      true,
      await SecureStorage.returnHeader(),
    );
    log('Status received is $status');
    if (status is Map<dynamic, dynamic>) {
      List<o.Datum> orders =
          (status['data'] as List).map((i) => o.Datum.fromJson(i)).toList();

      return orders;
    }

    return Future.error('Error $status');
  }

  static Future<List<GetSingleOrder>> getSingleOrder(String id) async {
    var url = '$BASE_URL/Order/$id';
    final status = await DioHelper.getRequest(
      url,
      true,
      await SecureStorage.returnHeader(),
    );
    log('Status received is $status');
    if (status is Map<dynamic, dynamic>) {
      List<GetSingleOrder> singleOrder = (status['data'] as List)
          .map((i) => GetSingleOrder.fromJson(i))
          .toList();

      return singleOrder;
    }

    return Future.error('Error $status');
  }

  static Future<bool> updateCheckOut(bool a) async {
    String? id;
    var url = '$BASE_URL/checkout/${id!}';

    final body = {"is_diamond_use": a};

    try {
      final response = await http.put(Uri.parse(url),
          body: body, headers: await SecureStorage.returnHeaderWithToken());
      var decodedResponse = jsonDecode(utf8.decode(response.bodyBytes)) as Map;
      if (response.statusCode == 200) {
        print('Response is ${response.statusCode}.');
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
