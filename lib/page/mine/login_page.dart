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
  PageController _pageController;
  String btText = '登录';

  Matrix4 _matrix4;
  ValueNotifier<Matrix4> _matrixValue;

  double y = -70;

  @override
  void initState() {
    _matrix4 = Matrix4.translationValues(0, y, 0);
    _matrixValue = ValueNotifier(_matrix4);
    _tabController = TabController(length: 2, vsync: this);
    _pageController = PageController();
    _pageController.addListener(() {
      y = (_pageController.offset / 10) - 70;
      _matrixValue.value = Matrix4.translationValues(0, y, 0);
      btText = _tabController.index == 0 ? '登录' : '注册';
    });
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
              Padding(
                padding: EdgeInsets.only(top: 20),
                child: _buildTabBar(),
              ),
              Container(
                height: 300,
                child: _buildTabBarView(),
              ),
              ValueListenableBuilder(
                  valueListenable: _matrixValue,
                  builder: (context, value, child) {
                    return Transform(
                        transform: value,
                        child: MaterialButton(
                          onPressed: () {},
                          color: Colors.blue,
                          textColor: Colors.white,
                          child: Text(btText),
                          shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20))),
                        ));
                  }),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTabBar() => TabBar(
        labelStyle: TextStyle(fontSize: 20),
        unselectedLabelStyle: TextStyle(fontSize: 16),
        isScrollable: true,
        labelColor: Colors.blue,
        unselectedLabelColor: Colors.grey,
        indicatorWeight: 0,
        indicator: BoxDecoration(),
        controller: _tabController,
        onTap: (index) {
          _pageController.animateToPage(index,
              duration: Duration(milliseconds: 500), curve: Curves.ease);
        },
        tabs: [
          Tab(
            text: '登录',
          ),
          Tab(
            text: '注册',
          ),
        ],
      );

  Widget _buildTabBarView() => PageView(
      controller: _pageController,
      children: [loginInput(), registerInput()],
      onPageChanged: (index) {
        _tabController.animateTo(index);
      });

  Widget loginInput() {
    return Align(
      alignment: Alignment.topCenter,
      child: Container(
        height: 200,
        margin: EdgeInsets.fromLTRB(40, 10, 40, 40),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(20)),
            color: Color(0xfafcfcfc),
            boxShadow: [
              BoxShadow(
                  color: Colors.black12,
                  offset: Offset(3, 5),
                  blurRadius: 10,
                  spreadRadius: 1)
            ]),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              margin: EdgeInsets.fromLTRB(20, 20, 20, 0),
              height: 50,
              child: TextField(
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                    labelText: '用户名'),
              ),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(20, 20, 20, 20),
              height: 50,
              child: TextField(
                obscureText: true,
                decoration: InputDecoration(
                    border: OutlineInputBorder( borderRadius: BorderRadius.all(Radius.circular(10)),), labelText: '密码'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget registerInput() {
    return Container(
      height: 300,
      margin: EdgeInsets.fromLTRB(40, 10, 40, 40),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(20)),
          color: Color(0xfafcfcfc),
          boxShadow: [
            BoxShadow(
                color: Colors.black12,
                offset: Offset(3, 5),
                blurRadius: 10,
                spreadRadius: 1)
          ]),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            margin: EdgeInsets.fromLTRB(20, 20, 20, 0),
            height: 50,
            child: TextField(
              decoration: InputDecoration(
                  border: OutlineInputBorder( borderRadius: BorderRadius.all(Radius.circular(10)),), labelText: '用户名'),
            ),
          ),
          Container(
            margin: EdgeInsets.fromLTRB(20, 20, 20, 20),
            height: 50,
            child: TextField(
              obscureText: true,
              decoration: InputDecoration(
                  border: OutlineInputBorder( borderRadius: BorderRadius.all(Radius.circular(10)),), labelText: '密码'),
            ),
          ),
          Container(
            margin: EdgeInsets.fromLTRB(20, 0, 20, 20),
            height: 50,
            child: TextField(
              obscureText: true,
              decoration: InputDecoration(
                  border: OutlineInputBorder( borderRadius: BorderRadius.all(Radius.circular(10)),), labelText: '确定密码'),
            ),
          ),
        ],
      ),
    );
  }
}
