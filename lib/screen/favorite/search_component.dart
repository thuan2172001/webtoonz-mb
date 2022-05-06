import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:untitled/controller/episode_detail/episode_detail_controller.dart';
import 'package:untitled/model/Serie.dart';
import 'package:untitled/screen/episode_detail/episode_detail_screen.dart';


class SearchEpisode extends StatefulWidget {
  final List<SeriesEpisode> episodes;

  SearchEpisode({Key? key, required this.episodes}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _SearchScreen();
  }
}

class _SearchScreen extends State<SearchEpisode> {
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
              var episodeDetailController = EpisodeDetailController(
                  episodeId: _searchResult[index].episodeId);
              await episodeDetailController.getApi();
              Get.to(() =>
                  EpisodeDetailScreen(controller: episodeDetailController));
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
