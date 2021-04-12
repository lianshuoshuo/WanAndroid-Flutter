import 'package:dio/dio.dart';
import 'package:flutter_wanandroid/app/net/request_const.dart';

import 'HttpHelper.dart';
import 'base_repository.dart';

class WanAndroidRepository extends BaseRepository {
  Dio dio;

  WanAndroidRepository() {
    dio = HttpHelper.instance.getDio();
    setdio(dio);
  }

  ///登录
  Future<dynamic> login(String username, String password) async {
    var map = Map<String, dynamic>();
    map['username'] = username;
    map['password'] = password;
    return await post(RequestConstApi.LOGIN, map);
  }

  ///注册
  Future<dynamic> register(
      String username, String password, String rePassword) async {
    var map = Map<String, dynamic>();
    map['username'] = username;
    map['password'] = password;
    map['repassword'] = rePassword;
    return await post(RequestConstApi.REGISTER, map);
  }

  ///退出登录
  Future<dynamic> logout() async {
    return await get(RequestConstApi.LOGOUT);
  }

  Future<dynamic> getCollectList() async {
    return await get(RequestConstApi.COLLECT_LIST);
  }

  Future getBannerList() async {
    return await get(RequestConstApi.BANNER_LIST);
  }
}
