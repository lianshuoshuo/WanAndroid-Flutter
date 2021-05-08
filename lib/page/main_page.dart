import 'package:flutter/material.dart';
import 'package:flutter_wanandroid/app/ext/ext_widget.dart';
import 'package:flutter_wanandroid/page/home/home_page.dart';
import 'package:flutter_wanandroid/page/mine/mine_page.dart';
import 'package:flutter_wanandroid/page/project/project_page.dart';
import 'package:flutter_wanandroid/page/tree/tree_page.dart';

import 'navi/find_page.dart';

///主界面
class MainPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => MainState();
}

class MainState extends State<MainPage> {
  ValueNotifier<int> _currentIndex;

  PageController _pageController;

  final List<Widget> _pageList = [
    HomePage(),
    TreePage(),
    FindPage(),
    ProjectPage(),
    MinePage(),
  ];

  final List<BottomNavigationBarItem> _bottomItemList = [
    BottomNavigationBarItem(icon: Icon(Icons.home), label: '首页'),
    BottomNavigationBarItem(icon: Icon(Icons.account_tree), label: '体系'),
    BottomNavigationBarItem(icon: Icon(Icons.alt_route), label: '发现'),
    BottomNavigationBarItem(icon: Icon(Icons.description), label: '项目'),
    BottomNavigationBarItem(icon: Icon(Icons.person), label: '我的'),
  ];

  @override
  void initState() {
    _currentIndex = ValueNotifier(0);
    _pageController = PageController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        children: _pageList,
        onPageChanged: (index) {
          _currentIndex.value = index;
        },
      ).closeScrollBehavior(),
      bottomNavigationBar: ValueListenableBuilder(
          valueListenable: _currentIndex,
          builder: (context, value, child) {
            return BottomNavigationBar(
              backgroundColor: Colors.white,
              type: BottomNavigationBarType.fixed,
              selectedItemColor: Colors.black,
              unselectedItemColor: Colors.black45,
              items: _bottomItemList,
              currentIndex: _currentIndex.value,
              onTap: _changeTab,
            );
          }),
    );
  }

  void _changeTab(index) {
    if (index != _currentIndex) {
      _pageController.jumpToPage(index);
      _currentIndex.value = index;
    }
  }
}
