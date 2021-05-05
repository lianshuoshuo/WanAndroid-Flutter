import 'article_bean.dart';

class UserDataEntity {
  CoinInfo coinInfo;
  ShareArticles shareArticles;

  UserDataEntity({this.coinInfo, this.shareArticles});

  UserDataEntity.fromJson(Map<String, dynamic> json) {
    coinInfo = json['coinInfo'] != null
        ? new CoinInfo.fromJson(json['coinInfo'])
        : null;
    shareArticles = json['shareArticles'] != null
        ? new ShareArticles.fromJson(json['shareArticles'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.coinInfo != null) {
      data['coinInfo'] = this.coinInfo.toJson();
    }
    if (this.shareArticles != null) {
      data['shareArticles'] = this.shareArticles.toJson();
    }
    return data;
  }
}

class CoinInfo {
  int coinCount;
  int level;
  String nickname;
  String rank;
  int userId;
  String username;

  CoinInfo(
      {this.coinCount,
      this.level,
      this.nickname,
      this.rank,
      this.userId,
      this.username});

  CoinInfo.fromJson(Map<String, dynamic> json) {
    coinCount = json['coinCount'];
    level = json['level'];
    nickname = json['nickname'];
    rank = json['rank'];
    userId = json['userId'];
    username = json['username'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['coinCount'] = this.coinCount;
    data['level'] = this.level;
    data['nickname'] = this.nickname;
    data['rank'] = this.rank;
    data['userId'] = this.userId;
    data['username'] = this.username;
    return data;
  }
}

class ShareArticles {
  int curPage;
  List<ArticleDatas> datas;
  int offset;
  bool over;
  int pageCount;
  int size;
  int total;

  ShareArticles(
      {this.curPage,
      this.datas,
      this.offset,
      this.over,
      this.pageCount,
      this.size,
      this.total});

  ShareArticles.fromJson(Map<String, dynamic> json) {
    curPage = json['curPage'];
    if (json['datas'] != null) {
      datas = new List<ArticleDatas>();
      json['datas'].forEach((v) {
        datas.add(new ArticleDatas.fromJson(v));
      });
    }
    offset = json['offset'];
    over = json['over'];
    pageCount = json['pageCount'];
    size = json['size'];
    total = json['total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['curPage'] = this.curPage;
    if (this.datas != null) {
      data['datas'] = this.datas.map((v) => v.toJson()).toList();
    }
    data['offset'] = this.offset;
    data['over'] = this.over;
    data['pageCount'] = this.pageCount;
    data['size'] = this.size;
    data['total'] = this.total;
    return data;
  }
}

