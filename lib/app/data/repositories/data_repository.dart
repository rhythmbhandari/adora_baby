import 'dart:convert';
import 'package:adora_baby/app/data/models/diamonds.dart';
import '../../config/constants.dart';
import '../../utils/secure_storage.dart';
import '../models/order_logs_model.dart';
import '../models/orders_model.dart';
import '../models/reviews.dart';
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
    if (status is Map<dynamic, dynamic>) {
      try {
        Users user = Users.fromJson(
          status['data'],
        );
        SessionManager.instance.setUser(
          user,
        );
        return true;
      } catch (e) {
        return false;
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
    if (status is Map<dynamic, dynamic>) {
      List<Orders> orders = (status['data'] as List)
          .map(
            (i) => Orders.fromJson(
              i,
            ),
          )
          .toList();
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
    if (status is Map<dynamic, dynamic>) {
      List<Diamonds> orders = (status['data'] as List)
          .map(
            (i) => Diamonds.fromJson(
              i,
            ),
          )
          .toList();
      return orders;
    }
    return Future.error('Server error.');
  }

  static Future<List<OrderLogsModel>> fetchOrderLogs(String orderId) async {
    final url = '$BASE_URL/order_logs/$orderId/get_order_logs/';

    final status = await DioHelper.getRequest(
      url,
      true,
      await SecureStorage.returnHeaderWithToken(),
    );
    if (status is List) {
      List<OrderLogsModel> orders = (status)
          .map(
            (i) => OrderLogsModel.fromJson(
          i,
        ),
      )
          .toList();
      return orders;
    }
    return Future.error('Server error.');
  }

  static Future<List<Reviews>> fetchReviews(String productId) async {
    final url = '$BASE_URL/rating/?product=$productId';

    final status = await DioHelper.getRequest(
      url,
      true,
      await SecureStorage.returnHeaderWithToken(),
    );
    if (status is Map<dynamic, dynamic>) {
      List<Reviews> review = (status['data'] as List)
          .map(
            (i) => Reviews.fromJson(
          i,
        ),
      )
          .toList();
      return review;
    }
    return Future.error('Could not fetch');
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
