import 'package:flutter/material.dart';
import 'package:flutter_wanandroid/widget/app_bar_white.dart';

class WxAccountPage extends StatefulWidget {
  @override
  _WxAccountPageState createState() => _WxAccountPageState();
}

class _WxAccountPageState extends State<WxAccountPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarWhite('公众号'),
    );
  }
}
