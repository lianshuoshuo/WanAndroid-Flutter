import 'dart:ui';

import 'package:flutter/material.dart';

///登录
class LoginPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => LoginState();
}

class LoginState extends State<LoginPage> with SingleTickerProviderStateMixin {
  final tabs = [];
  TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        color: Colors.white,
        padding:
            EdgeInsets.only(top: MediaQueryData.fromWindow(window).padding.top),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                alignment: Alignment.centerLeft,
                child: CloseButton(),
              ),
              Padding(
                padding: EdgeInsets.only(top: 100),
                child: FlutterLogo(
                  size: 50,
                ),
              ),
              _buildTabBar(),
              Expanded(
                flex: 2,
                child: _buildTabBarView(),
              ),
              MaterialButton(
                onPressed: () {},
                color: Colors.blue,
                textColor: Colors.white,
                child: Text('登录'),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20))),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget loginType() {
    return Column(
      children: [],
    );
  }

  Widget _buildTabBar() => TabBar(
        labelStyle: TextStyle(fontSize: 16),
        unselectedLabelStyle: TextStyle(fontSize: 16),
        isScrollable: true,
        labelColor: Colors.blue,
        unselectedLabelColor: Colors.grey,
        indicatorWeight: 0,
        indicator: BoxDecoration(),
        controller: _tabController,
        tabs: [
          Tab(
            text: '登录',
          ),
          Tab(
            text: '注册',
          ),
        ],
      );

  Widget _buildTabBarView() => TabBarView(
        children: [loginInput(), loginInput()],
        controller: _tabController,
      );

  Widget loginInput() {
    return Container(
      height: 300,
      margin: EdgeInsets.fromLTRB(20, 50, 40, 40),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(20)),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
                color: Colors.blue,
                offset: Offset(5, 5),
                blurRadius: 15,
                spreadRadius: 1)
          ]),
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.fromLTRB(20, 20, 20, 0),
            height: 50,
            child: TextField(
              decoration: InputDecoration(
                  border: OutlineInputBorder(), labelText: 'username'),
            ),
          ),
          Container(
            margin: EdgeInsets.fromLTRB(20, 20, 20, 20),
            height: 50,
            child: TextField(
              obscureText: true,
              decoration: InputDecoration(
                  border: OutlineInputBorder(), labelText: 'password'),
            ),
          ),
        ],
      ),
    );
  }
}
