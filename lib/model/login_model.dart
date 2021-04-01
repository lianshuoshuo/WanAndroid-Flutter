import 'package:flutter_wanandroid/app/base/base_model.dart';
import 'package:flutter_wanandroid/app/net/request.dart';
import 'package:flutter_wanandroid/entity/user_entity.dart';

class LoginViewModel extends BaseViewModel<WanAndroidRepository> {
  Future<dynamic> login(username, password) async {
    var result;
    result =
        await requestData<UserEntity>(mRepository.login(username, password));
    return result;
  }

  @override
  WanAndroidRepository createRepository() {
    return WanAndroidRepository();
  }
}
