import 'dart:convert';
import 'dart:io';

import 'package:adora_baby/app/config/constants.dart';

import '../app/network/network_helper.dart';
import '../main.dart';
import '../utils/secure_storage.dart';

class AuthRepository {
  static Future<bool> requestOtp(String phoneNumber) async {
    const url = '$BASE_URL/accounts/otp_request/';
    final body = jsonEncode({ "phone_number": phoneNumber});
    try {
      final response = await NetworkHelper().postRequest(url, data: body);

      if (response.statusCode == 200) {
        print('Response is $response');

        return true;
      } else if (response.statusCode == 401) {
        return Future.error('Entered phone does not exist. Please check again.');
      }  else if (response.statusMessage == null) {
        return Future.error(
            'Cannot connect with server. Please use a stable internet connection.');
      } else {
        return Future.error(
            'Please check your internet connection and try again.');
      }
    } on SocketException {
      return Future.error(
          'Please check your internet connection and try again.');
    } catch (e) {
      return Future.error(
          'Please check your internet connection and try again.');
    }
  }
  static Future<bool> verifyOtp(String phoneNumber,String code) async {
    try {

        const url = '$BASE_URL/accounts/verify/';
        final body = jsonEncode({"phone_number": phoneNumber,
          "code": code});

        final response = await NetworkHelper().postRequest(url, data: body);
        print('Response is $response');
        if (response.statusCode == 200) {
          storage.saveAccessToken(response.data["token"] ["access"]);
          storage.saveRefreshToken(response.data["token"] ["refresh"]);
          print(response.data["token"] ["access"]);
          print(response);
          print(response.statusCode);

          return true;
        } else {
          print(response.statusCode);
          return Future.error('Incorrect Otp.');
        }

    } on SocketException {
      return Future.error(
          'Please check your internet connection and try again.');
    } catch (e) {
      return Future.error('Unstable internet connection detected.');
    }
  }

}