import 'dart:async';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:dio_cache_interceptor/dio_cache_interceptor.dart';
import 'package:dio_smart_retry/dio_smart_retry.dart';
import 'package:flutter/foundation.dart';
import '../../config/constants.dart';
import '../../utils/logging.dart';
import 'error_handler.dart';

class DioHelper {
  static final DioHelper _instance = DioHelper._internal();

  static final Dio _dio = Dio(
    BaseOptions(
      baseUrl: baseUrl,
      connectTimeout: 50000,
      receiveTimeout: 30000,
    ),
  )..interceptors.addAll([
      // PrettyDioLogger(
      //   requestHeader: true,
      //   logPrint: (o) => debugPrint(
      //     o.toString(),
      //   ),
      // ),
      RetryInterceptor(
        dio: Dio(),
        logPrint: (o) => debugPrint(
          o.toString(),
        ),
        retries: 2,
        retryDelays: const [
          Duration(seconds: 1),
          Duration(seconds: 2),
          Duration(seconds: 3),
          Duration(seconds: 4),
        ],
      ),
      DioCacheInterceptor(
        options: cacheOptions,
      ),
    ]);

  factory DioHelper() {
    return _instance;
  }

  DioHelper._internal();

  static final cacheOptions = CacheOptions(
    store: MemCacheStore(),
    policy: CachePolicy.request,
    hitCacheOnErrorExcept: [
      401,
      403,
      408,
    ],
    maxStale: const Duration(
      days: 7,
    ),
    priority: CachePriority.normal,
    cipher: null,
    keyBuilder: CacheOptions.defaultCacheKeyBuilder,
    allowPostMethod: false,
  );

  static Future<dynamic> getRequest(
    String urlInput,
    bool returnResponse,
    Map<String, String> headers,
  ) async {
    try {
      final url = urlInput;

      Options options = Options(
        headers: headers,
        responseType: ResponseType.json,
      );
      final response = await ErrorHandler.executeWithTimeout(
        () => _dio.get(
          url,
          options: options,
        ),
        url,
      );
      if (response.statusCode == 200) {
        if (returnResponse) {
          return response.data;
        }
        return true;
      } else {
        Future.error('${response.statusMessage}');
      }
    } on SocketException {
      return ErrorHandler.handleSocketException();
    } on TimeoutException {
      return ErrorHandler.handleTimeoutException();
    } on DioError catch (e) {
      return ErrorHandler.handleDioError(e);
    } catch (e) {
      return Future.error('Exception is $e');
    }
  }

  static Future<dynamic> postRequest(
    String urlInput,
    dynamic decodedBody,
    bool returnResponse,
    Map<String, String> headers, {
    bool isLogout = false,
  }) async {
    try {
      final url = urlInput;

      Options options = Options(
        headers: headers,
        responseType: ResponseType.json,
      );

      final response = await ErrorHandler.executeWithTimeout(
        () => _dio.post(
          url,
          data: decodedBody,
          options: options,
        ),
        url,
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        if (returnResponse) {
          return response.data;
        }
        return true;
      } else {
        return Future.error(response.data);
      }
    } on SocketException {
      return ErrorHandler.handleSocketException();
    } on TimeoutException {
      return ErrorHandler.handleTimeoutException();
    } on DioError catch (e) {
      return ErrorHandler.handleDioError(e);
    } catch (e) {
      return Future.error('Exception is $e');
    }
  }

  static Future<dynamic> patchRequest(String urlInput, dynamic decodedBody,
      bool returnResponse, Map<String, String> headers) async {
    try {
      final url = urlInput;
      Options options =
          Options(headers: headers, responseType: ResponseType.json);

      final response = await ErrorHandler.executeWithTimeout(
        () => _dio.patch(
          url,
          data: decodedBody,
          options: options,
        ),
        url,
      );
      if (response.statusCode == 200) {
        return true;
      } else {
        return Future.error('Server error.');
      }
    } on SocketException {
      return ErrorHandler.handleSocketException();
    } on TimeoutException {
      return ErrorHandler.handleTimeoutException();
    } on DioError catch (e) {
      return ErrorHandler.handleDioError(e);
    } catch (e) {
      return Future.error('Exception is $e');
    }
  }

  static Future<dynamic> putRequest(String urlInput, dynamic decodedBody,
      bool returnResponse, Map<String, String> headers) async {
    try {
      final url = urlInput;

      Options options =
          Options(headers: headers, responseType: ResponseType.json);

      final response = await ErrorHandler.executeWithTimeout(
        () => _dio.put(
          url,
          data: decodedBody,
          options: options,
        ),
        url,
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        if (returnResponse) {
          return response.data;
        }
        return true;
      } else {
        return Future.error('Server error.');
      }
    } on SocketException {
      return ErrorHandler.handleSocketException();
    } on TimeoutException {
      return ErrorHandler.handleTimeoutException();
    } on DioError catch (e) {
      return ErrorHandler.handleDioError(e);
    } catch (e) {
      return Future.error('Exception is $e');
    }
  }
}
