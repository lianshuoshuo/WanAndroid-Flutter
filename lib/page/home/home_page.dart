import 'package:flutter/material.dart';
import 'package:flutter_wanandroid/app/provider/provider_widget.dart';
import 'package:flutter_wanandroid/model/home_model.dart';
import 'package:flutter_wanandroid/page/listitem/home_article_item.dart';
import 'package:flutter_wanandroid/widget/banner.dart';
import 'package:flutter_wanandroid/widget/custom_refresh_widget.dart';
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

  List<String> banner = [
    "https://ss3.bdstatic.com/70cFv8Sh_Q1YnxGkpoWK1HF6hhy/it/u=3286061922,1160551693&fm=26&gp=0.jpg",
    "https://gimg2.baidu.com/image_search/src=http%3A%2F%2Fc-ssl.duitang.com%2Fuploads%2Fitem%2F201706%2F04%2F20170604214539_HR5mN.png&refer=http%3A%2F%2Fc-ssl.duitang.com&app=2002&size=f9999,10000&q=a80&n=0&g=0n&fmt=jpeg?sec=1620895424&t=0da1c1caa41bee2717530c31b0fb18d5"
  ];

  double top = 0;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      backgroundColor: Color(0xfff8f8f8),
      body: ProviderWidget<HomeViewModel>(
        initData: (model) {
          model.getBannerList();
          model.getArticleList(true);
        },
        model: HomeViewModel(),
        builder: (_, HomeViewModel model, child) {
          if (!model.isSuccess()) {
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
            slivers: [
              SliverAppBar(
                title: top == 80
                    ? Row(
                        children: [
                          Text("首页"),
                          Container(
                            width: 200,
                            height: 30,
                            color: Colors.blue,
                          )
                        ],
                      )
                    : null,
                flexibleSpace: LayoutBuilder(
                  builder: (context, constraints) {
                    top = constraints.biggest.height;
                    return FlexibleSpaceBar(
                      title: Text(
                        top.toString(),
                        style: TextStyle(color: Colors.blue),
                      ),
                      background: CustomBanner(
                        model.bannerUrlList,
                      ),
                    );
                  },
                ),
                backgroundColor: Colors.white,
                expandedHeight: 200,
                primary: true,
                pinned: true,
              ),
              HomeArticleList(),
            ],
          );
        },
      ),
    );
  }
}

class HomeArticleList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    HomeViewModel homeViewModel = Provider.of(context);
    var dates = homeViewModel.articleList;
    return SliverList(
        delegate: SliverChildBuilderDelegate((context, index) {
      return ArticleItem(dates[index], index);
    }, childCount: homeViewModel.articleList?.length ?? 0));
  }
}
