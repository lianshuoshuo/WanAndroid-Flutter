import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

extension ExtState on State{
  void showToast(msg){
    Fluttertoast.showToast(msg: '$msg');
  }
}

extension StringExt on String{
   setTest(){

  }
}