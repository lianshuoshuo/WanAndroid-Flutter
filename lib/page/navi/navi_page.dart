import 'package:flutter/material.dart';
import 'package:flutter_wanandroid/app/GlobalConfig.dart';
import 'package:flutter_wanandroid/app/provider/provider_widget.dart';
import 'package:flutter_wanandroid/app/router/routers.dart';
import 'package:flutter_wanandroid/entity/article_bean.dart';
import 'package:flutter_wanandroid/model/tree_model.dart';
import 'package:loading_indicator_view/loading_indicator_view.dart';

class NavigatePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return NavigatePageState();
  }
}

class NavigatePageState extends State<NavigatePage>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ProviderWidget<TreeViewModel>(
        initData: (model) {
          model.getNavi();
        },
        model: TreeViewModel(),
        builder: (BuildContext context, model, Widget child) {
          if (model.isLoading())
            return Center(
              child: LineScaleIndicator(
                lineColor: Colors.lightBlue,
              ),
            );
          return Container(
            padding: EdgeInsets.only(left: 10, right: 10, top: 0),
            child: ListView.builder(
              itemCount: model.naviList.length,
              itemBuilder: (_, index) {
                var naviList = model.naviList[index];
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(bottom: 10, top: 10, left: 10),
                      child: Text(
                        naviList.name,
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                    Wrap(
                      spacing: 10,
                      children:
                          List.generate(naviList.articles.length, (index) {
                        return ActionChip(
                            label: Text(naviList.articles[index].title,
                                style: TextStyle(
                                    fontSize: 14, color: Color(0xff666666))),
                            onPressed: () {
                              Navigator.of(context).pushNamed(routers.WEB,
                                  arguments: naviList.articles[index].link);
                            });
                      }),
                    )
                    // Container(
                    //   child: GridView.builder(
                    //       physics: NeverScrollableScrollPhysics(),
                    //       shrinkWrap: true,
                    //       itemCount: naviList.articles.length,
                    //       gridDelegate:
                    //           SliverGridDelegateWithFixedCrossAxisCount(
                    //               crossAxisCount: 2,
                    //               mainAxisSpacing: 10,
                    //               crossAxisSpacing: 10,
                    //               childAspectRatio: 1 / 0.618),
                    //       itemBuilder: (_, index) {
                    //         return _buildItem(naviList.articles[index]);
                    //       }),
                    // )
                  ],
                );
              },
            ),
          );
        },
      ),
    );
  }

  Widget _buildItem(ArticleDatas _data) {
    return Ink(
      child: InkWell(
        onTap: () {
          Navigator.of(context).pushNamed(routers.WEB, arguments: _data.link);
        },
        child: GridTile(
          header: GridTileBar(
            backgroundColor: Colors.blue,
            trailing: Icon(
              Icons.favorite_border,
              size: 20,
            ),
            leading: CircleAvatar(
              backgroundImage: NetworkImage(GlobalConfig.USER_AVATAR),
            ),
            title: Text(_data.title),
            subtitle: Text('${_data.author ?? _data.shareUser}'),
          ),
          child: Container(
            color: Colors.white,
          ),
          footer: Padding(
            padding: EdgeInsets.all(5),
            child: Text('${_data.chapterName}'),
          ),
        ),
      ),
    );
  }
}
