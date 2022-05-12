import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:radiosurabhi/ui/screens/webview.dart';

import 'package:webview_flutter/webview_flutter.dart';
import '../widgets/app_scaffold.dart';

class AudioWebViewPage extends StatefulWidget {
  const AudioWebViewPage({Key? key}) : super(key: key);
  static ValueNotifier<bool> loading = ValueNotifier<bool>(false);
  @override
  _AudioWebViewPageState createState() => _AudioWebViewPageState();
}

class _AudioWebViewPageState extends State<AudioWebViewPage>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    AudioWebViewPage.loading.value = true;
    super.initState();
  }

  reloadUrl() {
    setState(() {
      AudioWebViewPage.loading.value = true;
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<bool> onBack() async {
    return (navigator()) ?? false;
  }

  navigator() {
    Navigator.of(context).pushReplacementNamed('/homepage');
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: onBack,
      child: AppScaffold(
        back: true,
        bottom: true,
        body: Builder(builder: (BuildContext context) {
          return WebView(
            initialUrl:
                "https://player.streamguys.com/radiosurabhi/sgplayer/player.php",
            javascriptMode: JavascriptMode.unrestricted,
            onWebViewCreated: (WebViewController webViewController) {},
            onProgress: (int progress) {
              print('WebView is loading (progress : $progress%)');
            },
            onPageFinished: (val) {
              setState(() {
                AudioWebViewPage.loading.value = false;
              });
            },
            onWebResourceError: (error) async {
              if (error.failingUrl ==
                  "https://player.streamguys.com/radiosurabhi/sgplayer/player.php") {
                setState(() {
                  AudioWebViewPage.loading.value = false;
                });
              }
            },
            javascriptChannels: const <JavascriptChannel>{},
          );
        }),
      ),
    );
  }
}
