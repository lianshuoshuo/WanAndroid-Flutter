import 'package:flutter/material.dart';
import 'package:flutter_wanandroid/app/router/routers.dart';
import 'package:flutter_wanandroid/entity/article_bean.dart';
import 'package:flutter_wanandroid/widget/image.dart';

class ArticleItem extends StatelessWidget {
  final ArticleDatas _articleDatas;
  final int index;

  ArticleItem(this._articleDatas, this.index);

  var textStyle12 = TextStyle(fontSize: 12, color: Colors.black54);

  @override
  Widget build(BuildContext context) {
    return
      Container(
        margin: EdgeInsets.only(top: 10),
        child: Ink(
          color: Colors.white,
          child: InkWell(
            onTap: () {
              Navigator.of(context)
                  .pushNamed(routers.WEB, arguments: _articleDatas.link);
            },
            child: Container(
              padding: EdgeInsets.all(8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      ClipOval(
                        child: WrapperImage(
                          imageType: ImageType.random,
                          url: _articleDatas.author,
                          height: 25,
                          width: 25,
                        ),
                      ),
                      Expanded(
                          child: Padding(
                            padding: EdgeInsets.only(left: 10),
                            child: Text(
                              "${_articleDatas.author.isEmpty ? _articleDatas.shareUser : _articleDatas.author}",
                              style: TextStyle(fontSize: 13, color: Colors.black87),
                            ),
                          )),
                      Text(
                        "${_articleDatas.chapterName}/${_articleDatas.superChapterName}",
                        style: textStyle12,
                      ),
                    ],
                  ),
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
                              if (_articleDatas.desc.isNotEmpty)
                                Text(
                                  _articleDatas.desc,
                                  maxLines: 3,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(fontSize: 14, color: Colors.black87),
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
                        Expanded(
                            child: Row(
                              children: [
                                Icon(
                                  Icons.favorite_border,
                                  size: 15,
                                ),
                                Text("${_articleDatas.zan}"),
                              ],
                            )),
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
        ),
      )
      ;
  }
}
