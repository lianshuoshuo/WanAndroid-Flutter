import 'package:dio/dio.dart';
import 'package:flutter_wanandroid/app/net/AppException.dart';
import 'package:flutter_wanandroid/app/net/base_result.dart';

///
class BaseRepository {
  Dio _dio;

  BaseRepository();

  void setdio(Dio value) {
    _dio = value;
  }

  //get请求
  Future<dynamic> get(String path, {Map<String, dynamic> params}) async {
    try {
      Response response = await _dio.get(path, queryParameters: params);
      return response.data;
    } on DioError catch (error) {
      print('异常信息：' + error.toString());
      // return BaseResult(errorMsg: error.toString(), errorCode: 500);
      ExceptionHandle().handleException(error);
    }
  }

  // 通用post请求
  Future<dynamic> post(String path, Map<String, dynamic> params) async {
    try {
      Response response = await _dio.post(path, queryParameters: params);
      return response.data;
    } on DioError catch (error) {
      print('异常信息：' + error.toString());
      // return BaseResult(errorMsg: error.toString(), errorCode: 500);
      ExceptionHandle().handleException(error);
    }
  }
}
