import 'package:flutter/material.dart';
import 'package:flutter_wanandroid/app/provider/provider_widget.dart';
import 'package:flutter_wanandroid/model/home_model.dart';
import 'package:flutter_wanandroid/widget/banner.dart';
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

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      body: ProviderWidget<HomeViewModel>(
        initData: (model) {
          model.getBannerList();
          // model.getArticleList(0);
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

          return CustomScrollView(
            slivers: [
              SliverAppBar(
                brightness: Brightness.dark,
                flexibleSpace: FlexibleSpaceBar(
                  background: CustomBanner(
                    model.bannerUrlList,
                  ),
                ),
                expandedHeight: 200,
                primary: false,
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
    return SliverList(
        delegate: SliverChildBuilderDelegate((context, index) {
      return ListTile(
        title: Text('index'),
      );
    }, childCount: homeViewModel.articleList?.length ?? 0));
  }
}
