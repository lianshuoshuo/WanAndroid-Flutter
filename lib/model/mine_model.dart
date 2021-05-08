import 'package:flutter_wanandroid/app/base/base_model.dart';
import 'package:flutter_wanandroid/app/base/base_refresh_model.dart';
import 'package:flutter_wanandroid/app/net/request.dart';
import 'package:flutter_wanandroid/entity/article_bean.dart';
import 'package:flutter_wanandroid/entity/user_data_entity.dart';

class MineViewModel extends BaseRefreshViewModel<WanAndroidRepository> {
  UserDataEntity _userDataEntity;

  UserDataEntity get userDataEntity => _userDataEntity;

  List<ArticleDatas> _articleList = [];

  List<ArticleDatas> get articleList => _articleList;

  int page = 1;

  Future getUserArticle(bool isRefresh) async {
    if (isRefresh) {
      page = 1;
      _userDataEntity = await refreshData(
          requestData<UserDataEntity>(mRepository.getUserArticle(page)));
      _articleList.clear();
      _articleList.addAll(_userDataEntity.shareArticles.datas);
      if (_articleList.isEmpty) setEmpty();
    } else {
      page++;
      _userDataEntity = await loadMoreData(
          requestData<UserDataEntity>(mRepository.getUserArticle(page)));
      if (_userDataEntity.shareArticles.datas.isEmpty) {
        page--;
        easyRefreshController.finishLoad(success: true,noMore: true);
        return;
      }
      _articleList.addAll(_userDataEntity.shareArticles.datas);
    }
  }

  Future delArticle(int id) async {
    requestData(mRepository.delUserArticle(id));
    return true;
  }

  @override
  WanAndroidRepository createRepository() {
    return WanAndroidRepository();
  }
}
