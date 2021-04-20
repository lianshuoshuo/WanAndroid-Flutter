import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_wanandroid/app/net/AppException.dart';
import 'package:flutter_wanandroid/app/net/base_repository.dart';
import 'package:flutter_wanandroid/app/net/base_result.dart';
import 'package:flutter_wanandroid/app/provider/loading_state.dart';
import 'package:flutter_wanandroid/app/provider/view_state.dart';
import 'package:fluttertoast/fluttertoast.dart';

abstract class BaseViewModel<T extends BaseRepository> extends ChangeNotifier {
  /// 防止页面销毁后,异步任务才完成,导致报错
  bool disposed = false;

  /// 初始化状态为加载中
  ViewState _state = ViewState.Idle;

  ViewState get state => _state;

  /// 错误状态类
  ViewStateError _viewStateError;

  ViewStateError get viewStateError => _viewStateError;

  T mRepository;

  ///加载弹窗
  var loadingChange = LoadingProvider();

  BaseViewModel({ViewState state}) {
    this._state = state ?? ViewState.Idle;
    mRepository = createRepository();
  }

  ///请求结果过滤
  Future<dynamic> requestData<N>(dynamic f,
      {bool isShowPageState = false, bool isShowLoadDialog = false}) async {
    _state = ViewState.loading;
    var result;
    try {
      if (isShowPageState) setLoading();
      if (isShowLoadDialog) loadingChange.showDialog.notifyListeners();
      var baseEntity = BaseEntity<N>.fromJson(await f);
      if (baseEntity.errorCode == 0) {
        // 数据请求成功
        setSuccess();
        result = baseEntity.data;
      } else {
        throw result;
      }
    } catch (e) {
      if (isShowPageState) setError(Error(), message: "请求失败");
      Fluttertoast.showToast(msg: e.errorMsg);
      throw AppException(e.errorMsg, e.errorCode);
    } finally {
      if (isShowLoadDialog) loadingChange.dismissDialog.notifyListeners();
    }
    return result;
  }

  ///请求结果过滤

  Future<dynamic> requestListData<N>(dynamic f,
      {bool isShowPageState = false, bool isShowLoadDialog = false}) async {
    _state = ViewState.loading;
    var result;
    try {
      if (isShowPageState) setLoading();
      if (isShowLoadDialog) loadingChange.showDialog.notifyListeners();
      var baseListEntity = BaseListEntity<N>.fromJson(await f);
      if (baseListEntity.errorCode == 0) {
        // 数据请求成功
        setSuccess();
        result = baseListEntity.data;
      } else {
        throw result;
      }
    } catch (e) {
      if (isShowPageState) setError(Error(), message: "请求失败");
      Fluttertoast.showToast(msg: e.errorMsg);
      throw AppException(e.errorMsg, e.errorCode);
    } finally {
      if (isShowLoadDialog) loadingChange.dismissDialog.notifyListeners();
    }
    return result;
  }

  /// 提供一个创建Repository对象的抽象方法T createRepository();
  T createRepository();

  @override
  void notifyListeners() {
    if (!disposed) {
      super.notifyListeners();
    }
  }

  @override
  void dispose() {
    disposed = true;
    super.dispose();
  }

  /// 初始化状态
  void setLoading() {
    debugPrint("build_${this.toString()}_loading");
    setState(ViewState.loading);
  }

  /// 数据成功不为空
  void setSuccess() {
    debugPrint("build_${this.toString()}_success");
    setState(ViewState.success);
  }

  /// 数据成功且为空
  void setEmpty() {
    debugPrint("build_${this.toString()}_empty");
    setState(ViewState.empty);
  }

  /// 数据异常
  void setError(e, {String message}) {
    debugPrint("build_${this.toString()}_error");
    if (e is DioError) {
      e = e.error;
      message = e.message;
    }
    _viewStateError = new ViewStateError(error: e, message: message);
    setState(ViewState.error);
  }

  ///没有网络
  void setNoNetWork() {
    debugPrint("build_${this.toString()}_noNetwork");
    setState(ViewState.noNetwork);
  }

  /// 设置状态改变
  void setState(ViewState state) {
    this._state = state;
    notifyListeners();
  }

  /// 加载中状态
  bool isLoading() {
    return this._state == ViewState.loading;
  }

  /// 数据为空状态
  bool isEmpty() {
    return this._state == ViewState.empty;
  }

  /// 数据异常状态
  bool isError() {
    return this._state == ViewState.error;
  }

  /// 数据加载成功状态 不为空
  bool isSuccess() {
    return this._state == ViewState.success;
  }

  bool isNoNetWork() {
    return this._state == ViewState.noNetwork;
  }

  bool isIdle() {
    return this._state == ViewState.Idle;
  }

  /// 是否是成功显示数据状态
  /// false 表示数据状态为加载中 数据为空 或者数据加载失败
  /// true 数据成功 or 刷新状态 or 加载更多状态
  bool isSuccessShowDataState() {
    return isSuccess();
  }
}
