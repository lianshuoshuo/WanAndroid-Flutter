import 'package:flutter/material.dart';
import 'package:flutter_wanandroid/app/provider/provider_widget.dart';
import 'package:flutter_wanandroid/model/tree_model.dart';
import 'package:flutter_wanandroid/page/listitem/home_article_item.dart';
import 'package:flutter_wanandroid/widget/article_skeleton.dart';
import 'package:flutter_wanandroid/widget/custom_refresh_widget.dart';
import 'package:flutter_wanandroid/widget/skeleton.dart';
import 'package:flutter_wanandroid/widget/view_state_helper.dart';

class ArticleListPage extends StatefulWidget {
  final int cid;

  ArticleListPage(this.cid);

  @override
  _ArticleListPageState createState() => _ArticleListPageState();
}

class _ArticleListPageState extends State<ArticleListPage>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return ProviderWidget<TreeViewModel>(
        initData: (model) {
          model.getArticleList(true, widget.cid);
        },
        model: TreeViewModel(),
        builder: (context, model, child) {
          if (model.isLoading()) {
            return SkeletonList(
              builder: (context, index) => ArticleSkeletonItem(),
            );
          } else if (model.isError() && model.articleList.isEmpty) {
            return CommonViewStateHelper(
              model: model,
              onErrorPressed: () {
                model.getArticleList(true, widget.cid);
              },
            );
          } else if (model.isEmpty() && model.articleList.isEmpty) {
            return CommonViewStateHelper(
                model: model,
                onEmptyPressed: () {
                  model.setLoading();
                  model.getArticleList(true, widget.cid);
                });
          }

          var articleList = model.articleList;
          return CustomCommonRefreshWidget(
            enableRefresh: true,
            enableLoad: true,
            onRefresh: () {
              return model.getArticleList(true, widget.cid);
            },
            onLoadMore: () {
              return model.getArticleList(false, widget.cid);
            },
            easyRefreshController: model.easyRefreshController,
            slivers: [
              SliverList(
                  delegate: SliverChildBuilderDelegate((context, index) {
                return ArticleItem(articleList[index], index);
              }, childCount: articleList?.length ?? 0))
            ],
          );
        });
  }
}
