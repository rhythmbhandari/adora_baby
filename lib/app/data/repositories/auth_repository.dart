import 'dart:convert';
import 'dart:io';

import 'package:adora_baby/app/config/constants.dart';
import 'package:get/get.dart';
import '../../../main.dart';
import 'package:http/http.dart' as http;

import '../../utils/secure_storage.dart';

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

  static Future<bool> resetPassword(String phoneNumber) async {
    const url = '$BASE_URL/accounts/request-reset-password/';
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

  static Future<bool> registerUserName(
      String fullName, String username, String password) async {
    const url = '$BASE_URL/accounts/signup/';
    final body = jsonEncode(
        {"full_name": fullName, "password": password, "username": username});
    try {
      final response = await http.post(Uri.parse(url),
          body: body, headers: await SecureStorage.returnHeaderWithToken());
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

  static Future<bool> registerBabyName(String fullName, String username,
      String password, String babyName, String dateOfBirth) async {
    const url = '$BASE_URL/accounts/signup/';
    print('Date of Birth $dateOfBirth');
    final body = jsonEncode({
      "full_name": fullName,
      "password": password,
      "username": username,
      "baby_name": babyName,
      "baby_dob": dateOfBirth
    });
    try {
      final response = await http.post(Uri.parse(url),
          body: body, headers: await SecureStorage.returnHeaderWithToken());
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

  static Future<bool> reset(String password) async {
    const url = '$BASE_URL/accounts/reset-password/';
    final body = {
      "password": password,
      "refresh_token": storage.readRefreshToken()
    };
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
        print(response.body);
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

  static Future<bool> verifyReset(String phoneNumber, String code) async {
    try {
      print('hereee');
      const url = '$BASE_URL/accounts/verify-reset-password/';
      final body = {"code": code, "phone_number": phoneNumber};
      print(body);

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

  static Future<bool> initiateLogin(String phoneNumber, String password) async {
    try {
      const url = '$BASE_URL/accounts/login/';
      final body = {"phone_number": phoneNumber, "password": password};

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

  static Future<List> fetchMedicalCategories() async {
    final babyMedicalCondition = [];

    String url = '$BASE_URL/MedicalCategories/';
    final response = await http.get(Uri.parse(url));
    print('Response is $response');
    var decodedResponse = jsonDecode(utf8.decode(response.bodyBytes)) as Map;
    if (response.statusCode == 200) {
      if ((decodedResponse["data"] as List).isNotEmpty) {
        for (var elements in (decodedResponse["data"] as List)) {
          babyMedicalCondition.add([
            [
              elements["name"],
            ],
            [
              for (var element in (elements['medicalcategories'] as List))
                element["name"],
            ],
            [
              for (var element in (elements['medicalcategories'] as List))
                element["id"],
            ]
          ]);
        }
        return babyMedicalCondition;
      } else {
        return [];
      }
    } else {
      return [];
    }
  }
}
