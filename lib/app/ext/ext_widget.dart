import 'package:flutter/material.dart';
import 'package:flutter_wanandroid/widget/MyBehavior.dart';

///组件扩展函数
extension WidgetExt on Widget {
  Widget setMargin(EdgeInsetsGeometry margin) {
    return Container(
      margin: margin,
      child: this,
    );
  }

  ///去除滑动组件临界效果
  Widget closeScrollBehavior() {
    return ScrollConfiguration(behavior: MyBehavior(), child: this);
  }
}
