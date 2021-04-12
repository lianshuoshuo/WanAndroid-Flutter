import 'package:flutter_wanandroid/app/base/base_model.dart';
import 'package:flutter_wanandroid/app/net/request.dart';
import 'package:flutter_wanandroid/entity/banner_entity.dart';

class HomeViewModel extends BaseViewModel<WanAndroidRepository> {
  List<String> _bannerUrlList;
  List<BannerEntity> _bannerList;

  List<String> get bannerUrlList => _bannerUrlList;

  List<BannerEntity> get bannerList => _bannerList;

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
}
