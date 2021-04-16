import 'dart:ffi';

import 'package:flutter/material.dart';

class InkContainer extends StatelessWidget {
  EdgeInsets margin;
  EdgeInsets padding;
  Color color;
  double height;
  double width;
  Widget child;


  InkContainer({this.margin, this.padding, this.color=Colors.white, this.height, this.width=double.infinity,
      this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: margin,
        padding: padding,
        child: Ink(color: color, height: height, child: child));
  }
}
