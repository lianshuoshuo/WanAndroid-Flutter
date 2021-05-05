import 'package:flutter_wanandroid/app/base/base_refresh_model.dart';
import 'package:flutter_wanandroid/app/net/request.dart';
import 'package:flutter_wanandroid/entity/article_bean.dart';
import 'package:flutter_wanandroid/entity/tree_entity.dart';
import 'package:flutter_wanandroid/entity/wx_account_entity.dart';

class WxAccountViewModel extends BaseRefreshViewModel<WanAndroidRepository> {
  List<TreeEntity> _wxAccountList = [];

  List<TreeEntity> get wxAccountList => _wxAccountList;

  int pageNum = 0;

  ArticleBean _articleBean;

  List<ArticleDatas> _articleList = [];

  List<ArticleDatas> get articleList => _articleList;

  ArticleBean _wendaBean;

  List<ArticleDatas> _wendaList = [];

  List<ArticleDatas> get wendaList => _wendaList;

  Future getWxAccount() async {
    _wxAccountList = await requestListData<TreeEntity>(
        mRepository.getWxOfficialAccount());
  }

  Future getSquareList(bool isRefresh) async {
    if (isRefresh) {
      pageNum = 0;
      _articleBean = await refreshData(
          requestData<ArticleBean>(mRepository.getSquareList(pageNum)));
      _articleList.clear();
      _articleList.addAll(_articleBean.datas);
      if (_articleList.isEmpty) setEmpty();
    } else {
      pageNum++;
      _articleBean = await loadMoreData(
          requestData<ArticleBean>(mRepository.getSquareList(pageNum)));
      if (_articleBean.datas.isEmpty) {
        pageNum--;
        return;
      }
      _articleList.addAll(_articleBean.datas);
    }
  }

  Future getWendaList(bool isRefresh) async {
    if (isRefresh) {
      pageNum = 0;
      _wendaBean = await refreshData(
          requestData<ArticleBean>(mRepository.getWendaList(pageNum)));
      _wendaList.clear();
      _wendaList.addAll(_wendaBean.datas.sublist(0,4));
      if (_wendaList.isEmpty) setEmpty();
    } else {
      pageNum++;
      _wendaBean = await loadMoreData(
          requestData<ArticleBean>(mRepository.getWendaList(pageNum)));
      if (_wendaBean.datas.isEmpty) {
        pageNum--;
        return;
      }
      _wendaList.addAll(_wendaBean.datas);
    }
  }

  @override
  WanAndroidRepository createRepository() {
   return WanAndroidRepository();
  }
}
