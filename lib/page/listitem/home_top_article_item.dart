import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_wanandroid/app/router/routers.dart';
import 'package:flutter_wanandroid/entity/article_bean.dart';

class TopArticleItem extends StatelessWidget {
  final ArticleDatas _articleDatas;
  final int index;

  TopArticleItem(this._articleDatas, this.index);

  var textStyle12 = TextStyle(fontSize: 12, color: Colors.black54);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      child: InkWell(
        onTap: () {
          Navigator.of(context)
              .pushNamed(routers.WEB, arguments: _articleDatas.link);
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
                      Text(
                        _articleDatas.title,
                        style: TextStyle(
                            fontSize: 15,
                            color: Colors.black,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  )),
                  if (_articleDatas.envelopePic.isNotEmpty)
                    Image.network(
                      _articleDatas.envelopePic,
                      width: 80,
                      height: 80,
                    )
                ],
              ),
              Container(
                margin: EdgeInsets.only(top: 10),
                child: Row(
                  children: [
                    Container(
                      child: Text('置顶'),
                      margin: EdgeInsets.only(right: 5),
                      padding: EdgeInsets.only(left: 3, right: 3),
                      decoration: BoxDecoration(
                          border: Border.all(width: 1, color: Colors.black)),
                    ),
                    Expanded(
                      child: Text(
                          "${_articleDatas.zan}赞 ·  ${_articleDatas.author.isEmpty ? _articleDatas.shareUser : _articleDatas.author}"),
                    ),
                    Text(
                      "${_articleDatas.niceDate}",
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
  }
}
