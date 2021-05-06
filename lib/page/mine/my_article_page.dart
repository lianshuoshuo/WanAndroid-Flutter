import 'package:flutter/material.dart';
import 'package:flutter_wanandroid/widget/app_bar_white.dart';

class MyArticle extends StatefulWidget {
  @override
  _MyArticleState createState() => _MyArticleState();
}

class _MyArticleState extends State<MyArticle> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarWhite('我的文章'),
      body: Container(
          padding: EdgeInsets.all(10),
          child: Stack(
            children: [
              Container(
                color: Colors.white,
                child: ListTile(
                  title: Text('cedsd'),
                  subtitle: Text('sdad'),
                  leading: CloseButton(),
                  trailing: FlutterLogo(),
                ),
              ),
              Positioned(
                  left: 0,
                  right: 0,
                  top: 0,
                  bottom: 0,
                  child: Container(
                    color: Colors.black12,
                    child: FlutterLogo(),
                  ))
            ],
          )),
    );
  }
}
