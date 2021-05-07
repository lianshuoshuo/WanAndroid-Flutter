import 'package:flutter/material.dart';
import 'package:flutter_wanandroid/app/GlobalConfig.dart';
import 'package:flutter_wanandroid/app/ext/ext_widget.dart';
import 'package:flutter_wanandroid/app/provider/provider_widget.dart';
import 'package:flutter_wanandroid/entity/article_bean.dart';
import 'package:flutter_wanandroid/model/mine_model.dart';
import 'package:flutter_wanandroid/page/listitem/mine_article_item.dart';
import 'package:flutter_wanandroid/widget/article_skeleton.dart';
import 'package:flutter_wanandroid/widget/skeleton.dart';

///个人信息界面
class MineInfoPage extends StatefulWidget {
  @override
  _MineInfoPageState createState() => _MineInfoPageState();
}

class _MineInfoPageState extends State<MineInfoPage> {
  ScrollController _scrollController;

  ValueNotifier<bool> appbarStatus;

  _scrollListener() {
    if (isShrink != appbarStatus.value) {
      appbarStatus.value = isShrink;
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
    appbarStatus = ValueNotifier(false);
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
            slivers: [_buildHeader(model), _buildShareList(model)],
          );
        },
      ),
    );
  }

  ///头部
  Widget _buildHeader(MineViewModel model) {
    return SliverAppBar(
      elevation: 0,
      leading: ValueListenableBuilder(
        valueListenable: appbarStatus,
        builder: (context, value, child) {
          return BackButton(
            color: value ? Colors.black : Colors.white,
          );
        },
      ),
      backgroundColor: Colors.white,
      expandedHeight: 200,
      floating: false,
      pinned: true,
      snap: false,
      title: ValueListenableBuilder(
        valueListenable: appbarStatus,
        builder: (context, value, child) {
          return Text(
            GlobalConfig.userModel.user.username,
            style: TextStyle(color: value ? Colors.black : Colors.transparent),
          ).setMargin(EdgeInsets.only(left: 10));
        },
      ),
      flexibleSpace: FlexibleSpaceBar(
        titlePadding: EdgeInsets.only(left: 60, bottom: 0),
        centerTitle: false,
        stretchModes: [
          StretchMode.blurBackground,
          StretchMode.fadeTitle,
          StretchMode.zoomBackground
        ],
        background: Stack(
          children: [
            Image.asset(
              'assets/images/mine_bg.png',
              fit: BoxFit.fill,
              width: double.infinity,
            ),
            Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  margin: EdgeInsets.all(20),
                  padding: EdgeInsets.all(10),
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      color: Color(0x3BFFFFFF),
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      ClipOval(
                        child: Image.network(
                          GlobalConfig.userModel.hasUser
                              ? GlobalConfig.USER_AVATAR
                              : GlobalConfig.DEFAULT_AVATAR,
                          width: 50,
                          height: 50,
                          fit: BoxFit.cover,
                        ),
                      ),
                      Text(
                        GlobalConfig.userModel.user.username,
                        style: TextStyle(color: Colors.white),
                      ).setMargin(EdgeInsets.only(left: 10)),
                    ],
                  ),
                ))
          ],
        ),
      ),
    );
  }

  int currentIndex = -1;

  ///分享列表
  Widget _buildShareList(MineViewModel model) {
    if (model.isLoading())
      return SliverToBoxAdapter(
        child: SkeletonList(
          builder: (context, index) => ArticleSkeletonItem(),
        ),
      );
    List<ArticleDatas> datas = model.userDataEntity.shareArticles.datas;
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
                      return GestureDetector(
                        onLongPress: () {
                          setState(() {
                            currentIndex = index;
                          });
                        },
                        child: Stack(
                          children: [
                            ArticleItem(datas[index], index),
                            Positioned(
                              left: 0,
                              right: 0,
                              top: 0,
                              bottom: 0,
                              child: Offstage(
                                  offstage:
                                      currentIndex == index ? false : true,
                                  child: Container(
                                    color: Colors.black12,
                                    child: Row(
                                      children: [
                                        TextButton(
                                          child: Text(
                                            "删除",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 17),
                                          ),
                                          onPressed: () {
                                            model
                                                .delArticle(datas[index].id)
                                                .then((value) => {
                                                      if (value)
                                                        {
                                                          setState(() {
                                                            datas.removeAt(
                                                                index);
                                                            currentIndex = -1;
                                                          })
                                                        }
                                                    });
                                          },
                                          style: ButtonStyle(
                                              backgroundColor:
                                                  MaterialStateProperty
                                                      .resolveWith((states) =>
                                                          Colors.blue),
                                              shape: MaterialStateProperty.all(
                                                  CircleBorder()),
                                              padding:
                                                  MaterialStateProperty.all(
                                                      EdgeInsets.all(15))),
                                        ),
                                      ],
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                    ),
                                  )),
                            )
                          ],
                        ),
                      );
                    },
                    itemCount:
                        model.userDataEntity?.shareArticles?.datas?.length ?? 0)
              ],
            )));
  }
}
