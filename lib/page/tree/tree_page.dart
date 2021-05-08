import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_wanandroid/page/navi/navi_page.dart';
import 'package:flutter_wanandroid/page/tree/tree_tree_page.dart';

///体系结构
class TreePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return TreePageState();
  }
}

class TreePageState extends State<TreePage>
    with SingleTickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  List<String> _tabStr = ['体系', '导航'];
  TabController _tabController;
  PageController _pageController;

  @override
  void initState() {
    _tabController = TabController(length: _tabStr.length, vsync: this);
    _pageController = PageController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: TabBar(
            onTap: (index) {
              _pageController.jumpToPage(index);
            },
            indicatorSize: TabBarIndicatorSize.label,
            indicatorColor: Colors.black,
            controller: _tabController,
            labelColor: Colors.black,
            unselectedLabelColor: Colors.black54,
            labelStyle: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            unselectedLabelStyle: TextStyle(fontSize: 18),
            tabs: _tabStr
                .map((e) => Tab(
                      text: e,
                    ))
                .toList()),
        centerTitle: true,
      ),
      body: PageView(
          onPageChanged: (index) {
            _tabController.animateTo(index);
          },
          controller: _pageController,
          children: [
            TreeChildPage(),
            NavigatePage(),
          ]),
    );
  }

  @override
  bool get wantKeepAlive => true;

  @override
  void dispose() {
    _tabController.dispose();
    _pageController.dispose();
    super.dispose();
  }
}
