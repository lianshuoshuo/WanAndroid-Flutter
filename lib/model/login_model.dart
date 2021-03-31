import 'package:flutter_wanandroid/app/base/base_model.dart';
import 'package:flutter_wanandroid/app/net/request.dart';

class LoginViewModel extends BaseViewModel<WanAndroidRepository> {

  login(username, password) async {
    String string = await requestData(mRepository.login(username, password));
  }

  @override
  WanAndroidRepository createRepository() {
    return WanAndroidRepository();
  }
}
