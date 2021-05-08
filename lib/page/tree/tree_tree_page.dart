import 'package:flutter/material.dart';
import 'package:flutter_wanandroid/app/provider/provider_widget.dart';
import 'package:flutter_wanandroid/app/router/routers.dart';
import 'package:flutter_wanandroid/model/tree_model.dart';
import 'package:loading_indicator_view/loading_indicator_view.dart';

class TreeChildPage extends StatefulWidget {
  @override
  _State createState() => _State();
}

class _State extends State<TreeChildPage> with AutomaticKeepAliveClientMixin{
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    return ProviderWidget<TreeViewModel>(
        initData: (model) {
          model.getTree();
        },
        model: TreeViewModel(),
        builder: (context, model, child) {
          if (model.isLoading())
            return Center(
              child: LineScaleIndicator(
                lineColor: Colors.lightBlue,
              ),
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
                              var map = Map<String, dynamic>();
                              map['pageType'] = 0;
                              map['datas'] = tree.children;
                              map['pageName'] = tree.name;
                              Navigator.of(context)
                                  .pushNamed(routers.TREE_TAB, arguments: map);
                            });
                      }),
                    )
                  ],
                ),
              );
            },
            itemCount: treeList.length,
          );
        });
  }
}
