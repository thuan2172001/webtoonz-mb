import 'package:flutter/material.dart';
import 'package:untitled/screen/series_detail/episode_card.dart';
import 'package:untitled/model/Serie.dart';

class FavoriteEpisodeScreen extends StatelessWidget{
  final List<SeriesEpisode> favoriteEpisode;

  const FavoriteEpisodeScreen({Key? key, required this.favoriteEpisode})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.white,
        padding: EdgeInsets.only(top: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 0),
                child: GridView.builder(
                  shrinkWrap: true,
                  itemCount: favoriteEpisode.length,
                  itemBuilder: (BuildContext context, int index) {
                    return EpisodeCard(episode: favoriteEpisode[index]);
                  },
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 0,
                      mainAxisSpacing: 0,
                      childAspectRatio: 4 / 5.7),
                )
              ),
            ),
          ],
        )
    );
  }
}