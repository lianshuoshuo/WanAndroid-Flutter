import 'package:flutter_wanandroid/app/base/base_refresh_model.dart';
import 'package:flutter_wanandroid/app/net/request.dart';
import 'package:flutter_wanandroid/entity/article_bean.dart';
import 'package:flutter_wanandroid/entity/tree_entity.dart';

class ProjectTreeViewModel extends BaseRefreshViewModel<WanAndroidRepository> {
  List<TreeEntity> _projectTreeList;

  List<TreeEntity> get treeList => _projectTreeList;

  ArticleBean _articleBean;

  List<ArticleDatas> _articleList = [];

  List<ArticleDatas> get articleList => _articleList;

  int pageNum = 0;

  @override
  WanAndroidRepository createRepository() {
    return WanAndroidRepository();
  }

  Future<dynamic> getTree() async {
    _projectTreeList =
        await requestListData<TreeEntity>(mRepository.getProjectTree());
  }

  Future<dynamic> getProjectTreeList(bool isRefresh, int cid) async {
    if (isRefresh) {
      pageNum = 1;
      _articleBean = await refreshData(requestData<ArticleBean>(
          mRepository.getProjectTreeList(pageNum, cid)));
      _articleList.clear();
      _articleList.addAll(_articleBean.datas);
      if (_articleList.isEmpty) setEmpty();
    } else {
      pageNum++;
      _articleBean = await loadMoreData(requestData<ArticleBean>(
          mRepository.getProjectTreeList(pageNum, cid)));
      if (_articleBean.datas.isEmpty) {
        pageNum--;
        return;
      }
      _articleList.addAll(_articleBean.datas);
    }
  }
}
