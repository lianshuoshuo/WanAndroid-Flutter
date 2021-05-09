import 'package:flutter/material.dart';
import 'package:flutter_html_rich_text/flutter_html_rich_text.dart';
import 'package:flutter_wanandroid/app/provider/provider_widget.dart';
import 'package:flutter_wanandroid/app/router/routers.dart';
import 'package:flutter_wanandroid/entity/article_bean.dart';
import 'package:flutter_wanandroid/entity/search_str_entity.dart';
import 'package:flutter_wanandroid/model/search_model.dart';
import 'package:flutter_wanandroid/app/ext/ext_widget.dart';
import 'package:flutter_wanandroid/widget/custom_refresh_widget.dart';

///搜索界面
class SearchPage extends StatefulWidget {
  const SearchPage({Key key}) : super(key: key);

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  TextEditingController _editingController;
  var textStyle12 = TextStyle(fontSize: 12, color: Colors.black54);

  @override
  void initState() {
    _editingController = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.black),
          elevation: 0,
          backgroundColor: Colors.white,
          titleSpacing: 0,
          title: SizedBox(
            height: kToolbarHeight - 20,
            child: TextField(
              controller: _editingController,
              cursorHeight: 10,
              style: TextStyle(fontSize: 14),
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(5)),
                  ),
                  labelText: '搜索文章'),
            ),
          ).setMargin(EdgeInsets.only(right: 20))),
      body: ProviderWidget<SearchViewModel>(
        initData: (model) {
          model.getHotStr();
          _editingController.addListener(() {
            model.search(true, _editingController.text);
          });
        },
        model: SearchViewModel(),
        builder: (context, model, child) {
          if (model.isLoading()) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          return CustomCommonRefreshWidget(
            slivers: [
              SliverToBoxAdapter(
                child: _editingController.value.text.isEmpty
                    ? _buildHotStr(model)
                    : _buildSearchList(model),
              )
            ],
            enableLoad: _editingController.value.text.isNotEmpty,
            onLoadMore: () async {
              model.search(false, _editingController.text);
            },
            easyRefreshController: model.easyRefreshController,
          );
        },
      ),
    );
  }

  Widget _buildHotStr(model) {
    List<SearchStrEntity> hotStr = model.hotStr;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '搜索热词',
          style: TextStyle(fontSize: 17),
        ),
        Wrap(
          spacing: 10,
          children: List.generate(hotStr.length, (index) {
            return ActionChip(
                label: Text(hotStr[index].name,
                    style: TextStyle(fontSize: 14, color: Color(0xff666666))),
                onPressed: () {
                  _editingController.text = hotStr[index].name;
                });
          }),
        )
      ],
    ).setMargin(EdgeInsets.all(10));
  }

  Widget _buildSearchList(SearchViewModel model) {
    List<ArticleDatas> articleList = model.articleList;
    return ListView.separated(
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemBuilder: (context, index) {
          var article = articleList[index];
          return Material(
            color: Colors.white,
            child: InkWell(
              onTap: () {
                Navigator.of(context)
                    .pushNamed(routers.WEB, arguments: article.link);
              },
              child: Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                    border: Border(
                  bottom: Divider.createBorderSide(context, width: 0.7),
                )),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                            child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            HtmlRichText(
                              htmlText: article.title,
                              golobalTextStyle: TextStyle(
                                  fontSize: 16,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        )),
                        if (article.envelopePic.isNotEmpty)
                          Image.network(
                            article.envelopePic,
                            width: 80,
                            height: 80,
                          )
                      ],
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 10),
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                                "${article.zan}赞 ·  ${article.author.isEmpty ? article.shareUser : article.author}"),
                          ),
                          Text(
                            "${article.niceDate}",
                            style: textStyle12,
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        },
        separatorBuilder: (context, index) {
          return Divider(
            thickness: 1,
            height: 1,
          );
        },
        itemCount: articleList.length);
  }
}
