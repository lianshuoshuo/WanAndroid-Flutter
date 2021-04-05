import 'package:flutter/material.dart';

class CommonListWidget extends StatefulWidget {
  final Function(BuildContext context, int index) _itemWidget;

 final dynamic dataList;

 final Function(int type) requestList;

  CommonListWidget(this._itemWidget, this.dataList, this.requestList);

  @override
  State<StatefulWidget> createState() => CommonListState();
}

class CommonListState extends State<CommonListWidget> {
  ///防止多次触发
  bool isLoading = false;

  var scrollController = ScrollController();

  @override
  void initState() {
    scrollController.addListener(() {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        print('滑倒底部了.');
        loadMore();
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
        child: ListView.builder(
          itemBuilder: buildItem,
          itemCount: widget.dataList.length + 1,
          controller: scrollController,
        ),
        onRefresh: refreshData);
  }

  ///添加 加载更多view
  Widget buildItem(BuildContext context, int index) {
    if (index < widget.dataList.length) {
      return widget._itemWidget(context, index);
    }
    return buildMoreWidget();
  }

  ///刷新
  Future refreshData() {
    return widget.requestList(1);
  }

  ///加载更多
  Future loadMore() async {
    if (!isLoading) {
      setState(() {
        isLoading = true;
      });
    }
    widget.requestList(2);
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }
}

///加载更多 view
Widget buildMoreWidget() {
  return Center(
    child: Padding(
      padding: EdgeInsets.all(5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text('加载中...'),
          LimitedBox(
            maxHeight: 15,
            maxWidth: 15,
            child: CircularProgressIndicator(
              strokeWidth: 1,
            ),
          )
        ],
      ),
    ),
  );
}
