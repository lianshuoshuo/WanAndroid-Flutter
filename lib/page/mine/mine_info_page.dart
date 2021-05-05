import 'package:flutter/material.dart';
import 'package:flutter_wanandroid/app/GlobalConfig.dart';
import 'package:flutter_wanandroid/app/provider/provider_widget.dart';
import 'package:flutter_wanandroid/model/mine_model.dart';
import 'package:flutter_wanandroid/page/listitem/home_article_item.dart';
import 'package:flutter_wanandroid/widget/article_skeleton.dart';
import 'package:flutter_wanandroid/widget/skeleton.dart';

class MineInfoPage extends StatefulWidget {
  @override
  _MineInfoPageState createState() => _MineInfoPageState();
}

class _MineInfoPageState extends State<MineInfoPage> {
  ScrollController _scrollController;

  bool lastStatus = false;

  _scrollListener() {
    if (isShrink != lastStatus) {
      setState(() {
        lastStatus = isShrink;
      });
    }
  }

  bool get isShrink {
    return _scrollController.hasClients &&
        _scrollController.offset > (200 - kToolbarHeight);
  }

  @override
  void initState() {
    _scrollController = ScrollController();
    _scrollController.addListener(_scrollListener);
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ProviderWidget<MineViewModel>(
        initData: (model) {
          model.getUserArticle(true);
        },
        model: MineViewModel(),
        builder: (context, MineViewModel model, child) {
          return CustomScrollView(
            controller: _scrollController,
            slivers: [
              SliverAppBar(
                elevation: 0,
                leading: BackButton(
                  color: lastStatus ? Colors.black : Colors.white,
                ),
                backgroundColor: Colors.white,
                expandedHeight: 200,
                floating: false,
                pinned: true,
                snap: false,
                textTheme: TextTheme(
                  headline1: TextStyle(fontSize: 18),
                  headline2: TextStyle(fontSize: 18),
                ),
                flexibleSpace: FlexibleSpaceBar(
                  centerTitle: false,
                  title: Text(
                    GlobalConfig.userModel.user.username,
                    style: TextStyle(
                        color: lastStatus ? Colors.black : Colors.white),
                  ),
                  background: Image.asset(
                    'assets/images/mine_bg.png',
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              _buildShareList(model)
            ],
          );
        },
      ),
    );
  }

  ///分享列表
  Widget _buildShareList(model) {
    if (model.isLoading())
      return SliverToBoxAdapter(
        child: SkeletonList(
          builder: (context, index) => ArticleSkeletonItem(),
        ),
      );
    return SliverToBoxAdapter(
        child: MediaQuery.removePadding(
            context: context,
            removeTop: true,
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.all(10),
                  width: double.infinity,
                  color: Colors.white,
                  child: Text(
                    '我的分享列表',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
                ListView.separated(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    separatorBuilder: (context, index) {
                      return Divider(
                        height: 2,
                        thickness: 0.1,
                        color: Colors.grey,
                      );
                    },
                    itemBuilder: (context, index) {
                      return ArticleItem(
                          model.userDataEntity.shareArticles.datas[index],
                          index);
                    },
                    itemCount:
                        model.userDataEntity?.shareArticles?.datas?.length ?? 0)
              ],
            )));
  }
}
