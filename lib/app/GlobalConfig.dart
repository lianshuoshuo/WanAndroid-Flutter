import 'package:flutter/material.dart';
import 'package:flutter_wanandroid/model/user_model.dart';

/*
 *系统主题设置，包括系统默认字体 背景色等
 */
class GlobalConfig {
  static bool isDebug = true; //是否是调试模式

  static UserModel userModel = new UserModel();

 static final GlobalKey<NavigatorState> navigatorKey =
      new GlobalKey<NavigatorState>();
}
