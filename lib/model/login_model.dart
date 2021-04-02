import 'package:flutter_wanandroid/app/base/base_model.dart';
import 'package:flutter_wanandroid/app/net/request.dart';
import 'package:flutter_wanandroid/entity/user_entity.dart';

class LoginViewModel extends BaseViewModel<WanAndroidRepository> {
  UserEntity _userEntity;

  LoginViewModel() {
    _userEntity = new UserEntity();
  }

  UserEntity get userEntity => _userEntity;

  Future<dynamic> login(username, password) async {
    _userEntity =
        await requestData<UserEntity>(mRepository.login(username, password));
    notifyListeners();
    return _userEntity;
  }

  @override
  WanAndroidRepository createRepository() {
    return WanAndroidRepository();
  }
}
