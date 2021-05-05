import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget appBarWhite(String title) {
  return AppBar(
    iconTheme: IconThemeData(color: Colors.black),
    elevation: 0,
    backgroundColor: Colors.white,
    title: Text(
      title,
      style: TextStyle(
          color: Colors.black, fontSize: 16, fontWeight: FontWeight.w600),
    ),
    centerTitle: true,
  );
}
