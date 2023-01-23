import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dio_cache_interceptor/dio_cache_interceptor.dart';
import 'package:dio_smart_retry/dio_smart_retry.dart';
import 'package:flutter/rendering.dart';

import '../../../main.dart';
import '../../config/constants.dart';
import '../../utils/logging.dart';

class DioHelper {
  static Dio getDioClient() {
    return Dio(BaseOptions(
        baseUrl: baseUrl, connectTimeout: 5000, receiveTimeout: 3000))
      ..interceptors.add(
        Logging(),
      );
  }

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
      Dio dio = getDioClient();
      dio.interceptors.add(InterceptorsWrapper(onError: (error, handler) async {
        if (error.response?.statusCode == 403 ||
            error.response?.statusCode == 401) {
          await refreshToken();
          // return _retry(error.request);
        }
        // return error.response;
      }));

      dio.interceptors.add(
        RetryInterceptor(
          dio: dio,
          logPrint: print,
          retries: 4,
          retryDelays: const [
            Duration(
              seconds: 1,
            ),
            Duration(
              seconds: 2,
            ),
            Duration(
              seconds: 3,
            ),
            Duration(
              seconds: 4,
            ),
          ],
        ),
      );

      dio.interceptors.add(
        DioCacheInterceptor(
          options: cacheOptions,
        ),
      );
      Options options = Options(
        headers: headers,
        responseType: ResponseType.json,
      );
      final response = await dio
          .get(
        url,
        options: options,
      )
          .timeout(
        const Duration(
          seconds: 10,
        ),
        onTimeout: () {
          return Response(
            data: {
              'status': '408',
              'message': '405 Error',
            },
            statusCode: 408,
            requestOptions: RequestOptions(
              path: url,
            ),
          );
        },
      );
      if (response.statusCode == 200) {
        if (returnResponse) {
          return response.data;
        }
        return true;
      } else {
        return Future.error('Server error.');
      }
    } on SocketException {
      return Future.error(
          'Please check your internet connection and try again.');
    } on TimeoutException {
      return Future.error('Connection timed');
    } on DioError catch (e) {
      if (e.response?.data != null) {
        if (e.response!.data.entries.toString().contains(
              '{',
            )) {
          return Future.error(
            '${e.response!.data[e.response!.data.keys.first].entries.toList()[0].value.join(',')}',
          );
        } else {
          return Future.error(
            '${e.response!.data[e.response!.data.keys.first]}',
          );
        }
      } else {
        return Future.error('Server error. Please try again later!');
      }
    } catch (e) {
      debugPrint('Catched error is $e');
      return Future.error('Exception is $e');
    }
  }

  static Future<dynamic> postRequest(
    String urlInput,
    String decodedBody,
    bool returnResponse,
    Map<String, String> headers, {
    bool isLogout = false,
  }) async {
    try {
      final url = urlInput;
      Dio dio = getDioClient();
      dio.interceptors.add(
        RetryInterceptor(
          dio: dio,
          logPrint: print,
          retries: 4,
          retryDelays: const [
            Duration(
              seconds: 1,
            ),
            Duration(
              seconds: 2,
            ),
            Duration(
              seconds: 3,
            ),
            Duration(
              seconds: 4,
            ),
          ],
        ),
      );
      Options options = Options(
        headers: headers,
        responseType: ResponseType.json,
      );
      final response = await dio
          .post(
        url,
        options: options,
        data: decodedBody,
      )
          .timeout(
              const Duration(
                seconds: 10,
              ), onTimeout: () {
        return Response(
          data: {'status': '405', 'message': '405 Error'},
          statusCode: 405,
          requestOptions: RequestOptions(
            path: url,
          ),
        );
      });
      debugPrint('Response is $response');
      debugPrint('Status code is ${response.statusCode}');
      if (response.statusCode == 200) {
        if (returnResponse) {
          return response.data;
        }
        return true;
      } else {
        return Future.error('Server error.');
      }
    } on SocketException {
      return Future.error(
        'Please check your internet connection and try again.',
      );
    } on TimeoutException {
      return Future.error(
        'Connection timed',
      );
    } on DioError catch (e) {
      if (e.response?.statusCode == 401) {
        if (isLogout) {
          return true;
        }
        return false;
      } else if (e.response?.data != null) {
        if (e.response!.data.entries.toString().contains('{')) {
          return Future.error(
              '${e.response!.data[e.response!.data.keys.first].entries.toList()[0].value.join(',')}');
        } else {
          return Future.error(
              '${e.response!.data[e.response!.data.keys.first]}');
        }
      } else {
        return Future.error('Server error. Please try again later!');
      }
    } catch (e) {
      return Future.error(
        'Exception is $e',
      );
    }
  }

  static Future<dynamic> patchRequest(String urlInput, dynamic decodedBody,
      bool returnResponse, Map<String, String> headers) async {
    try {
      final url = urlInput;
      Dio dio = getDioClient();
      dio.interceptors.add(
        RetryInterceptor(
          dio: dio,
          logPrint: print, // specify log function (optional)
          retries: 4, // retry count (optional)
          retryDelays: const [
            // set delays between retries (optional)
            Duration(
              seconds: 1,
            ), // wait 1 sec before the first retry
            Duration(
              seconds: 2,
            ), // wait 2 sec before the second retry
            Duration(
              seconds: 3,
            ), // wait 3 sec before the third retry
            Duration(
              seconds: 4,
            ), // wait 4 sec before the fourth retry
          ],
        ),
      );
      Options options =
          Options(headers: headers, responseType: ResponseType.json);

      final response = await dio
          .patch(
        url,
        data: decodedBody,
        options: options,
      )
          .timeout(
        const Duration(seconds: 10),
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
      debugPrint('Response is $response');
      debugPrint('Status code is ${response.statusCode}');
      if (response.statusCode == 200) {
        return true;
      } else {
        return Future.error('Server error.');
      }
    } on SocketException {
      return Future.error(
          'Please check your internet connection and try again.');
    } on TimeoutException {
      return Future.error('Connection timed');
    } on DioError catch (e) {
      if (e.response?.data != null) {
        if (e.response!.data.entries.toString().contains('{')) {
          return Future.error(
              '${e.response!.data[e.response!.data.keys.first].entries.toList()[0].value.join(',')}');
        } else {
          return Future.error(
              '${e.response!.data[e.response!.data.keys.first]}');
        }
      } else {
        return Future.error('Server error. Please try again later!');
      }
    } catch (e) {
      print('Reched here === $e');
      return Future.error('Exception is $e');
    }
  }

  // static Future<Response<dynamic>> _retry(RequestOptions requestOptions) async {
  //   final options = new Options(
  //     method: requestOptions.method,
  //     headers: requestOptions.headers,
  //   );
  //   Dio dio = getDioClient();
  //   return dio.request<dynamic>(requestOptions.path,
  //       data: requestOptions.data,
  //       queryParameters: requestOptions.queryParameters,
  //       options: options);
  // }

  static Future<void> refreshToken() async {
    final refreshToken = await storage.readRefreshToken();
    Dio dio = getDioClient();
    const url = '$baseUrl/refresh/';
    final body = jsonEncode({'refresh': refreshToken});
    final response = await dio.post(url, data: body);

    if (response.statusCode == 200) {
      storage.saveAccessToken(response.data["access"]);
      storage.saveRefreshToken(response.data["refresh"]);
    }
  }
}
