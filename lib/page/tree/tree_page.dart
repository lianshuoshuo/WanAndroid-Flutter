import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_wanandroid/page/navi/navi_page.dart';
import 'package:flutter_wanandroid/page/tree/tree_tree_page.dart';

class TreePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return TreePageState();
  }
}

class TreePageState extends State<TreePage>
    with SingleTickerProviderStateMixin {
  List<String> _tabStr = ['体系', '导航'];
  TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(length: _tabStr.length, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: TabBar(
            indicatorSize: TabBarIndicatorSize.label,
            indicatorColor: Colors.black,
            controller: _tabController,
            labelColor: Colors.black,
            unselectedLabelColor: Colors.black54,
            tabs: _tabStr
                .map((e) => Tab(
                      text: e,
                    ))
                .toList()),
        // title: Text(
        //   '体系',
        //   style: TextStyle(
        //       color: Colors.black, fontSize: 16, fontWeight: FontWeight.w600),
        // ),
        centerTitle: true,
      ),
      body: TabBarView(controller: _tabController, children: [
        TreeChildPage(),
        NavigatePage(),
      ]),
    );
  }
}
