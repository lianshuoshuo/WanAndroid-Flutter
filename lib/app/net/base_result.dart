import 'EntityFactory.dart';

/// 通用返回类
class BaseEntity<T> {
  /// 返回数据bean
  dynamic data;

  /// 状态码
  int errorCode;

  /// 返回信息
  String errorMsg;

  BaseEntity({this.data, this.errorCode, this.errorMsg});

  factory BaseEntity.fromJson(json) {
    return BaseEntity(
      errorCode: json["errorCode"],
      errorMsg: json["errorMsg"],
      // data值需要经过工厂转换为我们传进来的类型
      data: EntityFactory.generateOBJ<T>(json["data"]),
    );
  }
}

class BaseListEntity<T> {
  int errorCode;
  String errorMsg;
  List<T> data;

  BaseListEntity({this.errorCode, this.errorMsg, this.data});

  factory BaseListEntity.fromJson(json) {
    List<T> mData = new List<T>();
    if (json['data'] != null) {
      //遍历data并转换为我们传进来的类型
      (json['data'] as List).forEach((v) {
        mData.add(EntityFactory.generateOBJ<T>(v));
      });
    }
    return BaseListEntity(
      errorCode: json["errorCode"],
      errorMsg: json["errorMsg"],
      data: mData,
    );
  }

  Map toJson() => {
        "errorCode": errorCode,
        "errorMsg": errorMsg,
        "data": data,
      };
}
