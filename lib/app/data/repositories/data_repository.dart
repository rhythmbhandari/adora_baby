import 'dart:convert';
import 'dart:developer';

import 'package:adora_baby/app/data/models/diamonds.dart';

import '../../config/constants.dart';
import '../../utils/secure_storage.dart';
import '../models/orders_model.dart';
import '../models/user_model.dart';
import '../network/dio_client.dart';
import 'session_manager.dart';

class DataRepository {
  static Future<bool> fetchProfileDetail() async {
    const url = '$BASE_URL/accounts/me/';

    final status = await DioHelper.getRequest(
      url,
      true,
      await SecureStorage.returnHeaderWithToken(),
    );
    log('Status received is $status');
    if (status is Map<dynamic, dynamic>) {
      try {
        Users user = Users.fromJson(
          status['data'],
        );
        SessionManager.instance.setUser(
          user,
        );
        log('Reached here $user');
        return true;
      } catch (e) {
        log('Error is $e');
      }
    }
    return false;
  }

  static Future<bool> updateProfile(String body) async {
    const url = '$BASE_URL/accounts/me/';

    final status = await DioHelper.postRequest(
      url,
      body,
      false,
      await SecureStorage.returnHeaderWithToken(),
    );
    log('Status received is $status');
    if (status) {
      return true;
    }
    return false;
  }

  static Future<List<Orders>> fetchOrderList(String keyword) async {
    final url = '$BASE_URL/Order/$keyword';

    final status = await DioHelper.getRequest(
      url,
      true,
      await SecureStorage.returnHeaderWithToken(),
    );
    log('Status received is $status');
    if (status is Map<dynamic, dynamic>) {
      List<Orders> orders = (status['data'] as List)
          .map(
            (i) => Orders.fromJson(
              i,
            ),
          )
          .toList();
      log('Reached here $orders');
      return orders;
    }
    return Future.error('Server error.');
  }

  static Future<List<Diamonds>> fetchDiamonds(String keyword) async {
    final url = '$BASE_URL/dimond/$keyword';

    final status = await DioHelper.getRequest(
      url,
      true,
      await SecureStorage.returnHeaderWithToken(),
    );
    log('Status received is $status');
    if (status is Map<dynamic, dynamic>) {
      List<Diamonds> orders = (status['data'] as List)
          .map(
            (i) => Diamonds.fromJson(
              i,
            ),
          )
          .toList();
      log('Reached here $orders');
      return orders;
    }
    return Future.error('Server error.');
  }

  static Future<bool> cancel(String? id) async {
    final url = '$BASE_URL/Order/$id/';

    final status = await DioHelper.putRequest(
      url,
      json.encode({"status": "CANCELED"}),
      false,
      await SecureStorage.returnHeaderWithToken(),
    );
    if (status) {
      return true;
    }
    return false;
  }
}
