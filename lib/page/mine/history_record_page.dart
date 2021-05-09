import 'package:flutter/material.dart';
import 'package:flutter_wanandroid/app/provider/provider_widget.dart';
import 'package:flutter_wanandroid/entity/article_db.dart';
import 'package:flutter_wanandroid/model/db_dao/article_dao.dart';
import 'package:flutter_wanandroid/model/history_model.dart';
import 'package:flutter_wanandroid/widget/app_bar_white.dart';
import 'package:flutter_wanandroid/widget/custom_refresh_widget.dart';
import 'package:flutter_wanandroid/widget/space_header.dart';

class HistoryRecordPage extends StatefulWidget {
  const HistoryRecordPage({Key key}) : super(key: key);

  @override
  _HistoryRecordPageState createState() => _HistoryRecordPageState();
}

class _HistoryRecordPageState extends State<HistoryRecordPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarWhite('历史记录'),
      body: ProviderWidget<HistoryViewModel>(
        initData: (model) {
          model.getHistoryList();
        },
        model: HistoryViewModel(),
        builder: (context, model, child) {
          var articleList = model.articleList;

          return CustomCommonRefreshWidget(
              enableRefresh: true,
              onRefresh: () async {
                model.getHistoryList();
              },
              mHeader: SpaceHeader(enableHapticFeedback: true),
              slivers: [
                SliverFillViewport(
                  delegate: SliverChildBuilderDelegate((context, index) {
                    return ListView.separated(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          var article = articleList[index];
                          return ListTile(
                            title: Text(article.title),
                            subtitle: Text(article.desc),
                          );
                        },
                        separatorBuilder: (context, index) {
                          return Divider(
                            height: 1,
                            thickness: 1,
                          );
                        },
                        itemCount: articleList.length);
                  }, childCount: 1),
                )
              ],
              easyRefreshController: model.easyRefreshController);
        },
      ),
    );
  }
}
