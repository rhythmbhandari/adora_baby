import 'dart:convert';
import 'dart:io';

import 'package:adora_baby/app/config/constants.dart';
import 'package:get/get.dart';
import '../../../main.dart';
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

  static Future<bool> reset(String password) async {
    const url = '$BASE_URL/accounts/reset-password/';
    final body = {"password": password, "refresh_token": storage.readRefreshToken()};
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
      final body = { "code": code, "phone_number": phoneNumber};
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
    final storeMedicalCategories = [].obs;
    final storeMedicalCategoriesId = [].obs;

    final storeMedicalSubCategories = [].obs;
    final storeMedicalSubCategoriesId = [].obs;

    final storeMedicalCategoriesBool = [].obs;
    final storeMedicalSubCategoriesBool = [].obs;

    final storeMedicalLength = [].obs;

    String url = '$BASE_URL/MedicalCategories/';
    final response = await http.get(Uri.parse(url));
    print('Response is $response');
    var decodedResponse = jsonDecode(utf8.decode(response.bodyBytes)) as Map;
    if (response.statusCode == 200) {
      if ((decodedResponse["data"] as List).isNotEmpty) {
        for (var element in (decodedResponse["data"] as List)) {
          storeMedicalCategories.add(element['name']);
          storeMedicalCategoriesId.add(element['id']);
          storeMedicalCategoriesBool.add(false);
          var length = element['medicalcategories'] as List;
          // print('Current length is till ${length.length}');
          storeMedicalLength.add(length.length);
          (element['medicalcategories'] as List).forEach((element) {
            storeMedicalSubCategories.add(element['name']);
            storeMedicalSubCategoriesId.add(element['id']);
            storeMedicalSubCategoriesBool.add(false);
          });
        }
        print("Length is ${storeMedicalCategories.length}");
        print("Length is ${storeMedicalCategoriesId.length}");

        print("Length is ${storeMedicalSubCategories.length}");
        print("Length is ${storeMedicalSubCategoriesId.length}");

        print("Length is ${storeMedicalLength[0]}");
        print("Length is ${storeMedicalLength[1]}");

        return [
          storeMedicalCategoriesId,
          storeMedicalCategories,
          storeMedicalSubCategoriesId,
          storeMedicalSubCategories,
          storeMedicalLength,
          storeMedicalCategoriesBool,
          storeMedicalSubCategoriesBool
        ];
      } else {
        return [];
      }
    } else {
      return [];
    }
  }
}
