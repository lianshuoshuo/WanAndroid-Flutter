import 'package:flutter/material.dart';
import 'package:flutter_wanandroid/model/user_model.dart';

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
      child: Text('项目===${_userModel.user.username}'),
    );
  }
}
