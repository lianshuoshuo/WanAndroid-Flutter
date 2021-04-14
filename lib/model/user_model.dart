import 'package:flutter/cupertino.dart';
import 'package:flutter_wanandroid/app/GlobalConfig.dart';
import 'package:flutter_wanandroid/app/config/StorageManager.dart';
import 'package:flutter_wanandroid/entity/user_entity.dart';

class UserModel extends ChangeNotifier {
  static const String kUser = 'kUser';

  UserEntity _user;

  UserEntity get user => _user;

  bool get hasUser => user != null;

  UserModel() {
    var userMap = StorageManager.localStorage.getItem(kUser);
    _user = userMap != null ? UserEntity().fromJson(userMap) : null;
  }

  saveUser(UserEntity user) {
    _user = user;
    notifyListeners();
    StorageManager.localStorage.setItem(kUser, user);
  }

  /// 清除持久化的用户数据
  clearUser() {
    _user = null;
    notifyListeners();
    StorageManager.localStorage.deleteItem(kUser);
  }
}
