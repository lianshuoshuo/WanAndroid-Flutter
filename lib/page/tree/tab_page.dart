import 'package:flutter/material.dart';
import 'package:flutter_wanandroid/entity/tree_entity.dart';
import 'package:flutter_wanandroid/page/tree/article_list_page.dart';

///通用tab
class TreeTabPage extends StatefulWidget {
  @override
  _TreeTabPageState createState() => _TreeTabPageState();
}

class _TreeTabPageState extends State<TreeTabPage>
    with SingleTickerProviderStateMixin {
  bool isFirst = true;

  ///是否首次打开
  int pageType = 0;

  ///页面类型
  String pageName = '';

  ///页面title
  List<TreeEntity> _tree;
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
      Map arguments = ModalRoute.of(context).settings.arguments;
      _tree = arguments['datas'];
      pageType = arguments['pageType'];
      pageName = arguments['pageName'];
      _tabController = TabController(length: _tree.length, vsync: this);
      _pageController = PageController();
      isFirst = false;
    }
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        elevation: 0,
        backgroundColor: Colors.white,
        title: Text(
          pageName,
          style: TextStyle(
              color: Colors.black, fontSize: 16, fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
        bottom: _buildTab(),
      ),
      body: _buildTabView(),
      // body: ,
    );
  }

  Widget _buildTab() {
    return TabBar(
        isScrollable: true,
        indicatorColor: Colors.black,
        labelColor: Colors.black,
        unselectedLabelColor: Colors.black54,
        controller: _tabController,
        onTap: (index) {
          _pageController.jumpToPage(index);
        },
        tabs: _tree
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
        children: List.generate(_tree.length,
            (index) => ArticleListPage(_tree[index].id, pageType)));
  }
}
