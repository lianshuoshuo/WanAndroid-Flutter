import 'package:flutter/material.dart';
import 'package:flutter_wanandroid/app/net/AppException.dart';
import 'package:flutter_wanandroid/app/net/EntityFactory.dart';
import 'package:flutter_wanandroid/app/net/base_repository.dart';
import 'package:flutter_wanandroid/generated/json/base/json_convert_content.dart';

abstract class BaseViewModel<T extends BaseRepository> extends ChangeNotifier {
  /// 防止页面销毁后,异步任务才完成,导致报错
  bool disposed = false;

  T mRepository;

  BaseViewModel() {
    mRepository = createRepository();
  }

  ///请求结果过滤
  Future<dynamic> requestData<N extends JsonConvert>(dynamic f) async {
    var result;
    try {
      result = await f;
      if (result.errorCode == 0) {
        // 数据请求成功
        result = EntityFactory.generateOBJ<N>(result.data);
      } else {
        throw result;
      }
    } catch (e) {
      throw AppException(e.errorMsg, e.errorCode);
    }
    return result;
  }

  /// 提供一个创建Repository对象的抽象方法T createRepository();
  T createRepository() {}

  @override
  void notifyListeners() {
    if (!disposed) {
      super.notifyListeners();
    }
  }

  @override
  void dispose() {
    disposed = true;
    super.dispose();
  }
}
