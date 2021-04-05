import 'package:flutter/material.dart';
import 'package:flutter_wanandroid/app/provider/provider_widget.dart';
import 'package:flutter_wanandroid/model/login_model.dart';
import 'package:flutter_wanandroid/widget/LoadingDialog.dart';
import 'package:flutter_wanandroid/widget/view_state_helper.dart';

import 'app/config/StorageManager.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); //初始化
  await StorageManager.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: ProviderWidget<LoginViewModel>(
          model: LoginViewModel(),
          builder: (context, LoginViewModel model, child) {
            return Scaffold(
              appBar: AppBar(
                title: Text("Flutter-WanAndroid"),
              ),
              body: Center(
                child: Column(
                  children: [
                    RaisedButton(
                      onPressed: () {
                        model.login('lian123', 'ls1234566').then((value) {
                          print('success==${value.username}');
                        }).catchError((e) {
                          print('error==${e.errorMsg.toString()}');
                        });
                      },
                      child: Text('Login'),
                    ),
                    Text(model.userEntity.username ?? "")
                  ],
                ),
              ),
            );
          },
        ));
  }
}
