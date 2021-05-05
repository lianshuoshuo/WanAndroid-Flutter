import 'package:flutter/material.dart';
import 'package:flutter_wanandroid/app/provider/provider_widget.dart';
import 'package:flutter_wanandroid/app/router/routers.dart';
import 'package:flutter_wanandroid/entity/collect_entity.dart';
import 'package:flutter_wanandroid/model/collect_model.dart';
import 'package:flutter_wanandroid/widget/image.dart';
import 'package:like_button/like_button.dart';

///文章item
class CollectArticleItem extends StatelessWidget {
  final CollectDatas _articleDatas;
  final int index;
  final CollectViewModel _collectViewModel;

  CollectArticleItem(this._articleDatas, this.index,this._collectViewModel);

  var textStyle12 = TextStyle(fontSize: 12, color: Colors.black54);

  @override
  Widget build(BuildContext context) {
    return Container(
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
                        "${_articleDatas.author}",
                        style: TextStyle(fontSize: 13, color: Colors.black87),
                      ),
                    )),
                    Text(
                      "${_articleDatas.chapterName}",
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
                            style:
                                TextStyle(fontSize: 14, color: Colors.black87),
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
                          ProviderWidget<CollectViewModel>(
                            model: _collectViewModel,
                            builder: (_, CollectViewModel model, chlid) {
                              return LikeButton(
                                onTap: (bool isLike) {
                                  return model.unCollectMy(_articleDatas.id,_articleDatas.originId).then((value){
                                    model.articleList.removeAt(index);
                                    return false;
                                  });
                                },
                                likeBuilder: (isCollect) {
                                  return Icon(
                                    Icons.favorite_border,
                                    color: Colors.red,
                                    size: 20,
                                  );
                                },
                                isLiked: true,
                              );
                            },
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
    );
  }
}
