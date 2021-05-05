import 'package:flutter/material.dart';
import 'package:flutter_wanandroid/app/ext/ext_widget.dart';
import 'package:flutter_wanandroid/app/provider/provider_widget.dart';
import 'package:flutter_wanandroid/app/router/routers.dart';
import 'package:flutter_wanandroid/entity/my_coin_entity.dart';
import 'package:flutter_wanandroid/model/coin_model.dart';
import 'package:flutter_wanandroid/widget/app_bar_white.dart';
import 'package:flutter_wanandroid/widget/custom_refresh_widget.dart';
import 'package:flutter_wanandroid/widget/view_state_helper.dart';
import 'package:loading_indicator_view/loading_indicator_view.dart';

///个人积分
class CoinPage extends StatefulWidget {
  @override
  _CoinPageState createState() => _CoinPageState();
}

class _CoinPageState extends State<CoinPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffe8e8e8),
      appBar: appBarWhite('我的积分'),
      body: ProviderWidget<CoinViewModel>(
        initData: (model) {
          model.getCoinInfo();
          model.getMyCoinList(true);
        },
        model: CoinViewModel(),
        builder: (_, model, child) {
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
                model.getMyCoinList(true);
              },
            );
          }
          return CustomCommonRefreshWidget(
            enableRefresh: true,
            enableLoad: true,
            onRefresh: () {
              return model.getMyCoinList(true);
            },
            onLoadMore: () {
              return model.getMyCoinList(false);
            },
            easyRefreshController: model.easyRefreshController,
            slivers: [buildHeader(model), _buildList(model)],
          );
        },
      ),
    );
  }

  ///数字文字样式
  TextStyle numberTextStyle = TextStyle(fontSize: 18);

  ///头部
  Widget buildHeader(CoinViewModel model) {
    return SliverToBoxAdapter(
      child: Container(
        margin: EdgeInsets.all(10),
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(5))),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "${model.coinInfoEntity.coinCount ?? "-"}",
                  style: numberTextStyle,
                ),
                Text("总积分").setMargin(EdgeInsets.only(top: 10))
              ],
            ),
            GestureDetector(
              onTap: () {
                Navigator.of(context).pushNamed(routers.COIN_RINK);
              },
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "${model.coinInfoEntity.rank ?? "-"}",
                    style: numberTextStyle,
                  ),
                  Text("当前排名").setMargin(EdgeInsets.only(top: 10))
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildList(CoinViewModel model) {
    var coinList = model.myCoinList;

    return SliverToBoxAdapter(
      child: Align(
        child: Container(
            padding: EdgeInsets.all(10),
            margin: EdgeInsets.only(left: 10, right: 10, bottom: 10),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(5))),
            child: MediaQuery.removePadding(
                context: context,
                removeTop: true,
                removeBottom: true,
                child: ListView.separated(
                  physics: NeverScrollableScrollPhysics(),
                  separatorBuilder: (context, index) {
                    return Divider();
                  },
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    MyCoinDatas coin = coinList[index];
                    return ListTile(
                      title: Text(coin.reason),
                      subtitle: Text(coin.desc),
                      trailing: Text((coin.type == 1 ? '+' : '-') +
                          coin.coinCount.toString(),style: TextStyle(fontSize: 16),),
                    );
                  },
                  itemCount: coinList.length,
                ))),
      ),
    );
  }
}
