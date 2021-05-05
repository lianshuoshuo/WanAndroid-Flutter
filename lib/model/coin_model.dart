import 'package:flutter_wanandroid/app/base/base_refresh_model.dart';
import 'package:flutter_wanandroid/app/net/request.dart';
import 'package:flutter_wanandroid/entity/coin_info_entity.dart';
import 'package:flutter_wanandroid/entity/coin_list_entity.dart';
import 'package:flutter_wanandroid/entity/my_coin_entity.dart';

class CoinViewModel extends BaseRefreshViewModel<WanAndroidRepository> {
  CoinListEntity _coinListEntity;

  List<CoinDatas> _coinList = [];

  List<CoinDatas> get coinList => _coinList;

  MyCoinEntity _myCoinEntity;

  List<MyCoinDatas> _myCoinList = [];

  List<MyCoinDatas> get myCoinList => _myCoinList;

  CoinInfoEntity _coinInfoEntity=new CoinInfoEntity();

  CoinInfoEntity get coinInfoEntity => _coinInfoEntity;

  int page = 1;

  Future getMyCoinList(bool isRefresh) async {
    if (isRefresh) {
      page = 1;
      _myCoinEntity = await refreshData(
          requestData<MyCoinEntity>(mRepository.myCoinList(page)));
      _myCoinList.clear();
      _myCoinList.addAll(_myCoinEntity.datas);
    } else {
      page++;
      _myCoinEntity = await loadMoreData(
          requestData<MyCoinEntity>(mRepository.myCoinList(page)));
      if (_myCoinEntity.datas.isEmpty) page--;
      _myCoinList.addAll(_myCoinEntity.datas);
    }
  }

  Future getCoinRink(bool isRefresh) async {
    if (isRefresh) {
      page = 1;
      _coinListEntity = await refreshData(
          requestData<CoinListEntity>(mRepository.coinRink(page)));
      _coinList.clear();
      _coinList.addAll(_coinListEntity.datas);
    } else {
      page++;
      _coinListEntity = await loadMoreData(
          requestData<CoinListEntity>(mRepository.coinRink(page)));
      if (_coinListEntity.datas.isEmpty) page--;
      _coinList.addAll(_coinListEntity.datas);
    }
  }

  Future getCoinInfo() async {
    _coinInfoEntity = await requestData<CoinInfoEntity>(mRepository.coinUserInfo());
  }

  @override
  WanAndroidRepository createRepository() {
    return WanAndroidRepository();
  }
}
