import 'dart:io';

import 'package:flutter/material.dart';
import 'package:loading_indicator_view/loading_indicator_view.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebPage extends StatefulWidget {
  @override
  _WebPageState createState() => _WebPageState();
}

class _WebPageState extends State<WebPage> {
  String mUrl;
  ValueNotifier<String> mTitle;
  ValueNotifier<bool> isPageFinished;
  WebViewController _webViewController;

  @override
  void initState() {
    super.initState();
    if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
    mTitle = ValueNotifier("flutter_wanAndroid");
    isPageFinished = ValueNotifier(false);
  }

  @override
  Widget build(BuildContext context) {
    mUrl = ModalRoute.of(context).settings.arguments.toString();
    print(this.toString() + ":$mUrl");
    return Scaffold(
      appBar: AppBar(
        title: ValueListenableBuilder(
            valueListenable: mTitle,
            builder: (context, value, child) {
              return Text(
                value.toString(),
                style: TextStyle(fontSize: 16),
              );
            }),
      ),
      body: Stack(
        children: [
          WebView(
            initialUrl: mUrl,
            javascriptMode: JavascriptMode.unrestricted,
            onWebViewCreated: (controller) {
              _webViewController = controller;
            },
            onPageFinished: (value) {
              _webViewController
                  .evaluateJavascript('document.title')
                  .then((value) => mTitle.value = value);
              isPageFinished.value = true;
            },
          ),
          ValueListenableBuilder(
              valueListenable: isPageFinished,
              builder: (context, value, child) {
                return Visibility(
                    visible: !value,
                    child: Center(
                      child: LineScaleIndicator(
                        lineColor: Colors.lightBlue,
                      ),
                    ));
              })
        ],
      ),
    );
  }
}
