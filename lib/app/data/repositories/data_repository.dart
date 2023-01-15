import 'dart:developer';

import '../../config/constants.dart';
import '../../utils/secure_storage.dart';
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
}
