import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return HomePageState();
  }
}

class HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 500,
      color: Colors.amber,
      child:Center(child:  Container(
        height: 300,
        color: Colors.blue,
      ),),
    );
  }
}
