import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:untitled/widgets/app_bar.dart';

class ReadPDFScreen extends StatelessWidget {
  final String episodeKey;
  final String episodeTitle;

  const ReadPDFScreen(
      {Key? key, required this.episodeKey, required this.episodeTitle})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: appBar(title: episodeTitle, centerTitle: true),
        body: SfPdfViewer.network(
            'https://webtoonz.uetbc.xyz/uploads/$episodeKey'));
  }
}
