import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_wanandroid/app/provider/provider_widget.dart';
import 'package:flutter_wanandroid/model/project_tree_model.dart';
import 'package:loading_indicator_view/loading_indicator_view.dart';

import 'project_list_page.dart';

class ProjectPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return ProjectPageState();
  }
}

class ProjectPageState extends State<ProjectPage> {
  ValueNotifier<int> currentIndex;
  PageController _pageController;

  @override
  void initState() {
    currentIndex = ValueNotifier(0);
    _pageController = PageController(initialPage: 0);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: Text(
          '项目',
          style: TextStyle(
              color: Colors.black, fontSize: 16, fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
      ),
      body: ProviderWidget<ProjectTreeViewModel>(
          initData: (model) {
            model.getTree();
          },
          model: ProjectTreeViewModel(),
          builder: (_, model, chlid) {
            if (model.isLoading())
              return Center(
                child: BallPulseRiseIndicator(
                  color: Colors.lightBlue,
                ),
              );
            return Container(
              height: double.infinity,
              child: Row(
                children: [
                  Expanded(flex: 1, child: _buildLeftItem(model)),
                  VerticalDivider(color: Color(0xffe8e8e8),
                  width: 1,
                  indent: 0,
                  endIndent: 0,),
                  Expanded(flex: 4, child: _buildRightPageView(model))
                ],
              ),
            );
          }),
    );
  }

  Widget _buildLeftItem(model) {
    var treeList = model.treeList;
    return ListView.builder(
        itemCount: treeList.length,
        itemBuilder: (context, index) {
          return ValueListenableBuilder(
              valueListenable: currentIndex,
              builder: (_, value, child) {
                return Ink(
                  color: index == value ? Colors.black12 : Colors.white,
                  child: InkWell(
                    onTap: () {
                      currentIndex.value = index;
                      _pageController.jumpToPage(index);
                    },
                    child: Container(
                      height: 50,
                      alignment: Alignment.center,
                      child: AutoSizeText(treeList[index].name,maxLines: 1,),
                    ),
                  ),
                );
              });
        });
  }

  Widget _buildRightPageView(ProjectTreeViewModel model) {
    var treeList = model.treeList;
    return PageView.builder(
        itemCount: treeList.length,
        scrollDirection: Axis.vertical,
        controller: _pageController,
        onPageChanged: (index) {
          currentIndex.value = index;
        },
        itemBuilder: (_, index) {
          return ProjectListPage(treeList[index].id);
        });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }
}
