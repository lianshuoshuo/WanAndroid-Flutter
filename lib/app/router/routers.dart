import 'package:flutter/material.dart';
import 'package:flutter_wanandroid/page/main_page.dart';

///路由管理
class MyRouters{
  static final Map<String,WidgetBuilder> _routes={
    "/": (BuildContext context, {Object args}) => MainPage(),
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
    String routeName = settings.name;
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
}