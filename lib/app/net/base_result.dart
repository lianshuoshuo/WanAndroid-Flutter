/// 通用返回类
class BaseResult {
  /// 返回数据bean
  dynamic data;
  /// 状态码
  int errorCode;
  /// 返回信息
  String errorMsg;
  BaseResult({this.data, this.errorCode, this.errorMsg});

  factory BaseResult.fromJson(json) {
    return BaseResult(
      errorCode: json["errorCode"],
      errorMsg: json["errorMsg"],
      // data值需要经过工厂转换为我们传进来的类型
      data: json["data"],
    );
  }
}
