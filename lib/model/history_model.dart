import 'package:flutter_wanandroid/app/base/base_refresh_model.dart';
import 'package:flutter_wanandroid/app/net/request.dart';
import 'package:flutter_wanandroid/entity/article_db.dart';

import 'db_dao/article_dao.dart';

class HistoryViewModel extends BaseRefreshViewModel<WanAndroidRepository> {
  List<ArticleDbEntity> _articleList = [];

  List<ArticleDbEntity> get articleList => _articleList;

  Future getHistoryList() async {
    setLoading();
    ArticleDao dao = ArticleDao();
    _articleList = await dao.getArticleList();
    if (_articleList.isEmpty) {
      setEmpty();
    } else {
      setSuccess();
    }
    easyRefreshController.finishRefresh();
  }

  @override
  WanAndroidRepository createRepository() => WanAndroidRepository();
}
