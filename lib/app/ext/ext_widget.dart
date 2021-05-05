import 'package:flutter/material.dart';

extension WidgetExt on Widget {
  Widget setMargin(EdgeInsetsGeometry margin) {
    return Container(
      margin: margin,
      child: this,
    );
  }
}
