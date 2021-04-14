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
      'https://ss3.bdstatic.com/70cFv8Sh_Q1YnxGkpoWK1HF6hhy/it/u=1313854702,2705603849&fm=26&gp=0.jpg';
}
