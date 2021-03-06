import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';

typedef OnRefreshCallback = Future<void> Function();
typedef OnLoadMoreCallback = Future<void> Function();

class CustomHeaderRefreshWidget extends StatelessWidget {
  CustomHeaderRefreshWidget(
      {@required this.slivers,
      @required this.onRefresh,
      @required this.easyRefreshController});

  List<Widget> slivers;
  OnRefreshCallback onRefresh;
  EasyRefreshController easyRefreshController;

  @override
  Widget build(BuildContext context) {
    debugPrint("build_header_refresh");
    return CustomCommonRefreshWidget(
        slivers: slivers,
        easyRefreshController: easyRefreshController,
        onRefresh: onRefresh,
        enableRefresh: true);
  }
}

class CustomFooterLoadMoreWidget extends StatelessWidget {
  CustomFooterLoadMoreWidget({
    @required this.slivers,
    @required this.onLoadMore,
    @required this.easyRefreshController,
  });

  List<Widget> slivers;
  OnLoadMoreCallback onLoadMore;
  EasyRefreshController easyRefreshController;

  @override
  Widget build(BuildContext context) {
    debugPrint("build_footer_onLoad");
    return CustomCommonRefreshWidget(
      slivers: slivers,
      easyRefreshController: easyRefreshController,
      onLoadMore: onLoadMore,
      enableLoad: true,
    );
  }
}

class CustomCommonRefreshWidget extends StatefulWidget {
  List<Widget> slivers;
  bool enableRefresh;
  bool enableLoad;
  int count;
  OnRefreshCallback onRefresh;
  OnLoadMoreCallback onLoadMore;
  EasyRefreshController easyRefreshController;
  ScrollController scrollController;
  Header mHeader;

  CustomCommonRefreshWidget(
      {@required this.slivers,
      @required this.easyRefreshController,
      this.onRefresh,
      this.onLoadMore,
      this.enableRefresh = false,
      this.enableLoad = false,
      this.scrollController,
      this.mHeader});

  @override
  _CustomCommonRefreshWidgetState createState() =>
      _CustomCommonRefreshWidgetState();
}

class _CustomCommonRefreshWidgetState extends State<CustomCommonRefreshWidget> {
  _CustomCommonRefreshWidgetState();

  // ??????
  bool _reverse = false;

  // ??????
  Axis _direction = Axis.vertical;

  // Header??????
  bool _headerFloat = false;

  // ????????????
  bool _enableInfiniteLoad = true;

  // ????????????
  bool _enableControlFinish = false;

  // ????????????
  bool _taskIndependence = false;

  // ??????
  bool _vibration = true;

  // ??????????????????
  bool _enableRefresh = true;

  // ??????????????????
  bool _enableLoad = true;

  // ????????????
  bool _topBouncing = true;

  // ????????????
  bool _bottomBouncing = true;

  ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
  }

  @override
  Widget build(BuildContext context) {
    return EasyRefresh.custom(
      enableControlFinishRefresh: true,
      enableControlFinishLoad: true,
      taskIndependence: _taskIndependence,
      controller: widget.easyRefreshController,
      scrollController: widget.scrollController ?? _scrollController,
      reverse: _reverse,
      scrollDirection: _direction,
      topBouncing: _topBouncing,
      bottomBouncing: _bottomBouncing,
      header: widget.enableRefresh
          ? (widget.mHeader ??
              ClassicalHeader(
                enableInfiniteRefresh: false,
                bgColor: _headerFloat ? Theme.of(context).primaryColor : null,
                infoColor: _headerFloat ? Colors.black87 : Colors.teal,
                float: _headerFloat,
                enableHapticFeedback: _vibration,
                refreshText: "????????????...",
                refreshReadyText: "??????????????????...",
                refreshingText: "?????????...",
                refreshedText: "????????????...",
                refreshFailedText: "????????????...",
                noMoreText: "?????????????????????...",
                infoText: "????????????: ${getCurrentTime()}",
              ))
          : null,
      footer: widget.enableLoad
          ? ClassicalFooter(
              enableInfiniteLoad: _enableInfiniteLoad,
              enableHapticFeedback: _vibration,
              loadText: "?????????...",
              loadReadyText: "?????????...",
              loadingText: "?????????...",
              loadedText: "????????????...",
              loadFailedText: "????????????...",
              noMoreText: "?????????????????????...",
              infoText: "????????????: ${getCurrentTime()}",
              overScroll: true)
          : null,
      onRefresh: widget.enableRefresh ? widget.onRefresh : null,
      onLoad: widget.enableLoad ? widget.onLoadMore : null,
      slivers: widget.slivers,
    );
  }

  String getCurrentTime() {
    var now = DateTime.now();
    return formatDate(now, [hh, ':', nn]);
  }
}
