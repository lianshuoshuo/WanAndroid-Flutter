import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio/dio.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:flutter_wanandroid/app/config/StorageManager.dart';

import '../GlobalConfig.dart';
import 'request_const.dart';

class HttpHelper {
  Dio _dio;

  factory HttpHelper() => _getProvider();

  HttpHelper._internal();

  static HttpHelper get instance => _getProvider();
  static HttpHelper _httpHelper;

  static HttpHelper _getProvider() {
    if (_httpHelper == null) {
      _httpHelper = new HttpHelper._internal();
    }
    return _httpHelper;
  }

  ///创建Dio
  Dio _createDio() {
    final options = BaseOptions(
        baseUrl: RequestConstApi.SERVICE_API,
        contentType: Headers.jsonContentType,
        responseType: ResponseType.json,
        connectTimeout: 20000,
        receiveTimeout: 20000);
    final dio = new Dio(options);
    dio.interceptors
      ..add(LogInterceptor(responseBody: GlobalConfig.isDebug))..add(
        CookieManager(
            PersistCookieJar(dir: StorageManager.temporaryDirectory.path)));
    return dio;
  }

  Dio getDio() {
    if (_dio == null) {
      _dio = _createDio();
    }
    return _dio;
  }
}
