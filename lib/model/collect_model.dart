import 'package:flutter_wanandroid/app/base/base_model.dart';
import 'package:flutter_wanandroid/app/net/request.dart';

class CollectViewModel extends BaseViewModel<WanAndroidRepository> {
  CollectViewModel() {}

  Future<dynamic> getList() async {
    requestData(mRepository.getCollectList());
  }

  @override
  WanAndroidRepository createRepository() {
    return WanAndroidRepository();
  }
}
