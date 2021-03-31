import 'package:flutter/material.dart';
import 'package:flutter_wanandroid/app/provider/provider_widget.dart';
import 'package:flutter_wanandroid/model/login_model.dart';

import 'app/config/StorageManager.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    StorageManager.init();

    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: ProviderWidget<LoginViewModel>(
          model: LoginViewModel(),
          builder: (context, model, child) {
            return Scaffold(
              appBar: AppBar(
                title: Text("Flutter-WanAndroid"),
              ),
              body: Center(
                child: Column(
                  children: [
                    RaisedButton(
                      onPressed: () {
                        model.login('12314414@qq.com', '123456');
                      },
                      child: Text('Login'),
                    )
                  ],
                ),
              ),
            );
          },
        ));
  }
}
