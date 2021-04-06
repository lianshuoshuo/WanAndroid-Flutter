import 'package:flutter/material.dart';

import 'app/config/StorageManager.dart';
import 'app/router/routers.dart';

final MyRouters _myRouters = new MyRouters();

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); //初始化
  await StorageManager.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'wan-android-flutter',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      onGenerateRoute: _myRouters.getRoutes,
    );
  }
}
