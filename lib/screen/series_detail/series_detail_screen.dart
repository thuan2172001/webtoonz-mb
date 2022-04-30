import 'dart:ui';

import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:untitled/model/Serie.dart';
import 'package:untitled/screen/series_detail/episode_card.dart';
import 'package:untitled/widgets/app_bar.dart';

class SeriesDetailScreen extends StatelessWidget {
  final Series seriesInfo;
  final double coverImageBottomPadding = 30;
  final double imageHeight = 300;
  final double sidePadding = 20;
  final double titleFontSize = 25;
  final double authorAvatarWidth = 50;
  final double statusFontSize = 20;
  final double authorTitleFontSize = 20;

  const SeriesDetailScreen({Key? key, required this.seriesInfo})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(
        title: seriesInfo.serieName,
      ),
      body: ListView(
        physics: AlwaysScrollableScrollPhysics(),
        children: [
          Padding(
            padding: EdgeInsets.only(bottom: coverImageBottomPadding),
            child: Stack(
              //alignment: Alignment.center,
              children: <Widget>[
                Container(
                  color: Colors.black,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Image.network(seriesInfo.cover,
                          height: imageHeight, fit: BoxFit.cover),
                    ],
                  ),
                ),
                ClipRRect(
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
                    child: Container(
                      height: 300,
                      color: Colors.grey.withOpacity(0.1),
                      alignment: Alignment.center,
                      child: Stack(
                        children: [
                          Text(
                            seriesInfo.serieName,
                            style: TextStyle(color: Colors.white, fontSize: 25),
                          ),
                          Text(
                            seriesInfo.serieName,
                            style: TextStyle(
                                fontSize: 25,
                                foreground: Paint()
                                  ..style = PaintingStyle.stroke
                                  ..strokeWidth = 0.7
                                  ..color = Colors.black),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: sidePadding, right: sidePadding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      RichText(
                          text: TextSpan(
                              style: TextStyle(color: Colors.black),
                              children: [
                            TextSpan(
                                text: '${seriesInfo.totalEpisodes} items  |  ',
                                style: TextStyle(fontSize: statusFontSize)),
                            WidgetSpan(
                                child: SvgPicture.asset(
                              'assets/icons/heart.svg',
                              width: statusFontSize,
                            )),
                            TextSpan(
                                text: ' ${seriesInfo.likes}',
                                style: TextStyle(fontSize: statusFontSize))
                          ])),
                      Container(
                          width: statusFontSize,
                          child: SvgPicture.asset('assets/icons/share.svg'))
                    ],
                  ),
                ),
                Text(
                  seriesInfo.category,
                  style: TextStyle(color: Colors.grey),
                ),
                Container(
                  child: Container(
                    height: 50,
                    child: Center(
                      child: CustomPaint(
                        painter: DrawDashLine(),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 15),
                  child: Row(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(right: 10),
                        child: Container(
                          width: authorAvatarWidth,
                          child: CircleAvatar(
                            backgroundImage:
                                NetworkImage(seriesInfo.authorAvatar),
                          ),
                        ),
                      ),
                      Text(
                        seriesInfo.authorName,
                        style: TextStyle(fontSize: authorTitleFontSize),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: ExpandableText(
                    seriesInfo.description,
                    expandText: 'show more',
                    collapseText: 'show less',
                    maxLines: 6,
                    linkColor: Colors.blue,
                  ),
                ),
                GridView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: seriesInfo.episodes.length,
                  itemBuilder: (BuildContext context, int index) {
                    return EpisodeCard(episode: seriesInfo.episodes[index]);
                  },
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 5,
                      mainAxisSpacing: 5,
                      childAspectRatio: 2 / 3),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class DrawDashLine extends CustomPainter {
  Paint _paint = Paint();

  DrawDashLine() {
    //_paint = Paint();
    _paint.color = Colors.grey; //dots color
    _paint.strokeWidth = 2; //dots thickness
    _paint.strokeCap = StrokeCap.square; //dots corner edges
  }

  @override
  void paint(Canvas canvas, Size size) {
    for (double i = -300; i < 300; i = i + 15) {
      // 15 is space between dots
      if (i % 3 == 0)
        canvas.drawLine(Offset(i, 0.0), Offset(i + 10, 0.0), _paint);
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
