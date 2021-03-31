import 'package:dio/dio.dart';
import 'package:flutter_wanandroid/app/net/request_const.dart';

import 'HttpHelper.dart';
import 'base_repository.dart';

class WanAndroidRepository extends BaseRepository {
  Dio dio = HttpHelper.instance.getDio();

  WanAndroidRepository() {
    setdio(dio);
  }

  Future<dynamic> login(String username, String password) async {
    var map = Map<String, dynamic>();
    map['username'] = username;
    map['password'] = password;
    return await post(RequestConstApi.LOGIN,map).then((value){
      return "sadas";
      // if(value.errorCode==0){
      //   return
      // }
    });
  }
}
