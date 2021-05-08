import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/phoenix_header.dart';
import 'package:flutter_wanandroid/app/provider/provider_widget.dart';
import 'package:flutter_wanandroid/model/home_model.dart';
import 'package:flutter_wanandroid/page/listitem/home_article_item.dart';
import 'package:flutter_wanandroid/page/listitem/home_top_article_item.dart';
import 'package:flutter_wanandroid/widget/article_skeleton.dart';
import 'package:flutter_wanandroid/widget/banner.dart';
import 'package:flutter_wanandroid/widget/custom_refresh_widget.dart';
import 'package:flutter_wanandroid/widget/skeleton.dart';
import 'package:flutter_wanandroid/widget/space_header.dart';
import 'package:flutter_wanandroid/widget/view_state_helper.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return HomePageState();
  }
}

class HomePageState extends State<HomePage> with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  int top = 0;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      backgroundColor: Color(0xffe8e8e8),
      body: ProviderWidget<HomeViewModel>(
        initData: (model) {
          model.getBannerList();
          model.getArticleList(true);
          model.getTopArticleList();
        },
        model: HomeViewModel(),
        builder: (_, HomeViewModel model, child) {
          if (model.isEmpty() || model.isError()) {
            return CommonViewStateHelper(
              model: model,
              onEmptyPressed: () => {},
              onErrorPressed: () => {},
              onNoNetworkPressed: () => {},
            );
          }

          return CustomCommonRefreshWidget(
            enableRefresh: true,
            enableLoad: true,
            onRefresh: () {
              return model.getArticleList(true);
            },
            onLoadMore: () {
              return model.getArticleList(false);
            },
            easyRefreshController: model.easyRefreshController,
            mHeader: SpaceHeader(enableHapticFeedback: true),
            slivers: [
              appBarBanner(model),
              SliverToBoxAdapter(
                child: Container(
                  margin: EdgeInsets.only(top: 10),
                  padding: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border(
                        bottom: Divider.createBorderSide(context, width: 0.5),
                      )),
                  child: Row(
                    children: [
                      Icon(
                        Icons.whatshot,
                        size: 20,
                        color: Colors.redAccent,
                      ),
                      Text('置顶推荐')
                    ],
                  ),
                ),
              ),
              HomeTopArticleList(),
              SliverToBoxAdapter(
                  child: Container(
                height: 10,
              )),
              HomeArticleList(),
            ],
          );
        },
      ),
    );
  }

  Widget appBarBanner(HomeViewModel model) {
    return SliverAppBar(
      flexibleSpace: LayoutBuilder(
        builder: (context, constraints) {
          top = constraints.biggest.height.toInt();
          return FlexibleSpaceBar(
            centerTitle: true,
            titlePadding: EdgeInsets.all(0),
            title: top == MediaQuery.of(context).padding.top.toInt() + 56
                ? Container(
                    padding: EdgeInsets.only(
                        top: MediaQuery.of(context).padding.top,
                        left: 10,
                        right: 10),
                    alignment: Alignment.center,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "首页",
                          style: TextStyle(color: Colors.black, fontSize: 16),
                        ),
                        Expanded(
                            child: Container(
                          margin: EdgeInsets.only(left: 10),
                          padding: EdgeInsets.only(left: 10),
                          alignment: Alignment.centerLeft,
                          decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5)),
                              color: Colors.black12),
                          height: 30,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.search,
                                size: 18,
                                color: Colors.black26,
                              ),
                              MediaQuery.removeViewPadding(
                                  context: context,
                                  child: Text(
                                    '搜索更多',
                                    style: TextStyle(
                                        fontSize: 15, color: Colors.black26),
                                  )),
                            ],
                          ),
                        ))
                      ],
                    ),
                  )
                : null,
            // title: Text(
            //   top.toString(),
            //   style: TextStyle(color: Colors.black),
            // ),
            background: model.bannerList != null
                ? CustomBanner(
                    model.bannerList,
                  )
                : null,
          );
        },
      ),
      backgroundColor: Colors.white,
      expandedHeight: 200,
      primary: true,
      pinned: true,
    );
  }
}

class HomeTopArticleList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    HomeViewModel homeViewModel = Provider.of(context);
    var dates = homeViewModel.topArticleList;
    return SliverList(
        delegate: SliverChildBuilderDelegate((context, index) {
      return TopArticleItem(dates[index], index);
    }, childCount: dates?.length ?? 0));
  }
}

class HomeArticleList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    HomeViewModel homeViewModel = Provider.of(context);
    if (homeViewModel.isLoading())
      return SliverToBoxAdapter(
        child: SkeletonList(
          builder: (context, index) => ArticleSkeletonItem(),
        ),
      );
    var dates = homeViewModel.articleList;
    return SliverToBoxAdapter(
        child: MediaQuery.removePadding(
            context: context,
            removeTop: true,
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
                  return ArticleItem(dates[index], index);
                },
                itemCount: dates?.length ?? 0)));
  }
}
