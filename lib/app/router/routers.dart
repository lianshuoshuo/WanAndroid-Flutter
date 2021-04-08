import 'package:flutter/material.dart';
import 'package:flutter_wanandroid/app/GlobalConfig.dart';
import 'package:flutter_wanandroid/page/main_page.dart';
import 'package:flutter_wanandroid/page/mine/collect_page.dart';
import 'package:flutter_wanandroid/page/mine/login_page.dart';
import 'package:flutter_wanandroid/page/mine/setting_page.dart';

class routers {
  static const String LOGIN = "/login";
  static const String SETTING = "/setting";
  static const String COLLECT = "/collect";
}

///路由管理
class MyRouters {
  static final Map<String, WidgetBuilder> _routes = {
    "/": (BuildContext context, {Object args}) => MainPage(),
    routers.SETTING: (BuildContext context, {Object args}) => SettingPage(),
    routers.COLLECT: (BuildContext context, {Object args}) => CollectPage(),
    routers.LOGIN: (BuildContext context, {Object args}) => LoginPage(),
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
