import 'package:flutter_wanandroid/app/base/base_model.dart';
import 'package:flutter_wanandroid/app/net/request.dart';
import 'package:flutter_wanandroid/entity/article_entity.dart';
import 'package:flutter_wanandroid/entity/banner_entity.dart';

class HomeViewModel extends BaseViewModel<WanAndroidRepository> {
  List<String> _bannerUrlList;
  List<BannerEntity> _bannerList;

  List<String> get bannerUrlList => _bannerUrlList;

  List<BannerEntity> get bannerList => _bannerList;

  List<ArticleEntity> _articleList;

  List<ArticleEntity> get articleList => _articleList;

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

  Future getArticleList(int page) async {
    _articleList = await requestListData<ArticleEntity>(mRepository.getArticleList(page));
  }
}
