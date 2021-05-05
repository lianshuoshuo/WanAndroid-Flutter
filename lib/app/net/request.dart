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

  Future<dynamic> getCollectList(int page) async {
    return await get('lg/collect/list/$page/json');
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

  ///取消收藏
  Future unCollectMy(int id, int originId) async {
    var map = Map<String, dynamic>();
    map['originId'] = originId;
    return await post("lg/uncollect/$id/json", map);
  }

  ///个人积分获得列表
  Future myCoinList(int page) async {
    return await get("lg/coin/list/$page/json");
  }

  ///个人积分获得列表
  Future coinRink(int page) async {
    return await get("coin/rank/$page/json");
  }

  ///个人积分信息
  Future coinUserInfo() async {
    return await get(RequestConstApi.COIN_USER_INFO);
  }

  ///微信公众号
  Future getWxOfficialAccount() async {
    return await get(RequestConstApi.WX_THE_PUBLIC);
  }

  ///获取公众号下的文章
  Future<dynamic> getWxArticleList(int page, int cid) async {
    return await get("wxarticle/list/$cid/$page/json");
  }

  ///获取广场列表
  Future getSquareList(int page) async {
    return await get('user_article/list/$page/json');
  }

  ///获取问答列表
  Future getWendaList(int page) async {
    return await get('wenda/list/$page/json ');
  }

  ///自己的分享的文章列表
  Future getUserArticle(int page) async {
    return await get("user/lg/private_articles/$page/json");
  }
}
