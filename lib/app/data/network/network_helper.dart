import 'dart:convert';


import 'package:adora_baby/app/config/constants.dart';
import 'package:dio/dio.dart';

import 'package:http/http.dart' as http;



class NetworkHelper {
  Dio getDioClient() {
    return Dio(BaseOptions(baseUrl: BASE_URL));
  }

  static const headers = {
    'Content-Type': 'application/json',
    "Accept": "application/json"
  };

  Future<Response> getRequest(
      String path, {
        final contentType,
        CancelToken? cancelToken,
      }) async {
    Dio dio = getDioClient();
    Options options = Options(headers: contentType, responseType: ResponseType.json);
    try {
      return await dio.get(
        path,
        options: options,
        cancelToken: cancelToken,
      );
    } on DioError catch (e) {
      return Response(
        data: {'status': e.error, 'message': e.message},
        statusCode: e.response?.statusCode,
        requestOptions: e.requestOptions,
      );
    }
  }


  Future<Response> postRequest(
      String path, {
        dynamic data,
        dynamic contentType,
        CancelToken? cancelToken,
      }) async {
    Dio dio = getDioClient();
    Options options = Options(headers: contentType, responseType: ResponseType.json);
    try {
      return await dio.post(
        path,
        data: data,
        options: options,
        cancelToken: cancelToken,
      );
    } on DioError catch (e) {
      if(e.message.contains('SocketException')) {
        return Response(
          data: {'status': e.error, 'message': 'No internet connection.'},
          statusCode: e.response?.statusCode,
          requestOptions: e.requestOptions,
        );
      }
      return Response(
        data: {'status': e.error, 'message': e.message},
        statusCode: e.response?.statusCode,
        requestOptions: e.requestOptions,
      );
    }
  }

  static Future<dynamic> postHttpRequest(String uri, body,
      {headers = headers}) async {
    Uri url = Uri.parse(uri);
    http.Response response = await http.post(url, body: body, headers: headers);
    return jsonDecode(response.body);
  }

   Future<dynamic> multipartRequest(url, FormData formData, header) async {
    Dio dio = Dio();
    final response = await dio.post(url,
        data: formData,
        options: Options(
            method: 'POST', headers: header, responseType: ResponseType.json));
    return response;
  }


  Future<Response> patchRequest(
      String path, {
        dynamic data,
        dynamic contentType,
        CancelToken? cancelToken,
      }) async {
    Dio dio = getDioClient();
    Options options = Options(headers: contentType, responseType: ResponseType.json);
    try {
      return await dio.patch(
        path,
        data: data,
        options: options,
        cancelToken: cancelToken,
      );
    } on DioError catch (e) {
      if(e.message.contains('SocketException')) {
        return Response(
          data: {'status': e.error, 'message': 'No internet connection.'},
          statusCode: e.response?.statusCode,
          requestOptions: e.requestOptions,
        );
      }
      return Response(
        data: {'status': e.error, 'message': e.message},
        statusCode: e.response?.statusCode,
        requestOptions: e.requestOptions,
      );
    }
  }
}
