import 'package:flutter_wanandroid/app/base/base_model.dart';
import 'package:flutter_wanandroid/app/config/StorageManager.dart';
import 'package:flutter_wanandroid/app/net/request.dart';
import 'package:flutter_wanandroid/entity/user_entity.dart';

import 'user_model.dart';

class LoginViewModel extends BaseViewModel<WanAndroidRepository> {
  UserModel userModel;

  LoginViewModel() {
    userModel = new UserModel();
  }

  Future<dynamic> login(username, password) async {
    var user = await requestData<UserEntity>(
        mRepository.login(username, password),
        isShowLoadDialog: true);
    userModel.saveUser(user);
    StorageManager.localStorage.setItem("userInfo", userModel.user);
    notifyListeners();
    return userModel;
  }

  @override
  WanAndroidRepository createRepository() {
    return WanAndroidRepository();
  }
}
