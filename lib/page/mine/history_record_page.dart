import 'package:flutter/material.dart';
import 'package:flutter_wanandroid/app/provider/provider_widget.dart';
import 'package:flutter_wanandroid/model/history_model.dart';
import 'package:flutter_wanandroid/widget/app_bar_white.dart';
import 'package:flutter_wanandroid/widget/custom_refresh_widget.dart';
import 'package:flutter_wanandroid/widget/space_header.dart';
import 'package:flutter_wanandroid/widget/view_state_helper.dart';

///历史记录
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
          if (model.isLoading()) {
            return ViewStateLoadingWidget();
          } else if (model.isEmpty()) {
            return ViewStateEmptyWidget(
              onPressed: () {
                model.getHistoryList();
              },
            );
          }
          var articleList = model.articleList;
          return CustomCommonRefreshWidget(
              enableRefresh: true,
              enableLoad: false,
              onRefresh: () async {
                model.getHistoryList();
              },
              onLoadMore: () async {
                model.getHistoryList();
              },
              mHeader: SpaceHeader(enableHapticFeedback: true),
              slivers: [
              SliverToBoxAdapter(
                child:  ListView.separated(
                  shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      var article = articleList[index];
                      return ListTile(
                        tileColor: Colors.white,
                        title: Text(article.title,style: TextStyle(fontSize: 15),),
                        subtitle: Text(article.desc,maxLines: 3,),
                        trailing: article.envelopePic.isNotEmpty
                            ? Image.network(
                          article.envelopePic,
                          width: 80,
                          height: 80,
                        )
                            : null,
                      );
                    },
                    separatorBuilder: (context, index) {
                      return Divider(
                        height: 1,
                        thickness: 1,
                      );
                    },
                    itemCount: articleList.length),
              )
              ],
              easyRefreshController: model.easyRefreshController);
        },
      ),
    );
  }
}
