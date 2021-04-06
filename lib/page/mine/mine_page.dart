import 'package:flutter/material.dart';
import 'package:flutter_wanandroid/app/router/routers.dart';

class MinePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return MinePageState();
  }
}

class MinePageState extends State<MinePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('我的'),
      ),
      body: Column(
        children: [
          TextButton(
              onPressed: () {
                Navigator.of(context).pushNamed(routers.LOGIN);
              },
              child: Text('登录'))
        ],
      ),
    );
  }
}
