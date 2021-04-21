import 'package:flutter/material.dart';
import 'package:flutter_wanandroid/app/provider/provider_widget.dart';
import 'package:flutter_wanandroid/model/login_model.dart';
import 'package:provider/provider.dart';

class SettingPage extends StatefulWidget {
  @override
  _SettingPageState createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffe8e8e8),
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        elevation: 0,
        backgroundColor: Colors.white,
        title: Text(
          '设置',
          style: TextStyle(
              color: Colors.black, fontSize: 16, fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
      ),
      body: ProviderWidget<LoginViewModel>(
          model: LoginViewModel(),
          builder: (_, model, child) {
            return Column(
              children: [
                Container(
                  margin: EdgeInsets.only(top: 10),
                  child: Ink(
                    color: Colors.white,
                    child: ListTile(
                      onTap: () {
                        _alertDialog(context, model);
                      },
                      title: Center(
                        child: Text(
                          '退出登录',
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
                    ),
                  ),
                )
              ],
            );
          }),
    );
  }

  Widget buildItem() {
    return null;
  }

  _alertDialog(mContext, LoginViewModel model) async {
    var alertDialogs = await showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("提示"),
            content: Text("确定要退出登录吗"),
            actions: <Widget>[
              FlatButton(
                  child: Text("取消"),
                  onPressed: () {
                    Navigator.pop(context, "cancel");
                  }),
              FlatButton(
                  child: Text("确定"),
                  onPressed: () {
                    Navigator.pop(context, "ok");
                    model.logout().then((value) {});
                  }),
            ],
          );
        });
    return alertDialogs;
  }
}
