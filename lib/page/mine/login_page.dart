import 'dart:ui';

import 'package:animatedloginbutton/animatedloginbutton.dart';
import 'package:flutter/material.dart';
import 'package:flutter_wanandroid/app/provider/provider_widget.dart';
import 'package:flutter_wanandroid/model/login_model.dart';
import 'package:flutter_wanandroid/page/mine/login_widget.dart';
import 'package:flutter_wanandroid/widget/MyBehavior.dart';
import 'package:fluttertoast/fluttertoast.dart';

///登录
class LoginPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => LoginState();
}

class LoginState extends State<LoginPage> with SingleTickerProviderStateMixin {
  TextEditingController _nameEditCtl, _pwdEditCtl, _rePwdEditCtl;
  final LoginErrorMessageController loginErrorMessageController =
      LoginErrorMessageController();

  final LoginErrorMessageController loginErrorMessageController2 =
      LoginErrorMessageController();
  TabController _tabController;
  PageController _pageController;
  String btText = '登录';

  Matrix4 _matrix4;
  ValueNotifier<Matrix4> _matrixValue;
  double y = -70;

  @override
  void initState() {
    _nameEditCtl = TextEditingController();
    _pwdEditCtl = TextEditingController();
    _rePwdEditCtl = TextEditingController();

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
        padding:
            EdgeInsets.only(top: MediaQueryData.fromWindow(window).padding.top),
        decoration: BoxDecoration(
            image: DecorationImage(
          fit: BoxFit.cover,
          image: AssetImage('assets/images/login_bg.jpg'),
        )),
        child: ScrollConfiguration(
          behavior: MyBehavior(),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  alignment: Alignment.centerLeft,
                  child: CloseButton(
                    color: Colors.white,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 100),
                  child: FlutterLogo(
                    size: 50,
                  ),
                ),
                ProviderWidget(
                  model: LoginViewModel(),
                  builder: (context, LoginViewModel model, child) {
                    return Column(
                      children: [
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
                                  child: AnimatedLoginButton(
                                    loginTip: btText,
                                    loginErrorMessageController:
                                        loginErrorMessageController,
                                    onTap: () async {
                                      {
                                        if (_pageController.page == 0) {
                                          await model
                                              .login(_nameEditCtl.text,
                                                  _pwdEditCtl.text)
                                              .then((value) {
                                            Fluttertoast.showToast(msg: '登录成功');
                                            Navigator.of(context).pop();
                                          }).catchError((e) {
                                            loginErrorMessageController
                                                .showErrorMessage(e.errorMsg);
                                          });
                                        } else {
                                          await model
                                              .register(
                                                  _nameEditCtl.text,
                                                  _pwdEditCtl.text,
                                                  _rePwdEditCtl.text)
                                              .then((value) {
                                            Fluttertoast.showToast(msg: '注册成功');
                                            Navigator.of(context).pop();
                                          }).catchError((e) {
                                            loginErrorMessageController
                                                .showErrorMessage(e.errorMsg);
                                          });
                                        }
                                      }
                                    },
                                  ));
                            }),
                      ],
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTabBar() => TabBar(
        labelStyle: TextStyle(fontSize: 22),
        unselectedLabelStyle: TextStyle(fontSize: 18),
        isScrollable: true,
        labelColor: Colors.white,
        unselectedLabelColor: Colors.white60,
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
    return LoginContainer(_nameEditCtl, _pwdEditCtl);
  }

  Widget registerInput() {
    return RegisterContainer(_nameEditCtl, _pwdEditCtl, _rePwdEditCtl);
  }

  @override
  void dispose() {
    _tabController.dispose();
    _pageController.dispose();
    super.dispose();
  }
}
