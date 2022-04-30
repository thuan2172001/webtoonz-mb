import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sizer/sizer.dart';
import 'package:untitled/model/Serie.dart';
import 'package:untitled/screen/series_detail/episode_card.dart';
import 'package:untitled/widgets/app_bar.dart';

class SeriesDetailScreen extends StatelessWidget {
  final Series seriesInfo;

  const SeriesDetailScreen({Key? key, required this.seriesInfo})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    double coverImageBottomPadding = 30;
    double imageHeight =
        MediaQuery.of(context).orientation == Orientation.portrait ? 30 : 40;
    double sidePadding = 5;
    double authorAvatarWidth = 10;
    double descriptionFontSize = 10;
    double statusFontSize = 10;
    double categoryFontSize = 7;
    double authorTitleFontSize = 15;

    return Scaffold(
      appBar: appBar(
          title: seriesInfo.serieName,
          centerTitle: true,
          actions: <Widget>[
            new IconButton(
              icon: new Icon(Icons.search, color: Colors.black),
              onPressed: () {},
            )
          ]),
      body: ListView(
        physics: AlwaysScrollableScrollPhysics(),
        children: [
          Padding(
            padding: EdgeInsets.only(bottom: coverImageBottomPadding),
            child: Container(
              color: Colors.black,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Image.network(seriesInfo.cover,
                      height: imageHeight.h, fit: BoxFit.cover),
                ],
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: sidePadding.w, right: sidePadding.w),
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
                                style: TextStyle(fontSize: statusFontSize.sp)),
                            WidgetSpan(
                                child: SvgPicture.asset(
                              'assets/icons/heart.svg',
                              width: statusFontSize.sp,
                            )),
                            TextSpan(
                                text: ' ${seriesInfo.likes}',
                                style: TextStyle(fontSize: statusFontSize.sp))
                          ])),
                      Container(
                          width: statusFontSize.sp,
                          child: SvgPicture.asset(
                            'assets/icons/share.svg',
                            width: statusFontSize.sp,
                          ))
                    ],
                  ),
                ),
                Text(
                  seriesInfo.category,
                  style: TextStyle(
                      color: Colors.grey, fontSize: categoryFontSize.sp),
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
                  padding: EdgeInsets.only(bottom: 3.h),
                  child: Row(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(right: 2.w),
                        child: Container(
                          width: authorAvatarWidth.w,
                          child: CircleAvatar(
                            backgroundImage:
                                NetworkImage(seriesInfo.authorAvatar),
                          ),
                        ),
                      ),
                      Text(
                        seriesInfo.authorName,
                        style: TextStyle(fontSize: authorTitleFontSize.sp),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: ExpandableText(
                    seriesInfo.description,
                    style: TextStyle(fontSize: descriptionFontSize.sp),
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
                      crossAxisSpacing: 0,
                      mainAxisSpacing: 0,
                      childAspectRatio: 4 / 5.7),
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
