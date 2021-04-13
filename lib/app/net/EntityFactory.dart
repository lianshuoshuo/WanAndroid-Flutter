import 'package:flutter_wanandroid/entity/article_bean.dart';
import 'package:flutter_wanandroid/entity/article_entity.dart';
import 'package:flutter_wanandroid/entity/banner_entity.dart';
import 'package:flutter_wanandroid/entity/user_entity.dart';

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
    } else {
      return json as T;
    }
  }
}
