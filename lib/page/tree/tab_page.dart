import 'package:flutter/material.dart';
import 'package:flutter_wanandroid/entity/tree_entity.dart';
import 'package:flutter_wanandroid/page/tree/article_list_page.dart';

class TreeTabPage extends StatefulWidget {
  @override
  _TreeTabPageState createState() => _TreeTabPageState();
}

class _TreeTabPageState extends State<TreeTabPage>
    with SingleTickerProviderStateMixin {

  bool isFirst = true;
  TreeEntity _tree;
  TabController _tabController;
  PageController _pageController;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    if (isFirst) {
      _tree = ModalRoute.of(context).settings.arguments;
      _tabController =
          TabController(length: _tree.children.length, vsync: this);
      _pageController = PageController();
      isFirst = false;
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(_tree.name),
        bottom: _buildTab(),
      ),
      body: _buildTabView(),
      // body: ,
    );
  }

  Widget _buildTab() {
    return TabBar(
        isScrollable: true,
        controller: _tabController,
        onTap: (index) {
          _pageController.jumpToPage(index);
        },
        tabs: _tree.children
            .map((e) => Tab(
                  text: e.name,
                ))
            .toList());
  }

  Widget _buildTabView() {
    return PageView(
        controller: _pageController,
        onPageChanged: (index) {
          _tabController.animateTo(index);
        },
        children: List.generate(_tree.children.length,
            (index) => ArticleListPage(_tree.children[index].id)));
  }
}
