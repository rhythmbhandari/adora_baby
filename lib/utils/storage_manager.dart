import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../app/config/constants.dart';


class StorageManager {
  FlutterSecureStorage flutterSecureStorage =
  const FlutterSecureStorage(iOptions: IOSOptions.defaultOptions);

  StorageManager() {}

  void saveAccessToken(accessToken) {
    flutterSecureStorage.write(
      key: Constants.ACCESS_TOKEN,
      value: accessToken,
    );
  }

  Future<String?> readAccessToken() async {
    return await flutterSecureStorage.read(
      key: Constants.ACCESS_TOKEN,
    );
  }
  void saveRefreshToken(refreshToken) {
    flutterSecureStorage.write(
      key: Constants.REFRESH_TOKEN,
      value: refreshToken,
    );
  }

  Future<String?> readRefreshToken() async {
    return await flutterSecureStorage.read(
      key: Constants.REFRESH_TOKEN,
    );
  }


}
