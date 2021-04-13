import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_wanandroid/app/GlobalConfig.dart';

import 'app/config/StorageManager.dart';
import 'app/router/routers.dart';

final MyRouters _myRouters = new MyRouters();

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); //初始化
  await StorageManager.init();
  ///沉浸
  if(Platform.isAndroid) {
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: Colors.transparent));
  }
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      navigatorKey: GlobalConfig.navigatorKey,
      title: 'wan-android-flutter',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      onGenerateRoute: _myRouters.getRoutes,
    );
  }
}
