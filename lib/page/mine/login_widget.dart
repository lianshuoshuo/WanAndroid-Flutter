import 'package:flutter/material.dart';

///登录模块
class LoginContainer extends StatelessWidget {
  final TextEditingController _nameEditCtl, _pwdEditCtl;

  LoginContainer(this._nameEditCtl, this._pwdEditCtl);

  @override
  Widget build(BuildContext context) {
    return Align(
        alignment: Alignment.topCenter,
        child: LoginBgContainer(
          height: 200,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              LoginTextField(
                  _nameEditCtl, EdgeInsets.fromLTRB(30, 20, 30, 0), '用户名'),
              LoginTextField(
                  _pwdEditCtl, EdgeInsets.fromLTRB(30, 20, 30, 20), '密码',
                  obscureText: true),
            ],
          ),
        ));
  }
}

///注册模块
class RegisterContainer extends StatelessWidget {
  final TextEditingController _nameEditCtl, _pwdEditCtl, _rePwdEditCtl;

  RegisterContainer(this._nameEditCtl, this._pwdEditCtl, this._rePwdEditCtl);

  @override
  Widget build(BuildContext context) {
    return LoginBgContainer(
      height: 300,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          LoginTextField(
              _nameEditCtl, EdgeInsets.fromLTRB(30, 20, 30, 0), '用户名'),
          LoginTextField(_pwdEditCtl, EdgeInsets.fromLTRB(30, 20, 30, 20), '密码',
              obscureText: true),
          LoginTextField(
              _rePwdEditCtl, EdgeInsets.fromLTRB(30, 0, 30, 20), '确定密码',
              obscureText: true),
        ],
      ),
    );
  }
}

///背景
class LoginBgContainer extends StatelessWidget {
  final Widget child;
  final double height;

  LoginBgContainer({this.child, this.height});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      margin: EdgeInsets.fromLTRB(40, 10, 40, 40),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(20)),
          color: Color(0xd2fcfcfc),
          boxShadow: [
            BoxShadow(
                color: Colors.black12,
                offset: Offset(3, 5),
                blurRadius: 10,
                spreadRadius: 1)
          ]),
      child: child,
    );
  }
}

///输入框
class LoginTextField extends StatelessWidget {
  final TextEditingController _editingController;

  final EdgeInsets _edgeInsets;

  final String _labelText;

  final bool obscureText;

  LoginTextField(this._editingController, this._edgeInsets, this._labelText,
      {this.obscureText = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: _edgeInsets,
      height: 50,
      child: TextField(
        controller: _editingController,
        obscureText: obscureText,
        decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
            labelText: _labelText),
      ),
    );
  }
}
