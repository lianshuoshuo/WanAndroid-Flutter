import 'package:flutter/material.dart';
import 'package:flutter_wanandroid/app/net/base_repository.dart';

class BaseViewModel<T extends BaseRepository> extends ChangeNotifier {
  T mRepository;

  BaseViewModel() {
    mRepository = createRepository();
  }

  Future<dynamic> requestData(dynamic f) async {
    var result;
    try {
      result = await f;
    } catch (e) {
      throw Exception(e);
    }
    return result;
  }

  /// 提供一个创建Repository对象的抽象方法T createRepository();
  T createRepository() {}
}
