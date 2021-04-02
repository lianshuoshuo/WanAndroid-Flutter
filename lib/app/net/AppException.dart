import 'package:dio/dio.dart';

class AppException implements Exception {
  String errorMsg;
  int errorCode;
  dynamic data;

  AppException(this.errorMsg, this.errorCode, {this.data}) {
    switch (errorCode) {
      case -1:
        print(errorMsg);
        break;
    }
  }
}

class ExceptionHandle {
  AppException handleException(DioError e) {
    switch (e.type) {
      case DioErrorType.CANCEL:
        return AppException("请求取消", -1);
        break;
      case DioErrorType.CONNECT_TIMEOUT:
        return AppException("连接超时", -1);
        break;
      case DioErrorType.SEND_TIMEOUT:
        return AppException("请求超时", -1);
        break;
      case DioErrorType.RECEIVE_TIMEOUT:
        return AppException("响应超时", -1);
        break;
      case DioErrorType.RESPONSE:
        {
          try {
            var response = e.response;
            return AppException(response.statusMessage, response.statusCode);
          } on Exception catch (_) {
            return AppException("未知错误", -1);
          }
        }
        break;
      case DioErrorType.DEFAULT:
        return AppException(e.message, -1);
        break;
      default:
        return AppException(e.message, -1);
    }
  }
}
