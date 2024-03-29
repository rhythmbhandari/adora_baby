import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:adora_baby/app/config/constants.dart';
import 'package:dio_smart_retry/dio_smart_retry.dart';
import 'package:get/get.dart';
import 'package:http_parser/http_parser.dart';
import '../../../main.dart';
import 'package:dio/dio.dart' as d;

import 'package:http/http.dart' as http;

import '../../utils/secure_storage.dart';
import '../network/dio_client.dart';

class AuthRepository {
  static Future<bool> requestOtp(String phoneNumber) async {
    const url = '$BASE_URL/accounts/otp_request/';
    final body = {"phone_number": phoneNumber};
    try {
      final response = await http.post(Uri.parse(url), body: body);
      var decodedResponse = jsonDecode(utf8.decode(response.bodyBytes)) as Map;
      log('Message is received $decodedResponse');
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
      return Future.error('Server Error');
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

  static Future<bool> updateMedicalCondition(
      String description, List medicalConditions) async {
    const url = '$BASE_URL/medical/';
    final body = jsonEncode(
        {"description": description, "MedicalCondition": medicalConditions});
    try {
      final response = await http.post(Uri.parse(url),
          body: body, headers: await SecureStorage.returnHeaderWithToken());
      var decodedResponse = jsonDecode(utf8.decode(response.bodyBytes)) as Map;
      if (response.statusCode == 201) {
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

  static Future<bool> updatePhoto(File image, String pictureOf) async {
    const url = '$BASE_URL/profile/profile/';
    String? fileName;

    if (image != null) {
      fileName = image.path.split('/').last;
    }

    final body = d.FormData.fromMap({
      'picture_off': pictureOf,
      'name': image == null
          ? null
          : MultipartFileRecreatable.fromFileSync(image.path,
              contentType: MediaType('image', 'jpg'), filename: fileName),
    });
    try {
      final status = await DioHelper.postRequest(
        url,
        body,
        true,
        await SecureStorage.returnHeaderWithMultipartToken(),
      );
      if (status) {
        return true;
      } else {
        return false;
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
    const url = '$BASE_URL/accounts/me/';
    print('Date of Birth $dateOfBirth');
    final body = jsonEncode({"baby_name": babyName, "baby_dob": dateOfBirth});
    print({"baby_name": babyName, "baby_dob": dateOfBirth});
    try {
      final response = await http.post(Uri.parse(url),
          body: body, headers: await SecureStorage.returnHeaderWithToken());
      var decodedResponse = jsonDecode(utf8.decode(response.bodyBytes)) as Map;
      print('Decoded response is $decodedResponse');
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
    final body = jsonEncode({
      "password": password,
      "refresh_token": await storage.readRefreshToken()
    });
    print({
      "password": password,
      "refresh_token": await storage.readRefreshToken()
    });
    try {
      final response = await http.post(Uri.parse(url),
          body: body, headers: await SecureStorage.returnHeaderWithToken());
      var decodedResponse = jsonDecode(utf8.decode(response.bodyBytes)) as Map;
      if (response.statusCode == 200) {
        print('Response is $response');
        return true;
      } else if (response.statusCode == 429 || response.statusCode == 401) {
        print('Response is $decodedResponse');
        return Future.error('${decodedResponse["data"]}');
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
      const url = '$BASE_URL/accounts/verify-reset-password/';
      final body = {"code": code, "phone_number": phoneNumber};

      final response = await http.post(Uri.parse(url), body: body);
      var decodedResponse = jsonDecode(utf8.decode(response.bodyBytes)) as Map;
      print('Response is $decodedResponse');
      print('Status code is ${response.statusCode}');
      if (response.statusCode == 200) {
        storage.saveAccessToken(decodedResponse["data"]["token"]["access"]);
        storage.saveRefreshToken(decodedResponse["data"]["token"]["refresh"]);
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
        if (!decodedResponse["baby_stage"]) {
          return Future.error('Baby stage incomplete');
        }
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
