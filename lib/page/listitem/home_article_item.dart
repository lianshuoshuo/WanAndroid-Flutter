
import 'package:flutter/material.dart';
import 'package:flutter_wanandroid/entity/article_entity.dart';

class ArticleItem extends StatelessWidget {
  final ArticleEntity _articleEntity;
  final int index;

  ArticleItem(this._articleEntity, this.index);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        child: Text(_articleEntity.title),
      ),
    );
  }
}
