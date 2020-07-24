import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:sarasotamemorial/theme.dart';
import 'package:sarasotamemorial/widgets/customtext.dart';
import 'package:webview_flutter/webview_flutter.dart' as prefix0;

class WebView extends StatefulWidget {
  final String url;
  final String title;

  WebView({
    this.title,
    this.url,
  });

  @override
  _WebViewState createState() => _WebViewState();
}

class _WebViewState extends State<WebView> {
  final Completer<prefix0.WebViewController> _controller =
      Completer<prefix0.WebViewController>();

  @override
  Widget build(BuildContext context) {
    MyTheme.init(context);

    print(widget.url);
    return WebviewScaffold(
        url: widget.url,
        appBar: AppBar(
          title: CustomText(
            size: MyTheme.normalTextSize(),
            title: widget.title,
          ),
        ),
        initialChild: Container(
          child: CircularProgressIndicator(),
          height: double.infinity,
          width: double.infinity,
        ));
  }

  prefix0.JavascriptChannel _toasterJavascriptChannel(BuildContext context) {
    return prefix0.JavascriptChannel(
        name: 'Toaster',
        onMessageReceived: (prefix0.JavascriptMessage message) {
          Scaffold.of(context).showSnackBar(
            SnackBar(content: Text(message.message)),
          );
        });
  }
}
