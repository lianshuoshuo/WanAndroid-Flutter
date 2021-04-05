import 'package:flutter/material.dart';
import 'package:flutter_wanandroid/widget/list_widget.dart';

class ListPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return ListState();
  }
}

class ListState extends State<ListPage> {
  var dataList = [];

  var scrollController = ScrollController();

  int _page = 1;
  bool isLoading = false;

  @override
  void initState() {
    getData(0);
    scrollController.addListener(() {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        print('滑倒底部了.');
        getData(2);
      }
    });
    super.initState();
  }

  /// 初始化list数据 加延时模仿网络请求
  Future getData(int type) async {
    if (type == 0) {
      await Future.delayed(Duration(seconds: 2), () {
        setState(() {
          dataList = List.generate(15, (i) => '哈喽,我是原始数据 $i');
        });
      });
    } else if (type == 1) {
      await Future.delayed(Duration(seconds: 2), () {
        print('refresh');
        setState(() {
          dataList = List.generate(20, (index) => '刷新的数据$index');
        });
      });
    } else if (type == 2) {
      await Future.delayed(Duration(seconds: 1), () {
        print('loadMore');
        setState(() {
          dataList.addAll(List.generate(5, (index) => '上拉加载的数据$index'));
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ListView'),
      ),
      body: CommonListWidget(_buildItem, dataList, getData),
    );
  }

  Widget _buildItem(BuildContext context, int index) {
    return ListTile(
      title: Text("${dataList[index]}"),
    );
  }
}
