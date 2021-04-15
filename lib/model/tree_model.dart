import 'package:flutter_wanandroid/app/base/base_model.dart';
import 'package:flutter_wanandroid/app/net/request.dart';
import 'package:flutter_wanandroid/entity/tree_entity.dart';

class TreeViewModel extends BaseViewModel<WanAndroidRepository> {
  List<TreeEntity> _treeList;

  List<TreeEntity> get treeList => _treeList;

  @override
  WanAndroidRepository createRepository() {
    return WanAndroidRepository();
  }

  Future<dynamic> getTree() async {
    _treeList = await requestListData<TreeEntity>(mRepository.getTree());
  }
}
