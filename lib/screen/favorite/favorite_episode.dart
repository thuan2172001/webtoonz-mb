import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:untitled/controller/favorite/favorite_episode_controller.dart';
import 'package:untitled/screen/episode_detail/episode_detail_screen.dart';
import 'package:untitled/screen/series_detail/episode_card.dart';

class FavoriteEpisodeScreen extends StatelessWidget{
  final FavoriteEpisode favoriteEpisode;

  const FavoriteEpisodeScreen({Key? key, required this.favoriteEpisode})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.white,
        padding: EdgeInsets.only(top: 20),
        child: ListView(
          children: <Widget>[
            GridView.builder(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: favoriteEpisode.listEpisode.length,
              itemBuilder: (BuildContext context, int index) {
                return GestureDetector(
                  onTap: () {
                    Get.to(() => EpisodeDetailScreen(
                        episodeId: favoriteEpisode.listEpisode[index].episodeId));
                  },
                  child: EpisodeCard(episode: favoriteEpisode.listEpisode[index])
                );
              },
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 0,
                  mainAxisSpacing: 20,
                  childAspectRatio: 4 / 5.7),
            ),
          ],
        )
    );
  }
}