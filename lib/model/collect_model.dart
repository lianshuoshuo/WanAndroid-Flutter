import 'package:flutter_wanandroid/app/base/base_model.dart';
import 'package:flutter_wanandroid/app/net/request.dart';

class CollectViewModel extends BaseViewModel<WanAndroidRepository> {
  Future<dynamic> getList() async {
    requestData(mRepository.getCollectList());
  }

  Future<bool> collect(int id) async {
    requestData(mRepository.collect(id));
    return true;
  }

  Future<bool> unCollect(int id) async {
    requestData(mRepository.unCollect(id));
    return false;
  }

  @override
  WanAndroidRepository createRepository() {
    return WanAndroidRepository();
  }
}
