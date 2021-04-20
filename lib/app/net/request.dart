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

  ///首页banner
  Future getBannerList() async {
    return await get(RequestConstApi.BANNER_LIST);
  }

  ///获取首页文章列表
  Future<dynamic> getArticleList(int page) async {
    return await get("article/list/$page/json");
  }

  ///根据类型
  Future<dynamic> getTreeArticleList(int page, int cid) async {
    return await get("article/list/$page/json?cid=$cid");
  }

  ///获取首页置顶文章列表
  Future<dynamic> getTopArticleList() async {
    return await get(RequestConstApi.TOP_ARTICLE_LIST);
  }

  ///体系
  Future<dynamic> getTree() async {
    return await get(RequestConstApi.TREE);
  }

  ///项目体系
  Future<dynamic> getProjectTree() async {
    return await get(RequestConstApi.PROJECT_TREE);
  }

  ///导航
  Future<dynamic> getNavi() async {
    return await get(RequestConstApi.NAVI);
  }

  ///项目体系
  Future<dynamic> getProjectTreeList(int page, int cid) async {
    return await get("project/list/$page/json?cid=$cid");
  }

  ///站内收藏
  Future collect(int id) async {
    return await post("lg/collect/$id/json", null);
  }
  ///取消收藏
  Future unCollect(int id) async {
    return await post("lg/uncollect_originId/$id/json", null);
  }
}
