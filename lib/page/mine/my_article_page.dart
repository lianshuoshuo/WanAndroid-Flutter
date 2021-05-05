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
          color: Colors.lightGreen,
          child: MediaQuery.removePadding(
              context: context,
              removeBottom: true,
              removeTop: true,
              child: ListView(
                shrinkWrap: true,
                children: [Text("sdada")],
              ))),
    );
  }
}
