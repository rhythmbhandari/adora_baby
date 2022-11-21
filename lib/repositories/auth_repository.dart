import 'dart:convert';
import 'dart:io';

import 'package:adora_baby/app/config/constants.dart';

import '../app/network/network_helper.dart';
import '../main.dart';
import '../utils/secure_storage.dart';
import 'package:http/http.dart' as http;

class AuthRepository {
  static Future<bool> requestOtp(String phoneNumber) async {
    const url = '$BASE_URL/accounts/otp_request/';
    final body = {"phone_number": phoneNumber};
    try {
      final response = await http.post(Uri.parse(url), body: body);
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

  static Future<bool> verifyOtp(String phoneNumber, String code) async {
    try {
      const url = '$BASE_URL/accounts/verify/';
      final body = {"phone_number": phoneNumber, "code": code};

      final response = await http.post(Uri.parse(url), body: body);
      var decodedResponse = jsonDecode(utf8.decode(response.bodyBytes)) as Map;
      if (response.statusCode == 200) {
        storage.saveAccessToken(decodedResponse["token"]["access"]);
        storage.saveRefreshToken(decodedResponse["token"]["refresh"]);
        print(decodedResponse["token"]["access"]);
        return true;
      } else {
        return Future.error('${decodedResponse["error"]}');
      }
    } on SocketException {
      return Future.error(
          'Please check your internet connection and try again.');
    } catch (e) {
      return Future.error('Unstable internet connection detected.');
    }
  }
}
