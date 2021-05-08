import 'package:flutter/material.dart';
import 'package:flutter_wanandroid/app/ext/ext_widget.dart';
import 'package:flutter_wanandroid/app/provider/provider_widget.dart';
import 'package:flutter_wanandroid/app/router/routers.dart';
import 'package:flutter_wanandroid/entity/article_bean.dart';
import 'package:flutter_wanandroid/entity/tree_entity.dart';
import 'package:flutter_wanandroid/model/wx_account_model.dart';
import 'package:flutter_wanandroid/page/listitem/home_article_item.dart';
import 'package:flutter_wanandroid/widget/app_bar_white.dart';
import 'package:flutter_wanandroid/widget/article_skeleton.dart';
import 'package:flutter_wanandroid/widget/custom_refresh_widget.dart';
import 'package:flutter_wanandroid/widget/image.dart';
import 'package:flutter_wanandroid/widget/skeleton.dart';

///发现界面
class FindPage extends StatefulWidget {
  @override
  _FindPageState createState() => _FindPageState();
}

class _FindPageState extends State<FindPage>
    with AutomaticKeepAliveClientMixin {
  TextStyle _titleStyle =
      TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: Colors.black);

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffe8e8e8),
      appBar: appBarWhite('发现'),
      body: ProviderWidget<WxAccountViewModel>(
        initData: (model) {
          model.getWxAccount();
          model.getSquareList(true);
          model.getWendaList(true);
        },
        model: WxAccountViewModel(),
        builder: (context, model, child) {
          return CustomCommonRefreshWidget(
            enableRefresh: true,
            enableLoad: true,
            onRefresh: () async {
              // ignore: missing_return
              model.getSquareList(true);
            },
            onLoadMore: () async {
              model.getSquareList(false);
            },
            slivers: [
              _wxList(model),
              _wendaList(model),
              SliverToBoxAdapter(
                child: Container(
                  height: 10,
                  color: Color(0xffe8e8e8),
                ),
              ),
              _squareList(model)
            ],
            easyRefreshController: model.easyRefreshController,
          );
        },
      ),
    );
  }

  ///公众号列表
  Widget _wxList(WxAccountViewModel model) {
    List<TreeEntity> wxAccountList = model.wxAccountList;
    return SliverToBoxAdapter(
      child: Container(
        margin: EdgeInsets.only(top: 10),
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '公众号',
              style: _titleStyle,
            ).setMargin(EdgeInsets.only(left: 10, top: 10)),
            Container(
              margin: EdgeInsets.only(top: 5, left: 10),
              height: 80,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                itemBuilder: (_, index) {
                  var wxItem = wxAccountList[index];
                  return GestureDetector(
                    onTap: () {
                      var map = Map<String, dynamic>();
                      map['pageType'] = 1;
                      map['datas'] = wxAccountList;
                      map['pageName'] = '公众号';
                      Navigator.of(context)
                          .pushNamed(routers.TREE_TAB, arguments: map);
                    },
                    child: Container(
                      margin: EdgeInsets.only(right: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ClipOval(
                            child: WrapperImage(
                              imageType: ImageType.random,
                              url: wxItem.name,
                              height: 45,
                              width: 45,
                            ),
                          ),
                          Text(wxItem.name).setMargin(EdgeInsets.only(top: 5))
                        ],
                      ),
                    ),
                  );
                },
                itemCount: wxAccountList.length,
              ),
            )
          ],
        ),
      ),
    );
  }

  ///广场列表
  Widget _squareList(WxAccountViewModel model) {
    return SliverToBoxAdapter(
      child: Container(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(10),
              width: double.infinity,
              color: Colors.white,
              child: Text('广场', style: _titleStyle),
            ),
            Container(
              height: 1,
              color: Color(0xffe8e8e8),
            ),
            Builder(builder: (context) {
              if (model.isLoading())
                return SkeletonList(
                  builder: (context, index) => ArticleSkeletonItem(),
                );
              var dates = model.articleList;
              return ListView.separated(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                separatorBuilder: (context, index) {
                  return Divider(
                    height: 0.1,
                    thickness: 0.1,
                    color: Colors.grey,
                  );
                },
                itemBuilder: (context, index) {
                  return ArticleItem(dates[index], index);
                },
                itemCount: dates.length,
              );
            })
          ],
        ),
      ),
    );
  }

  ///问答列表
  Widget _wendaList(WxAccountViewModel model) {
    return SliverToBoxAdapter(
      child: Container(
        margin: EdgeInsets.only(
          top: 10,
        ),
        child: Column(
          children: [
            Container(
              width: double.infinity,
              color: Colors.white,
              child: Text('每日问答', style: _titleStyle),
              padding: EdgeInsets.all(10),
            ),
            SizedBox(
              height: 1,
            ),
            GridView.builder(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 1,
                  crossAxisSpacing: 1,
                  childAspectRatio: 1 / 0.618),
              itemBuilder: (context, index) {
                ArticleDatas _item = model.wendaList[index];

                return GestureDetector(
                  onTap: () {
                    Navigator.of(context)
                        .pushNamed(routers.WEB, arguments: _item.link);
                  },
                  child: Container(
                    padding: EdgeInsets.all(10),
                    color: Colors.white,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          _item.title,
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                        ),
                        Row(
                          children: [
                            ClipOval(
                              child: WrapperImage(
                                imageType: ImageType.random,
                                url: _item.author,
                                height: 25,
                                width: 25,
                              ),
                            ),
                            Text(_item.author)
                                .setMargin(EdgeInsets.only(left: 5))
                          ],
                        )
                      ],
                    ),
                  ),
                );
              },
              itemCount: model.wendaList.length,
            )
          ],
        ),
      ),
    );
  }
}
