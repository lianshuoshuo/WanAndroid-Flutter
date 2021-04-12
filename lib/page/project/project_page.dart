import 'package:flutter/material.dart';
import 'package:flutter_wanandroid/model/user_model.dart';
import 'package:flutter_wanandroid/widget/banner.dart';

class ProjectPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return ProjectPageState();
  }
}

class ProjectPageState extends State<ProjectPage> {


  UserModel _userModel;

  @override
  void initState() {
    _userModel=UserModel();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child:CustomBanner([
        "https://img2.mukewang.com/szimg/6052ce88088b566212000676-360-202.jpg",
        "https://img2.mukewang.com/szimg/5f1eafb709e18bf912000676-360-202.png",
        "https://img2.mukewang.com/szimg/60615088090e62f501280072-360-202.png"
      ]),
    );
  }
}
