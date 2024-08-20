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
      ..interceptors.add(TestInterceptor());
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
      final accessToken = await SharedPrefs.getAccessToken();
      return _dio.get(
        path,
        queryParameters: queryParams,
        options: Options(
          headers: {
            'Authorization': 'Bearer $accessToken',
          },
        ),
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
      final accessToken = await SharedPrefs.getAccessToken();
      return _dio.post(
        path,
        data: data,
        options: Options(
          headers: {
            'Authorization': 'Bearer $accessToken',
          },
        ),
      );
    } catch (e) {
      rethrow;
    }
  }
}

class TestInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
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
