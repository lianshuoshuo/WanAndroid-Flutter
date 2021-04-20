import 'package:flutter/material.dart';
import 'package:flutter_wanandroid/app/base/base_model.dart';
import 'package:flutter_wanandroid/widget/LoadingDialog.dart';
import 'package:provider/provider.dart';

//封装需要Provider 管理页面状态的组件
class ProviderWidget<T extends BaseViewModel> extends StatefulWidget {
  final T model;
  final ValueWidgetBuilder<T> builder;
  final Widget child;

  final Function(T model) initData;

  LoadingDialog loadingDialog;

  ProviderWidget(
      {@required this.model,
      @required this.builder,
      this.child,
      this.initData});

  @override
  State<StatefulWidget> createState() {
    return _ProviderWidget<T>();
  }
}

class _ProviderWidget<T extends BaseViewModel>
    extends State<ProviderWidget<T>> {
  T model;

  @override
  void initState() {
    model = widget.model;
    widget.initData?.call(model);
    super.initState();
  }

  @override
  void didChangeDependencies() {
    registerLoading();
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    //当页面销毁时 销毁model
    model.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: model,
      child: Consumer(
        //此组件的作用  局部刷新  当界面需要刷新时 只刷新 builder , child组件不刷新
        builder: widget.builder,
        child: widget.child,
      ),
    );
  }

  void registerLoading() {
    model.loadingChange.showDialog.addListener(() {
      print("loading...");
      showLoading();
    });
    model.loadingChange.dismissDialog.addListener(() {
      print("loadingEnd...");
      dismissLoading();
    });
  }

  void showLoading() {
    if (widget.loadingDialog == null) {
      widget.loadingDialog = LoadingDialog();
    }
    showDialog(context: context, builder: (ctx) => widget.loadingDialog);
  }

  void dismissLoading() {
    if (widget.loadingDialog != null) {
      widget.loadingDialog.dismissDialog();
      widget.loadingDialog = null;
    }
  }
}

class ProviderWidget2<A extends BaseViewModel, B extends BaseViewModel>
    extends StatefulWidget {
  /// viewModel
  final A modelA;
  final B modelB;
  final Widget Function(BuildContext context, A model1, B model2, Widget child)
      builder;
  final Widget child;

  LoadingDialog loadingDialog;

  /// 初始化数据
  final  Function(A modelA, B modelB) initData;

  @override
  State<StatefulWidget> createState() => _ProviderWidget2State<A, B>();

  ProviderWidget2(
      {@required this.modelA,
      @required this.modelB,
      @required this.builder,
      this.child,
      this.initData});
}

class _ProviderWidget2State<A extends BaseViewModel, B extends BaseViewModel>
    extends State<ProviderWidget2<A, B>> {
  A modelA;
  B modelB;

  @override
  void initState() {
    modelA = widget.modelA;
    modelB = widget.modelB;
    widget.initData?.call(modelA, modelB);
    super.initState();
  }

  @override
  void didChangeDependencies() {
    registerLoading();
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    modelA.dispose();
    modelB.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<A>.value(value: modelA),
        ChangeNotifierProvider<B>.value(value: modelB),
      ],
      child: Consumer2<A, B>(
        builder: widget.builder,
        child: widget.child,
      ),
    );
  }

  void registerLoading() {
    modelA.loadingChange.showDialog.addListener(() {
      print("loading...");
      showLoading();
    });
    modelA.loadingChange.dismissDialog.addListener(() {
      print("loadingEnd...");
      dismissLoading();
    });
    modelB.loadingChange.showDialog.addListener(() {
      print("loading...");
      showLoading();
    });
    modelB.loadingChange.dismissDialog.addListener(() {
      print("loadingEnd...");
      dismissLoading();
    });
  }

  void showLoading() {
    if (widget.loadingDialog == null) {
      widget.loadingDialog = LoadingDialog();
    }
    showDialog(context: context, builder: (ctx) => widget.loadingDialog);
  }

  void dismissLoading() {
    if (widget.loadingDialog != null) {
      widget.loadingDialog.dismissDialog();
      widget.loadingDialog = null;
    }
  }
}
