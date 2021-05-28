import 'package:dio/dio.dart';
import 'package:dio_http_cache/dio_http_cache.dart';
import 'package:flutter/foundation.dart';

import '../flavors.dart';
import 'api_client.dart';

class ApiClientProvider {
  const ApiClientProvider._(this._dio);

  final Dio _dio;

  factory ApiClientProvider() {
    final dio = Dio();

    dio.interceptors.add(_cacheInterceptor());

    // Only intercept network log on debug mode
    if (!kReleaseMode) {
      dio.interceptors.add(_logInterceptor());
    }

    return ApiClientProvider._(dio);
  }

  ApiClient httpClient() {
    return ApiClient(_dio, baseUrl: F.restApiEndpoint);
  }

  static Interceptor _cacheInterceptor() {
    return DioCacheManager(
      CacheConfig(
        defaultMaxAge: Duration(days: 3),
        maxMemoryCacheCount: 3,
      ),
    ).interceptor;
  }

  static LogInterceptor _logInterceptor() {
    return LogInterceptor(requestBody: true, responseBody: true);
  }
}
