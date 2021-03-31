import 'package:dio/dio.dart';

import 'HttpHelper.dart';
import 'base_repository.dart';

class WanAndroidRepository extends BaseRepository {
  Dio dio = HttpHelper.instance.getDio();

  WanAndroidRepository() {
    setdio(dio);
  }
}
