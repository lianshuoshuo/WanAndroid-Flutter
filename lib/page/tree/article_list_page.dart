import 'package:flutter/material.dart';
import 'package:flutter_wanandroid/app/provider/provider_widget.dart';
import 'package:flutter_wanandroid/model/tree_model.dart';
import 'package:flutter_wanandroid/page/listitem/home_article_item.dart';
import 'package:flutter_wanandroid/widget/article_skeleton.dart';
import 'package:flutter_wanandroid/widget/custom_refresh_widget.dart';
import 'package:flutter_wanandroid/widget/skeleton.dart';
import 'package:flutter_wanandroid/widget/view_state_helper.dart';

///体系文章列表
class ArticleListPage extends StatefulWidget {
  final int cid;
  final int pageType;

  ArticleListPage(this.cid, this.pageType);

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
          model.getArticleList(true, widget.cid,isTreeTab: widget.pageType==0);
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
                model.getArticleList(true, widget.cid,isTreeTab: widget.pageType==0);
              },
            );
          } else if (model.isEmpty() && model.articleList.isEmpty) {
            return CommonViewStateHelper(
                model: model,
                onEmptyPressed: () {
                  model.setLoading();
                  model.getArticleList(true, widget.cid,isTreeTab: widget.pageType==0);
                });
          }

          var articleList = model.articleList;
          return CustomCommonRefreshWidget(
            enableRefresh: true,
            enableLoad: true,
            onRefresh: () {
              return model.getArticleList(true, widget.cid,isTreeTab: widget.pageType==0);
            },
            onLoadMore: () {
              return model.getArticleList(false, widget.cid,isTreeTab: widget.pageType==0);
            },
            easyRefreshController: model.easyRefreshController,
            slivers: [
              SliverToBoxAdapter(
                  child: ListView.separated(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      separatorBuilder: (context, index) {
                        return Divider(
                          height: 10,
                          thickness: 0,
                          color: Colors.transparent,
                        );
                      },
                      itemBuilder: (context, index) {
                        return ArticleItem(articleList[index], index);
                      },
                      itemCount: articleList?.length ?? 0))
            ],
          );
        });
  }
}
