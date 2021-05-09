import 'package:flutter_wanandroid/entity/article_bean.dart';
import 'package:flutter_wanandroid/entity/article_entity.dart';
import 'package:flutter_wanandroid/entity/banner_entity.dart';
import 'package:flutter_wanandroid/entity/coin_info_entity.dart';
import 'package:flutter_wanandroid/entity/coin_list_entity.dart';
import 'package:flutter_wanandroid/entity/collect_entity.dart';
import 'package:flutter_wanandroid/entity/my_coin_entity.dart';
import 'package:flutter_wanandroid/entity/navi_entity.dart';
import 'package:flutter_wanandroid/entity/search_str_entity.dart';
import 'package:flutter_wanandroid/entity/tree_entity.dart';
import 'package:flutter_wanandroid/entity/user_data_entity.dart';
import 'package:flutter_wanandroid/entity/user_entity.dart';
import 'package:flutter_wanandroid/entity/wx_account_entity.dart';

class EntityFactory {
  static T generateOBJ<T>(json) {
    if (json == null) {
      return null;
    }
//可以在这里加入任何需要并且可以转换的类型，例如下面
    else if (T.toString() == "UserEntity") {
      return UserEntity().fromJson(json) as T;
    } else if (T.toString() == "BannerEntity") {
      return BannerEntity().fromJson(json) as T;
    } else if (T.toString() == "ArticleEntity") {
      return ArticleEntity().fromJson(json) as T;
    } else if (T.toString() == "ArticleBean") {
      return ArticleBean.fromJson(json) as T;
    } else if (T.toString() == "ArticleDatas") {
      return ArticleDatas.fromJson(json) as T;
    } else if (T.toString() == "TreeEntity") {
      return TreeEntity.fromJson(json) as T;
    } else if (T.toString() == "NaviEntity") {
      return NaviEntity.fromJson(json) as T;
    } else if (T.toString() == "CollectEntity") {
      return CollectEntity.fromJson(json) as T;
    }  else if (T.toString() == "CoinListEntity") {
      return CoinListEntity.fromJson(json) as T;
    } else if (T.toString() == "MyCoinEntity") {
      return MyCoinEntity.fromJson(json) as T;
    }else if (T.toString() == "CoinInfoEntity") {
      return CoinInfoEntity.fromJson(json) as T;
    }else if (T.toString() == "WxThePublicEntity") {
      return WxThePublicEntity.fromJson(json) as T;
    }else if (T.toString() == "UserDataEntity") {
      return UserDataEntity.fromJson(json) as T;
    }else if (T.toString() == "SearchStrEntity") {
      return SearchStrEntity.fromJson(json) as T;
    } else {
      return json as T;
    }
  }
}
