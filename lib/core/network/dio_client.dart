import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import '../utils/shared_prefs.dart';

class DioClient {
  final _dio = Dio();

  DioClient._singleton() {
    _dio
      ..options.connectTimeout = const Duration(milliseconds: 3)
      ..options.receiveTimeout = const Duration(seconds: 3)
      ..options.baseUrl = "http://millima.flutterwithakmaljon.uz/api"
      ..interceptors.add(DioInterceptor());
  }

  static final _singletonConstructor = DioClient._singleton();

  factory DioClient() {
    return _singletonConstructor;
  }

  Future<Response> get({
    required String path,
    Map<String, dynamic>? queryParams,
  }) async {
    try {
      return _dio.get(
        path,
        queryParameters: queryParams,
      );
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> post({
    required String path,
    Map<String, dynamic>? data,
  }) async {
    try {
      return _dio.post(
        path,
        data: data,
      );
    } catch (e) {
      rethrow;
    }
  }
}

class DioInterceptor extends Interceptor {
  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final accessToken = await SharedPrefs.getAccessToken();
    if (accessToken != null) {
      options.headers = {
        'Authorization': 'Bearer $accessToken',
      };
    }
    debugPrint(options.method.toString());
    if (options.connectTimeout!.inMilliseconds <
        const Duration(seconds: 3).inMilliseconds) {
      options.connectTimeout = const Duration(seconds: 3);
    }
    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    debugPrint("INTERCEPTOR: response.data: ${response.data}");
    super.onResponse(response, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    debugPrint(err.response?.data.toString());
    super.onError(err, handler);
  }
}
