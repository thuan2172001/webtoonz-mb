import 'package:flutter/material.dart';
import 'package:untitled/controller/favorite/favorite_series_controller.dart';
import 'package:untitled/screen/home_page/home_page_component.dart';

class FavoriteSeriesScreen extends StatelessWidget{
  final FavoriteSeries favoriteSeries;

  const FavoriteSeriesScreen({Key? key, required this.favoriteSeries})
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
              itemCount: favoriteSeries.listSeries.length,
              itemBuilder: (BuildContext context, int index) {
                return SeriesItem(seriesInfo: favoriteSeries.listSeries[index]);
              },
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 20,
                  mainAxisSpacing: 20,
                  childAspectRatio: 4 / 5.7),
            ),
          ],
        )
    );
  }
}