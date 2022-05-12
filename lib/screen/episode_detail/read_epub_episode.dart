import 'package:epub_view/epub_view.dart';
import 'package:flutter/material.dart';
import 'package:internet_file/internet_file.dart';

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
  late EpubController _epubController;

  Future fetchEpisode() async {
    var doc = await InternetFile.get(
        'https://webtoonz.uetbc.xyz/uploads/${widget.episodeKey}');
    _epubController = EpubController(document: EpubDocument.openData(doc));
  }

  @override
  void dispose() {
    _epubController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: fetchEpisode(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return Scaffold(
              appBar: AppBar(
                title: EpubViewActualChapter(
                  controller: _epubController,
                  builder: (chapterValue) => Text(
                    chapterValue?.chapter?.Title?.replaceAll('\n', '').trim() ??
                        '',
                    textAlign: TextAlign.start,
                  ),
                ),
                actions: <Widget>[
                  IconButton(
                    icon: const Icon(Icons.save_alt),
                    color: Colors.white,
                    onPressed: () => _showCurrentEpubCfi(context),
                  ),
                ],
              ),
              drawer: Drawer(
                child: EpubViewTableOfContents(controller: _epubController),
              ),
              body: EpubView(
                builders: EpubViewBuilders<DefaultBuilderOptions>(
                  options: const DefaultBuilderOptions(),
                  chapterDividerBuilder: (_) => const Divider(),
                ),
                controller: _epubController,
              ),
            );
          } else if (snapshot.hasError)
            return Column(
              children: [
                Text(
                  snapshot.error.toString(),
                ),
              ],
            );
          return Center(
            child: CircularProgressIndicator(),
          );
        });
  }

  void _showCurrentEpubCfi(context) {
    final cfi = _epubController.generateEpubCfi();

    if (cfi != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(cfi),
          action: SnackBarAction(
            label: 'GO',
            onPressed: () {
              _epubController.gotoEpubCfi(cfi);
            },
          ),
        ),
      );
    }
  }
}
