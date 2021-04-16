import 'article_bean.dart';

class NaviEntity {
  List<ArticleDatas> articles;
  int cid;
  String name;

  NaviEntity({this.articles, this.cid, this.name});

  NaviEntity.fromJson(Map<String, dynamic> json) {
    if (json['articles'] != null) {
      articles = new List<ArticleDatas>();
      json['articles'].forEach((v) {
        articles.add(new ArticleDatas.fromJson(v));
      });
    }
    cid = json['cid'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.articles != null) {
      data['articles'] = this.articles.map((v) => v.toJson()).toList();
    }
    data['cid'] = this.cid;
    data['name'] = this.name;
    return data;
  }
}
