import 'package:flutter/material.dart';
import 'dart:io';
import 'package:flutter/widgets.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:webview_flutter/webview_flutter.dart';


class PageWebView extends StatefulWidget {
  final String? url;
  final String? title;

  const PageWebView({Key? key, this.url, this.title}) : super(key: key);

  @override
  _PageWebView createState() => _PageWebView();
}

class _PageWebView extends State<PageWebView> {
  bool _loading = true;

  _PageWebView();

  @override
  void initState() {
    super.initState();
    if (Platform.isAndroid) {
      WebView.platform = SurfaceAndroidWebView();
    }
  }

  @override
  dispose() {
    super.dispose();
  }

  reloadUrl() {
    setState(() {
      _loading = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget content;

    content = _buildContent();

    return SafeArea(
        child: Scaffold(
            appBar: AppBar(
              iconTheme: IconThemeData(
                color: Colors.black, //change your color here
              ),
              elevation: 0,

              backgroundColor: Colors.transparent,
              centerTitle: true,
              title: widget.title == null
                  ? null
                  : Text(
                      widget.title!,
                    ),
              bottom: _loading
                  ? MyLinearProgressIndicator(
                      backgroundColor: Colors.green,
                      valueColor: const AlwaysStoppedAnimation(Colors.white),
                    )
                  : const PreferredSize(
                      preferredSize:  Size(1, 1),
                      child: SizedBox(
                        height: 1,
                      ),
                    ),
            ),
            body: content));
  }

  Widget _buildContent() {
    return Builder(builder: (BuildContext context) {
      return WebView(
        initialUrl: widget.url,
        javascriptMode: JavascriptMode.unrestricted,
        onWebViewCreated: (WebViewController webViewController) {},
        onProgress: (int progress) {
          print('WebView is loading (progress : $progress%)');
        },
        onPageFinished: (val) {
          setState(() {
            _loading = false;
          });
        },
        onWebResourceError: (error) async {
          if (error.failingUrl == widget.url) {
            setState(() {
              _loading = false;
            });
          }
          
        },
        javascriptChannels: <JavascriptChannel>{},
      );
    });
  }
}

class MyLinearProgressIndicator extends LinearProgressIndicator
    implements PreferredSizeWidget {
  MyLinearProgressIndicator({
    Key? key,
    double? value,
    Color? backgroundColor,
    Animation<Color>? valueColor,
  }) : super(
          key: key,
          value: value,
          backgroundColor: backgroundColor,
          valueColor: valueColor,
        ) {
    preferredSize = const Size(double.infinity, 1);
  }

  @override
  late Size preferredSize;
}
