import 'dart:developer';

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
      Users user = Users.fromJson(
        status['data'],
      );
      SessionManager.instance.setUser(
        user,
      );
      log('Reached here $user');
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
}
