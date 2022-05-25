import 'dart:io';

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class ReadEpubScreen extends StatefulWidget {
  final String episodeKey;
  final String episodeTitle;

  const ReadEpubScreen(
      {Key? key, required this.episodeKey, required this.episodeTitle})
      : super(key: key);

  @override
  State<ReadEpubScreen> createState() => _ReadEpubScreenState();
}

class _ReadEpubScreenState extends State<ReadEpubScreen> {
  @override
  void initState() {
    super.initState();
    if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
  }

  @override
  Widget build(BuildContext context) {
    var encodedUrl = Uri.encodeFull(
        "https://webtoonz-s3.uetbc.xyz/?book=${widget.episodeKey}");
    return Scaffold(
      //appBar: appBar(title: widget.episodeTitle, centerTitle: true),
      body: WebView(
        initialUrl: encodedUrl,
        javascriptMode: JavascriptMode.unrestricted,
        onProgress: (int progress) {
          print('WebView is loading (progress : $progress%)');
        },
        gestureNavigationEnabled: true,
      ),
    );
  }
}
