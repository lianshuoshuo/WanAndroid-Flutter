import 'package:flutter/material.dart';
import 'package:flutter_wanandroid/app/provider/provider_widget.dart';
import 'package:flutter_wanandroid/model/collect_model.dart';

class CollectPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => CollectState();
}

class CollectState extends State<CollectPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('收藏'),
      ),
      body: ProviderWidget<CollectViewModel>(
          initData: (model) {
            model.getList();
          },
          model: CollectViewModel(),
          builder: (context, model, child) {
            return Column();
          }),
    );
  }
}
