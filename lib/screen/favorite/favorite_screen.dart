import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:untitled/utils/config.dart';
import 'package:untitled/screen/favorite/favorite_episode.dart';
import 'package:untitled/screen/favorite/favorite_series.dart';
import 'package:untitled/controller/favorite/favorite_episode_controller.dart';
import 'package:untitled/controller/favorite/favorite_series_controller.dart';

class FavoriteScreen extends StatelessWidget {
  late FavoriteSeriesController favoriteSeriesController;

  @override
  Widget build(BuildContext context) {
    favoriteSeriesController = Get.put(FavoriteSeriesController());

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        shape: Border(
            bottom: BorderSide(
                color: Color(0xFFD5D5D5),
                width: 1
            )
        ),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: getWidth(20)),
        child: DefaultTabController(
          length: 2,
          child: Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.white,
              toolbarHeight: 20,
              elevation: 0.0,
              bottom: TabBar(
                unselectedLabelColor: Colors.black,
                indicatorSize: TabBarIndicatorSize.tab,
                indicator: BoxDecoration(
                  gradient: LinearGradient(
                      colors: [Color(0xFF3669C9), Color(0xFF3669C9)]),
                ),
                tabs: [
                  Tab(text: "Series"),
                  Tab(text: "Episode")
                ],
              ),
            ),
            body: TabBarView(
              children: [
                FavoriteSeriesScreen(favoriteSeries: favoriteSeriesController.favoriteSeries.value),
                FavoriteEpisodeScreen(favoriteEpisode: buildFavoriteEpisode()),
              ],
            ),
          ),
        ),
      ),
    );
  }
}