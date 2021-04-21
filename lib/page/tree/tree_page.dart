import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_wanandroid/app/provider/provider_widget.dart';
import 'package:flutter_wanandroid/app/router/routers.dart';
import 'package:flutter_wanandroid/model/tree_model.dart';
import 'package:flutter_wanandroid/widget/view_state_helper.dart';
import 'package:loading_indicator_view/loading_indicator_view.dart';

class TreePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return TreePageState();
  }
}

class TreePageState extends State<TreePage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: Text(
          '体系',
          style: TextStyle(
              color: Colors.black, fontSize: 16, fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
      ),
      body: ProviderWidget<TreeViewModel>(
          initData: (model) {
            model.getTree();
          },
          model: TreeViewModel(),
          builder: (context, model, child) {
            if (model.isLoading()) return Center(
              child: BallPulseRiseIndicator(color: Colors.lightBlue,),
            );
            var treeList = model.treeList;
            return ListView.builder(
              itemBuilder: (context, index) {
                var tree = treeList[index];
                return Container(
                  margin: EdgeInsets.only(left: 20, right: 20, top: 20),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        treeList[index].name,
                        style: TextStyle(fontSize: 17),
                      ),
                      Wrap(
                        spacing: 10,
                        children: List.generate(tree.children.length, (index) {
                          return ActionChip(
                              label: Text(tree.children[index].name,
                                  style: TextStyle(
                                      fontSize: 14, color: Color(0xff666666))),
                              onPressed: () {
                                Navigator.of(context).pushNamed(
                                    routers.TREE_TAB,
                                    arguments: tree);
                              });
                        }),
                      )
                    ],
                  ),
                );
              },
              itemCount: treeList.length,
            );
          }),
    );
  }
}
