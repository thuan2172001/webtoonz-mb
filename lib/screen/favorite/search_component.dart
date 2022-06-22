import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:untitled/controller/episode_detail/episode_detail_controller.dart';
import 'package:untitled/controller/series_detail/series_detail_controller.dart';
import 'package:untitled/model/Serie.dart';
import 'package:untitled/screen/episode_detail/episode_detail_screen.dart';
import 'package:untitled/screen/series_detail/series_detail_screen.dart';

class SearchEpisode extends StatefulWidget {
  final List<SeriesEpisode> episodes;

  SearchEpisode({Key? key, required this.episodes}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _SearchEpisodeScreen();
  }
}

class _SearchEpisodeScreen extends State<SearchEpisode> {
  List<SeriesEpisode> _searchResult = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF3669C9),
        title: TextField(
          cursorColor: Colors.black,
          decoration: new InputDecoration.collapsed(
            hintText: " Search episode",
            hintStyle: TextStyle(fontWeight: FontWeight.bold, color: Colors.black54),
          ),
          onChanged: (text) => setState(() {
            _searchResult = search(text);
          }),
        ),
        leading: Icon(Icons.search),
        actions: [
          IconButton(
              onPressed: () => setState(() {
                _searchResult = [];
                Get.back();
              }),
              icon: Icon(Icons.cancel))
        ],
      ),
      body: ListView.builder(
        itemCount: _searchResult.length,
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            onTap: () async {
              var episodeId=_searchResult[index].episodeId;
              var nextController=Get.put(EpisodeDetailController());
              nextController.episodeId=episodeId;
              await nextController.getApi();
              Get.to(() =>
                  EpisodeDetailScreen(episodeId: episodeId));
            },
            child: ListTile(
              leading: ConstrainedBox(
                constraints: BoxConstraints(
                  maxWidth: double.infinity,
                  maxHeight: double.infinity,
                ),
                child: Image.network(
                    _searchResult[index].thumbnail),
              ),
              title: Text(_searchResult[index].name),
              subtitle: Text(
                  "Chapter ${_searchResult[index].chapter}"),
            ),
          );
        },
      ),
    );
  }

  List<SeriesEpisode> search (String text) {
    if (text == "") return [];
    List<SeriesEpisode> result = widget.episodes;
    return result.where((episode) => episode.name.toLowerCase().contains(text.toLowerCase())).toList();
  }
}

class SearchSeries extends StatefulWidget {
  final List<Series> series;

  SearchSeries({Key? key, required this.series}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _SearchSeriesScreen();
  }
}

class _SearchSeriesScreen extends State<SearchSeries> {
  List<Series> _searchResult = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF3669C9),
        title: TextField(
          cursorColor: Colors.black,
          decoration: new InputDecoration.collapsed(
            hintText: " Search series",
            hintStyle: TextStyle(fontWeight: FontWeight.bold, color: Colors.black54),
          ),
          onChanged: (text) => setState(() {
            _searchResult = searchSeries(text);
          }),
        ),
        leading: Icon(Icons.search),
        actions: [
          IconButton(
              onPressed: () => setState(() {
                _searchResult = [];
                Get.back();
              }),
              icon: Icon(Icons.cancel))
        ],
      ),
      body: ListView.builder(
        itemCount: _searchResult.length,
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            onTap: () async {
              await Get.put(SerieDetailController())
                  .fetchSerie(_searchResult[index].serieId);
              Get.to(() => SeriesDetailScreen(serieId: _searchResult[index].serieId));
            },
            child: ListTile(
              leading: ConstrainedBox(
                constraints: BoxConstraints(
                  maxWidth: double.infinity,
                  maxHeight: double.infinity,
                ),
                child: Image.network(
                    _searchResult[index].thumbnail),
              ),
              title: Text(_searchResult[index].serieName),
              subtitle: Text(
                  "${_searchResult[index].description}",
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis),
            ),
          );
        },
      ),
    );
  }

  List<Series> searchSeries (String text) {
    if (text == "") return [];
    List<Series> result = widget.series;
    return result.where((series) => series.serieName.toLowerCase().contains(text.toLowerCase())).toList();
  }
}
