import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:untitled/utils/config.dart';
import 'package:untitled/widgets/app_bar.dart';
import 'package:untitled/screen/favorite/favorite_episode.dart';
import 'package:untitled/screen/favorite/favorite_series.dart';
import 'package:untitled/controller/favorite/favorite_episode_controller.dart';
import 'package:untitled/controller/favorite/favorite_series_controller.dart';

class FavoriteScreen extends StatelessWidget {
  late FavoriteSeriesController favoriteSeriesController;
  late FavoriteEpisodeController favoriteEpisodeController;

  static const Color defaultColor = Color(0xFF3669C9);

  @override
  Widget build(BuildContext context) {
    favoriteSeriesController = Get.put(FavoriteSeriesController());
    favoriteEpisodeController = Get.put(FavoriteEpisodeController());

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: appBar(
        title: "Wishlist",
        centerTitle: true,
        elevation: 1.0,
        hideBackButton: true,
      ),
      body: Container(
        margin: EdgeInsets.only(top: 20),
        padding: EdgeInsets.symmetric(horizontal: getWidth(20)),
        child: DefaultTabController(
          length: 2,
          child: Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.white,
              automaticallyImplyLeading: false,
              elevation: 0.0,
              titleSpacing: 0,
              title: Container(
                decoration: BoxDecoration(
                  border: Border.all(color: defaultColor)
                ),
                child: TabBar(
                  unselectedLabelColor: Colors.black,
                  indicatorSize: TabBarIndicatorSize.tab,
                  indicator: BoxDecoration(
                    gradient: LinearGradient(
                        colors: [defaultColor, defaultColor]),
                  ),
                  tabs: [
                    Tab(child: Text("Series", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15))),
                    Tab(child: Text("Episode", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15))),
                  ],
                ),
              )
            ),
            body: TabBarView(
              children: [
                FavoriteSeriesScreen(favoriteSeries: favoriteSeriesController.favoriteSeries.value),
                FavoriteEpisodeScreen(favoriteEpisode: favoriteEpisodeController.favoriteEpisode.value),
              ],
            ),
          ),
        ),
      ),
    );
  }
}