import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../config/constants.dart';


class StorageManager {
  FlutterSecureStorage flutterSecureStorage =
  const FlutterSecureStorage(iOptions: IOSOptions.defaultOptions);

  StorageManager() {}

  void writeData(key, data) {
    flutterSecureStorage.write(key: key, value: data);
  }

  Future<String?> readData(key) async {
    return await flutterSecureStorage.read(key: key);
  }

  Future delete(key) async {
    return await flutterSecureStorage.delete(key: key);
  }

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
  void saveCartId(cartId) {
    flutterSecureStorage.write(
      key: Constants.CART_ID,
      value: cartId,
    );
  }

  Future<String?> readCartId() async {
    return await flutterSecureStorage.read(
      key: Constants.CART_ID,
    );
  }
  void saveCityId(cityId) {
    flutterSecureStorage.write(
      key: Constants.CITY_ID,
      value: cityId,
    );
  }

  Future<String?> readCityId() async {
    return await flutterSecureStorage.read(
      key: Constants.CITY_ID,
    );
  }


}
