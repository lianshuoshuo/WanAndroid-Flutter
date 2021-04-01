import 'package:flutter/material.dart';
import 'package:flutter_wanandroid/app/net/base_repository.dart';

abstract class BaseViewModel<T extends BaseRepository> extends ChangeNotifier {
  T mRepository;

  BaseViewModel() {
    mRepository = createRepository();
  }

  Future<dynamic> requestData<T>(dynamic f) async {
    var result;
    try {
      result = await f;
      if (result.errorCode == 0) {
        result = (T as dynamic)().fromJson(result.data);
      } else {
        throw result;
      }
    } catch (e) {
      throw Exception(e);
    }
    return result;
  }

  /// 提供一个创建Repository对象的抽象方法T createRepository();
  T createRepository() {}
}
