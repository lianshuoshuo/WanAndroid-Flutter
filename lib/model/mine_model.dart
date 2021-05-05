import 'package:flutter_wanandroid/app/base/base_model.dart';
import 'package:flutter_wanandroid/app/net/request.dart';
import 'package:flutter_wanandroid/entity/user_data_entity.dart';

class MineViewModel extends BaseViewModel<WanAndroidRepository> {
  UserDataEntity _userDataEntity;

  UserDataEntity get userDataEntity => _userDataEntity;

  int page = 1;

  Future getUserArticle(bool isRefresh) async {
    _userDataEntity =
        await requestData<UserDataEntity>(mRepository.getUserArticle(page));
  }

  @override
  WanAndroidRepository createRepository() {
    return WanAndroidRepository();
  }
}
