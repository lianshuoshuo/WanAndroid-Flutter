import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_wanandroid/app/provider/provider_widget.dart';
import 'package:flutter_wanandroid/model/collect_model.dart';
import 'package:flutter_wanandroid/page/listitem/collect_article_item.dart';
import 'package:flutter_wanandroid/page/listitem/home_article_item.dart';
import 'package:flutter_wanandroid/widget/app_bar_white.dart';
import 'package:flutter_wanandroid/widget/article_skeleton.dart';
import 'package:flutter_wanandroid/widget/custom_refresh_widget.dart';
import 'package:flutter_wanandroid/widget/skeleton.dart';
import 'package:flutter_wanandroid/widget/view_state_helper.dart';

class CollectPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => CollectState();
}

class CollectState extends State<CollectPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarWhite('收藏'),
      body: Container(
        child: ProviderWidget<CollectViewModel>(
            initData: (model) {
              model.getList(true);
            },
            model: CollectViewModel(),
            builder: (context, model, child) {
              if (model.isLoading()) {
                return SkeletonList(
                    builder: (_, index) => ArticleSkeletonItem());
              } else if (model.isError() && model.articleList.isEmpty) {
                return CommonViewStateHelper(
                  model: model,
                  onErrorPressed: () {
                    model.getList(true);
                  },
                );
              } else if (model.isEmpty() && model.articleList.isEmpty) {
                return CommonViewStateHelper(
                    model: model,
                    onEmptyPressed: () {
                      model.setLoading();
                      model.getList(true);
                    });
              }else if ( model.articleList.isEmpty) {
                model.setEmpty();
                return CommonViewStateHelper(
                    model: model,
                    onEmptyPressed: () {
                      model.setLoading();
                      model.getList(true);
                    });
              }
              var articleList = model.articleList;
              return CustomCommonRefreshWidget(
                enableRefresh: true,
                enableLoad: true,
                onRefresh: () {
                  return model.getList(true);
                },
                onLoadMore: () {
                  return model.getList(true);
                },
                easyRefreshController: model.easyRefreshController,
                slivers: [
                  SliverList(
                      delegate: SliverChildBuilderDelegate((context, index) {
                    return CollectArticleItem(articleList[index], index,model);
                  }, childCount: articleList?.length ?? 0))
                ],
              );
            }),
      ),
    );
  }
}
