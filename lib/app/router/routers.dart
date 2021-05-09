import 'package:flutter/material.dart';
import 'package:flutter_wanandroid/app/GlobalConfig.dart';
import 'package:flutter_wanandroid/page/home/search_page.dart';
import 'package:flutter_wanandroid/page/main_page.dart';
import 'package:flutter_wanandroid/page/mine/coin_rink_page.dart';
import 'package:flutter_wanandroid/page/mine/collect_page.dart';
import 'package:flutter_wanandroid/page/mine/history_record_page.dart';
import 'package:flutter_wanandroid/page/mine/login_page.dart';
import 'package:flutter_wanandroid/page/mine/mine_info_page.dart';
import 'package:flutter_wanandroid/page/mine/my_article_page.dart';
import 'package:flutter_wanandroid/page/mine/my_coin_page.dart';
import 'package:flutter_wanandroid/page/mine/setting_page.dart';
import 'package:flutter_wanandroid/page/tree/tab_page.dart';
import 'package:flutter_wanandroid/page/web_page.dart';

class routers {
  static const String LOGIN = "/login";///登录
  static const String SETTING = "/setting";///设置
  static const String COLLECT = "/collect";///收藏
  static const String MY_COIN = "/my_coin";///我的积分
  static const String MY_ARTICLE = "/my_article";///我的文章
  static const String COIN_RINK = "/coin_rink";///积分排行
  static const String WEB = "/web";///h5
  static const String TREE_TAB = "/TreeTabPage";///体系tab
  static const String MINE_INFO_PAGE = "/MineInfoPage";///个人界面
  static const String SEARCH_PAGE = "/SearchPage";///搜索界面
  static const String HISTORY_RECORD_PAGE = "/HistoryRecordPage";///搜索界面
}

///路由管理
class MyRouters {
  static final Map<String, WidgetBuilder> _routes = {
    "/": (BuildContext context, {Object args}) => MainPage(),
    routers.SETTING: (BuildContext context, {Object args}) => SettingPage(),
    routers.COLLECT: (BuildContext context, {Object args}) => CollectPage(),
    routers.LOGIN: (BuildContext context, {Object args}) => LoginPage(),
    routers.WEB: (BuildContext context, {Object args}) => WebPage(),
    routers.TREE_TAB: (BuildContext context, {Object args}) => TreeTabPage(),
    routers.MY_COIN: (BuildContext context, {Object args}) => CoinPage(),
    routers.COIN_RINK: (BuildContext context, {Object args}) => CoinRinkPage(),
    routers.MY_ARTICLE: (BuildContext context, {Object args}) => MyArticle(),
    routers.MINE_INFO_PAGE: (BuildContext context, {Object args}) => MineInfoPage(),
    routers.SEARCH_PAGE: (BuildContext context, {Object args}) => SearchPage(),
    routers.HISTORY_RECORD_PAGE: (BuildContext context, {Object args}) => HistoryRecordPage(),
  };

  static MyRouters _singleton;

  MyRouters._internal();

  factory MyRouters() {
    if (_singleton == null) {
      _singleton = MyRouters._internal();
    }
    return _singleton;
  }

  /// 监听route
  Route getRoutes(RouteSettings settings) {
    String routeName = routeBeforeHook(settings);

    final Function builder = MyRouters._routes[routeName];
    print(settings);

    if (builder == null) {
      return null;
    } else {
      return MaterialPageRoute(
          settings: settings,
          builder: (BuildContext context) =>
              builder(context, args: settings.arguments));
    }
  }

  String routeBeforeHook(RouteSettings settings) {
    /// Global.prefs 是全局的 SharedPreferences 实例
    /// SharedPreferences 是常用的本地存储的插件
    final token = GlobalConfig.userModel.user ?? null;
    if (token == null) {
      if (settings.name == routers.SETTING) {
        return routers.LOGIN;
      }
      return settings.name;
    }
    return settings.name;
  }
}
