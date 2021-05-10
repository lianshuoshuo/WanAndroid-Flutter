import 'package:flutter_wanandroid/app/db/base_db_provider.dart';
import 'package:flutter_wanandroid/entity/article_db.dart';
import 'package:sqflite/sqflite.dart';

class ArticleDao extends BaseDBProvider {
  final String name = 'article';
  final String columnId = "_id";

  @override
  tableName() {
    return name;
  }

  @override
  tableSqlString() {
    return tableBaseString(name, columnId) +
        '''author text,desc text,title text,shareUser text,niceDate text,link text,envelopePic text)''';
  }

  Future insert(ArticleDbEntity bean) async {
    Database db = await getDataBase();
    return await db.insert(name, bean.toJson());
  }

  Future<ArticleDbEntity> getArticleById(String id) async {
    Database db = await getDataBase();
    List<Map<String, dynamic>> maps =
        await db.query(name, where: "id = ?", whereArgs: [id]);
    if (maps.length > 0) {
      ArticleDbEntity bean = ArticleDbEntity.fromJson(maps.first);
      return bean;
    }
    return null;
  }

  Future<List<ArticleDbEntity>> getArticleList() async {
    Database db = await getDataBase();
    List<Map<String, dynamic>> maps = await db.query(name);
    if (maps.length > 0) {
      List<ArticleDbEntity> list =
          maps.map((e) => ArticleDbEntity.fromJson(e)).toList();
      return list;
    }
    return [];
  }
}
