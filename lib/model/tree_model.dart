import 'package:flutter_wanandroid/app/base/base_refresh_model.dart';
import 'package:flutter_wanandroid/app/net/request.dart';
import 'package:flutter_wanandroid/entity/article_bean.dart';
import 'package:flutter_wanandroid/entity/navi_entity.dart';
import 'package:flutter_wanandroid/entity/tree_entity.dart';

class TreeViewModel extends BaseRefreshViewModel<WanAndroidRepository> {
  List<TreeEntity> _treeList;

  List<TreeEntity> get treeList => _treeList;
  int pageNum = 0;

  ArticleBean _articleBean;

  List<ArticleDatas> _articleList = [];

  List<ArticleDatas> get articleList => _articleList;

  List<NaviEntity> _naviList = [];

  List<NaviEntity> get naviList => _naviList;

  @override
  WanAndroidRepository createRepository() {
    return WanAndroidRepository();
  }

  Future<dynamic> getTree() async {
    _treeList = await requestListData<TreeEntity>(mRepository.getTree());
  }

  Future<dynamic> getNavi() async {
    _naviList = await requestListData<NaviEntity>(mRepository.getNavi());
  }

  Future<dynamic> getArticleList(bool isRefresh, int cid) async {
    if (isRefresh) {
      pageNum = 0;
      _articleBean = await refreshData(requestData<ArticleBean>(
          mRepository.getTreeArticleList(cid, pageNum)));
      _articleList.clear();
      _articleList.addAll(_articleBean.datas);
      if (_articleList.isEmpty) setEmpty();
    } else {
      pageNum++;
      _articleBean = await loadMoreData(requestData<ArticleBean>(
          mRepository.getTreeArticleList(cid, pageNum)));
      _articleList.addAll(_articleBean.datas);
    }
  }
}
