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

  static const String DEFAULT_AVATAR =
      'https://ss2.bdstatic.com/70cFvnSh_Q1YnxGkpoWK1HF6hhy/it/u=1666256797,972082711&fm=26&gp=0.jpg';

  static const String USER_AVATAR =
      'https://ss1.baidu.com/9vo3dSag_xI4khGko9WTAnF6hhy/zhidao/wh%3D450%2C600/sign=a587b23df11f3a295a9dddcaac159007/500fd9f9d72a60590cfef2f92934349b023bba62.jpg';
}
