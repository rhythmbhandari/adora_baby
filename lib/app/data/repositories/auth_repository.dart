import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:adora_baby/app/config/constants.dart';
import 'package:dio_smart_retry/dio_smart_retry.dart';
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
      final response = await DioHelper.postRequest(
        url,
        body,
        false,
        await SecureStorage.returnHeader(),
      );

      if (response) {
        return true;
      } else {
        return Future.error('$response');
      }
    } on SocketException {
      return Future.error(
          'Please check your internet connection and try again.');
    } catch (e) {
      return Future.error('$e');
    }
  }

  static Future<bool> resetPassword(String phoneNumber) async {
    const url = '$BASE_URL/accounts/request-reset-password/';
    final body = {"phone_number": phoneNumber};

    try {
      final response = await DioHelper.postRequest(
        url,
        body,
        false,
        await SecureStorage.returnHeader(),
      );

      if (response) {
        return true;
      } else {
        return false;
      }
    } on SocketException {
      return Future.error(
          'Please check your internet connection and try again.');
    } catch (e) {
      return Future.error('$e');
    }
  }

  static Future<bool> deleteAccount(
      {required String reason,
      required String password,
      required String confirmPassword}) async {
    const url = '$BASE_URL/accounts/delete/';
    final body = {
      "reason": reason,
      "password": password,
      "confirm_password": confirmPassword,
    };

    try {
      final response = await DioHelper.postRequest(
        url,
        body,
        false,
        await SecureStorage.returnHeaderWithToken(),
      );

      if (response) {
        return true;
      } else {
        return false;
      }
    } on SocketException {
      return Future.error(
          'Please check your internet connection and try again.');
    } catch (e) {
      return Future.error('$e');
    }
  }

  static Future<bool> registerUserName(
      String fullName, String username, String password) async {
    const url = '$BASE_URL/accounts/signup/';
    final body = jsonEncode(
        {"full_name": fullName, "password": password, "username": username});
    try {
      final response = await DioHelper.postRequest(
        url,
        body,
        false,
        await SecureStorage.returnHeaderWithToken(),
      );
      if (response) {
        return true;
      } else {
        return Future.error('$response');
      }
    } on SocketException {
      return Future.error(
          'Please check your internet connection and try again.');
    } catch (e) {
      return Future.error('$e');
    }
  }

  static Future<bool> updateMedicalCondition(
      String description, List medicalConditions) async {
    const url = '$BASE_URL/medical/';
    final body = jsonEncode(
        {"description": description, "MedicalCondition": medicalConditions});
    try {
      final response = await DioHelper.postRequest(
        url,
        body,
        false,
        await SecureStorage.returnHeaderWithToken(),
      );
      if (response) {
        return true;
      } else {
        return Future.error('$response');
      }
    } on SocketException {
      return Future.error(
          'Please check your internet connection and try again.');
    } catch (e) {
      return Future.error('$e');
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
        false,
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
    final body = jsonEncode({"baby_name": babyName, "baby_dob": dateOfBirth});
    try {
      final response = await DioHelper.postRequest(
        url,
        body,
        false,
        await SecureStorage.returnHeaderWithToken(),
      );
      if (response) {
        return true;
      } else {
        return Future.error('Server Error');
      }
    } on SocketException {
      return Future.error(
          'Please check your internet connection and try again.');
    } catch (e) {
      return Future.error('$e');
    }
  }

  static Future<bool> reset(String password) async {
    const url = '$BASE_URL/accounts/reset-password/';
    final body = jsonEncode({
      "password": password,
      "refresh_token": await storage.readRefreshToken()
    });

    try {
      final response = await DioHelper.postRequest(
        url,
        body,
        false,
        await SecureStorage.returnHeaderWithToken(),
      );
      if (response) {
        return true;
      } else {
        return Future.error('Server Error $response');
      }
    } on SocketException {
      return Future.error(
          'Please check your internet connection and try again.');
    } catch (e) {
      return Future.error('$e');
    }
  }

  static Future<bool> changePassword(
      String currentPassword, String newPassword) async {
    const url = '$BASE_URL/accounts/change-password/';
    final body = jsonEncode(
        {"old_password": currentPassword, "new_password": newPassword});
    try {
      final response = await DioHelper.postRequest(
        url,
        body,
        false,
        await SecureStorage.returnHeaderWithToken(),
      );
      if (response) {
        return true;
      } else {
        return Future.error('Server Error $response');
      }
    } on SocketException {
      return Future.error(
          'Please check your internet connection and try again.');
    } catch (e) {
      return Future.error('$e');
    }
  }

  static Future<bool> verifyOtp(String phoneNumber, String code) async {
    try {
      const url = '$BASE_URL/accounts/verify/';
      final body = {"phone_number": phoneNumber, "code": code};

      final response = await DioHelper.postRequest(
        url,
        body,
        true,
        await SecureStorage.returnHeader(),
      );
      if (response is Map<String, dynamic>) {
        storage.saveAccessToken(response["token"]["access"]);
        storage.saveRefreshToken(response["token"]["refresh"]);
        return true;
      } else {
        return Future.error('Server Error $response');
      }
    } on SocketException {
      return Future.error(
          'Please check your internet connection and try again.');
    } catch (e) {
      return Future.error('$e');
    }
  }

  static Future<bool> verifyReset(String phoneNumber, String code) async {
    try {
      const url = '$BASE_URL/accounts/verify-reset-password/';
      final body = {"code": code, "phone_number": phoneNumber};

      final response = await DioHelper.postRequest(
        url,
        body,
        true,
        await SecureStorage.returnHeaderWithToken(),
      );
      if (response is Map<String, dynamic>) {
        storage.saveAccessToken(response["token"]["access"]);
        storage.saveRefreshToken(response["token"]["refresh"]);
        return true;
      } else {
        return Future.error('Server Error $response');
      }
    } on SocketException {
      return Future.error(
          'Please check your internet connection and try again.');
    } catch (e) {
      return Future.error('$e');
    }
  }

  static Future<bool> initiateLogin(String phoneNumber, String password) async {
    try {
      const url = '$BASE_URL/accounts/login/';
      final body = {"phone_number": phoneNumber, "password": password};

      final decodedResponse = await DioHelper.postRequest(
        url,
        body,
        true,
        await SecureStorage.returnHeader(),
      );
      if (decodedResponse is Map<String, dynamic>) {
        storage.saveAccessToken(decodedResponse["token"]["access"]);
        storage.saveRefreshToken(decodedResponse["token"]["refresh"]);
        if (!decodedResponse["baby_stage"]) {
          return Future.error('Baby stage incomplete');
        }
        return true;
      } else {
        if (decodedResponse.body.toString().contains('null')) {
          return Future.error('Server Error');
        }
        return Future.error(
            '${decodedResponse["error"] ?? decodedResponse["detail"] ?? 'Server Error'}');
      }
    } on SocketException {
      return Future.error(
          'Please check your internet connection and try again.');
    } catch (e) {
      return Future.error('$e');
    }
  }

  static Future<List> fetchMedicalCategories() async {
    final babyMedicalCondition = [];

    String url = '$BASE_URL/MedicalCategories/';

    final response = await DioHelper.getRequest(
      url,
      true,
      await SecureStorage.returnHeader(),
    );

    if (response is Map<String, dynamic>) {
      if ((response["data"] as List).isNotEmpty) {
        for (var elements in (response["data"] as List)) {
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
