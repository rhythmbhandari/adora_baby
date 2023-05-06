import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:get/route_manager.dart';

import '../../../main.dart';
import '../../config/constants.dart';
import '../../routes/app_pages.dart';
import '../../utils/logging.dart';

class ErrorHandler {
  static Future<dynamic> handleDioError(DioError e) async {
    if (e.response?.statusCode == 403 || e.response?.statusCode == 401) {
      if (e.requestOptions.headers.containsKey('Authorization')) {
        await refreshToken();
      }
    }
    if (e.response?.data != null) {
      if (e.response!.data[0] is String) {
        return Future.error('${e.response!.data[0]}');
      } else if (e.response!.data.entries.toString().contains('{')) {
        return Future.error(
            '${e.response!.data[e.response!.data.keys.first].entries.toList()[0].value.join(',')}');
      } else {
        return Future.error('${e.response!.data[e.response!.data.keys.first]}');
      }
    } else {
      return Future.error('Server error. Please try again later!');
    }
  }

  static Future<dynamic> handleSocketException() {
    return Future.error('Please check your internet connection and try again.');
  }

  static Future<dynamic> handleTimeoutException() {
    return Future.error('Connection timed');
  }

  static Future<void> refreshToken() async {
    try {
      final refreshToken = await storage.readRefreshToken();
      Dio dio = Dio(BaseOptions(
          baseUrl: baseUrl, connectTimeout: 5000, receiveTimeout: 3000))
        ..interceptors.add(
          PrettyDioLogger(),
        );

      const url = '$baseUrl/refresh/';
      final body = jsonEncode({'refresh': refreshToken});
      final response = await dio.post(url, data: body);

      if (response.statusCode == 200) {
        storage.saveAccessToken(response.data["access"]);
        storage.saveRefreshToken(response.data["refresh"]);
      }
    } catch (e) {
      await storage.delete(
        Constants.ACCESS_TOKEN,
      );
      await storage.delete(
        Constants.LOGGED_IN_STATUS,
      );
      await storage.delete(
        Constants.REFRESH_TOKEN,
      );
      Get.offAllNamed(Routes.LOGIN);
    }
  }

  static Future<Response> executeWithTimeout(
      Future<Response> Function() function, String url,
      {int seconds = 10}) async {
    return await function().timeout(
      Duration(seconds: seconds),
      onTimeout: () {
        return Response(
          data: {'status': '405', 'message': '405 Error'},
          statusCode: 405,
          requestOptions: RequestOptions(
            path: url,
          ),
        );
      },
    );
  }
}
