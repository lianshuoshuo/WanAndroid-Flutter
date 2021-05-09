import 'package:flutter_wanandroid/app/base/base_model.dart';
import 'package:flutter_wanandroid/app/base/base_refresh_model.dart';
import 'package:flutter_wanandroid/app/net/request.dart';
import 'package:flutter_wanandroid/entity/article_bean.dart';
import 'package:flutter_wanandroid/entity/search_str_entity.dart';

class SearchViewModel extends BaseRefreshViewModel<WanAndroidRepository> {
  List<SearchStrEntity> _hotStr = [];

  List<SearchStrEntity> get hotStr => _hotStr;

  ArticleBean _articleBean;

  List<ArticleDatas> _articleList = [];

  List<ArticleDatas> get articleList => _articleList;

  int pageNum = 0;

  Future getHotStr() async {
    _hotStr =
        await requestListData<SearchStrEntity>(mRepository.searchHotStr());
  }

  Future search(bool isRefresh, String searchStr) async {
    if (isRefresh) {
      pageNum = 0;
      _articleBean = await refreshData(
          requestData<ArticleBean>(mRepository.search(pageNum, searchStr)));
      _articleList.clear();
      _articleList.addAll(_articleBean.datas);
    } else {
      pageNum++;
      _articleBean = await loadMoreData(
          requestData<ArticleBean>(mRepository.search(pageNum, searchStr)));
      _articleList.addAll(_articleBean.datas);
    }
  }

  @override
  WanAndroidRepository createRepository() => WanAndroidRepository();
}
