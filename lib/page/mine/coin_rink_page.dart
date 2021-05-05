import 'package:flutter/material.dart';
import 'package:flutter_wanandroid/app/ext/ext_widget.dart';
import 'package:flutter_wanandroid/app/provider/provider_widget.dart';
import 'package:flutter_wanandroid/model/coin_model.dart';
import 'package:flutter_wanandroid/widget/app_bar_white.dart';
import 'package:flutter_wanandroid/widget/custom_refresh_widget.dart';
import 'package:flutter_wanandroid/widget/view_state_helper.dart';
import 'package:loading_indicator_view/loading_indicator_view.dart';

///积分排名
class CoinRinkPage extends StatefulWidget {
  @override
  _CoinRinkPageState createState() => _CoinRinkPageState();
}

class _CoinRinkPageState extends State<CoinRinkPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarWhite('积分排名'),
      body: ProviderWidget<CoinViewModel>(
          initData: (model) {
            model.getCoinRink(true);
          },
          model: CoinViewModel(),
          builder: (context, model, child) {
            return ProviderWidget<CoinViewModel>(
                initData: (model) {
                  model.getCoinRink(true);
                },
                model: CoinViewModel(),
                builder: (context, model, child) {
                  if (model.isLoading()) {
                    return Center(
                      child: LineScaleIndicator(
                        lineColor: Colors.lightBlue,
                      ),
                    );
                  } else if (model.isEmpty() && model.myCoinList.isEmpty) {
                    return CommonViewStateHelper(
                      model: model,
                      onEmptyPressed: () {
                        model.getCoinRink(true);
                      },
                    );
                  }
                  var coinList = model.coinList;
                  return CustomCommonRefreshWidget(
                    enableRefresh: true,
                    enableLoad: true,
                    onLoadMore: () {
                      return model.getCoinRink(false);
                    },
                    onRefresh: () {
                      return model.getCoinRink(true);
                    },
                    easyRefreshController: model.easyRefreshController,
                    slivers: [
                      SliverToBoxAdapter(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            _flexText('排名'),
                            _flexText('昵称'),
                            _flexText('等级'),
                            _flexText('获得积分')
                          ],
                        ).setMargin(EdgeInsets.only(top: 10, bottom: 10)),
                      ),
                      SliverList(
                          delegate:
                              SliverChildBuilderDelegate((context, index) {
                        var coin = coinList[index];
                        return Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                _flexText('${coin.rank}'),
                                _flexText('${coin.username}'),
                                _flexText('${coin.level}'),
                                _flexText('${coin.coinCount}')
                              ],
                            ),
                            Divider()
                          ],
                        );
                      }, childCount: coinList.length))
                    ],
                  );
                });
          }),
    );
  }

  Widget _flexText(String str) {
    return Expanded(
        child: Center(
      child: Text(
        str,
        style: TextStyle(fontSize: 16),
      ),
    ));
  }
}
