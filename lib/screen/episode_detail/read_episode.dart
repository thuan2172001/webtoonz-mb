import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:untitled/widgets/app_bar.dart';

class ReadEpisodeScreen extends StatelessWidget {
  final String episodeKey;
  final String episodeTitle;

  const ReadEpisodeScreen(
      {Key? key, required this.episodeKey, required this.episodeTitle})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    print('https://webtoonz.uetbc.xyz/uploads/$episodeKey');
    return Scaffold(
        appBar: appBar(title: episodeTitle, centerTitle: true),
        body: SfPdfViewer.network(
            'https://webtoonz.uetbc.xyz/uploads/$episodeKey'));
  }
}
