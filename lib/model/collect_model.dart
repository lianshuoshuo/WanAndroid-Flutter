import 'package:flutter_wanandroid/app/base/base_model.dart';
import 'package:flutter_wanandroid/app/base/base_refresh_model.dart';
import 'package:flutter_wanandroid/app/net/request.dart';
import 'package:flutter_wanandroid/entity/article_bean.dart';
import 'package:flutter_wanandroid/entity/collect_entity.dart';

class CollectViewModel extends BaseRefreshViewModel<WanAndroidRepository> {
  int page = 0;

  CollectEntity _collectEntity;

  List<CollectDatas> _articleList = [];

  List<CollectDatas> get articleList => _articleList;

  Future<dynamic> getList(bool isRefresh) async {
    if (isRefresh) {
      page = 0;
      _collectEntity = await refreshData(requestData<CollectEntity>(mRepository.getCollectList(page)));
      _articleList.clear();
      _articleList.addAll(_collectEntity.datas);
      if (_articleList.isEmpty) setEmpty();
    } else {
      page++;
      _collectEntity = await loadMoreData(
          requestData<CollectEntity>(mRepository.getCollectList(page)));
      if (_collectEntity.datas.isEmpty) {
        page--;
        return;
      }
      _articleList.addAll(_collectEntity.datas);
    }
  }

  Future<bool> collect(int id) async {
    requestData(mRepository.collect(id));
    return true;
  }

  Future<bool> unCollect(int id) async {
    requestData(mRepository.unCollect(id));
    return false;
  }

  Future<bool> unCollectMy(int id,int originId) async {
    requestData(mRepository.unCollectMy(id,originId));
    return false;
  }

  @override
  WanAndroidRepository createRepository() {
    return WanAndroidRepository();
  }
}
