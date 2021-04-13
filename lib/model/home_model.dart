import 'package:flutter_wanandroid/app/base/base_refresh_model.dart';
import 'package:flutter_wanandroid/app/net/request.dart';
import 'package:flutter_wanandroid/entity/article_bean.dart';
import 'package:flutter_wanandroid/entity/banner_entity.dart';

class HomeViewModel extends BaseRefreshViewModel<WanAndroidRepository> {
  List<String> _bannerUrlList;
  List<BannerEntity> _bannerList;

  List<String> get bannerUrlList => _bannerUrlList;

  List<BannerEntity> get bannerList => _bannerList;

  ArticleBean _articleBean;

  List<ArticleDatas> _articleList = [];

  List<ArticleDatas> get articleList => _articleList;

  int pageNum = 0;

  @override
  WanAndroidRepository createRepository() => WanAndroidRepository();

  Future getBannerList() async {
    _bannerList =
        await requestListData<BannerEntity>(mRepository.getBannerList());
    _bannerUrlList = List<String>();
    _bannerList.forEach((element) {
      _bannerUrlList.add(element.imagePath);
    });
  }

  Future<dynamic> getArticleList(bool isRefresh) async {
    if (isRefresh) {
      pageNum = 0;
      _articleBean = await refreshData(
          requestData<ArticleBean>(mRepository.getArticleList(pageNum)));
      _articleList.clear();
      _articleList.addAll(_articleBean.datas);
    } else {
      pageNum++;
      _articleBean = await loadMoreData(
          requestData<ArticleBean>(mRepository.getArticleList(pageNum)));
      _articleList.addAll(_articleBean.datas);
    }
  }
}
