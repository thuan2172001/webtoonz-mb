import 'dart:convert';

import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:number_paginator/number_paginator.dart';
import 'package:sizer/sizer.dart';
import 'package:untitled/controller/series_detail/series_detail_controller.dart';
import 'package:untitled/model/Serie.dart';
import 'package:untitled/screen/series_detail/episode_card.dart';
import 'package:untitled/widgets/app_bar.dart';
import 'package:untitled/widgets/image.dart';

import '../../main.dart';
import '../../model/custom_dio.dart';

class SeriesDetailScreen extends StatelessWidget {
  final String serieId;
  final SerieDetailController controller = Get.put(SerieDetailController());

  SeriesDetailScreen({Key? key, required this.serieId}) : super(key: key);

  Future<Series> fetchSerie(String serieId) async {
    try {
      CustomDio customDio = CustomDio();
      customDio.dio.options.headers["Authorization"] =
          globalController.user.value.certificate.toString();
      var response = await customDio
          .get("/serie/$serieId?guest=true&page=1&limit=${controller.limit}");
      response = jsonDecode(response.toString());
      if (response["code"] != 200) return Series();
      var serieData = response["data"];
      var serieEpisodes = List.generate(
          serieData["episodes"].length,
          (index) => SeriesEpisode(
              serieData["episodes"][index]["name"],
              serieData["episodes"][index]["thumbnail"],
              serieData["episodes"][index]["price"],
              serieData["episodes"][index]["likeInit"],
              serieData["episodes"][index]["comments"]));
      controller.initEpisodes(serieEpisodes);
      var seriesInfo = Series.fullParam(
        serieData["serieName"],
        serieData["description"],
        serieData["thumbnail"],
        serieData["cover"],
        serieData["totalEpisodes"],
        serieData["likes"],
        serieData["category"]["categoryName"],
        serieData["creatorInfo"]["fullName"],
        serieData["creatorInfo"]["avatar"],
        serieData["serieId"],
      );
      return seriesInfo;
    } catch (e) {
      print(e);
      return Series();
    }
  }

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

    return FutureBuilder<Series>(
        future: fetchSerie(serieId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (!snapshot.hasData)
              return Text("No data");
            else {
              var seriesInfo = snapshot.data!;
              var ratio = seriesInfo.totalEpisodes! / controller.limit;
              var numberOfPages =
                  ratio > ratio.floor() ? ratio.floor() + 1 : ratio.floor();
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
                            getImage(seriesInfo.cover,
                                height: imageHeight.h, fit: BoxFit.cover),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          left: sidePadding.w, right: sidePadding.w),
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
                                          text:
                                              '${seriesInfo.totalEpisodes} items  |  ',
                                          style: TextStyle(
                                              fontSize: statusFontSize.sp)),
                                      WidgetSpan(
                                          child: SvgPicture.asset(
                                        'assets/icons/heart.svg',
                                        width: statusFontSize.sp,
                                      )),
                                      TextSpan(
                                          text: ' ${seriesInfo.totalLikes}',
                                          style: TextStyle(
                                              fontSize: statusFontSize.sp))
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
                            seriesInfo.categoryId,
                            style: TextStyle(
                                color: Colors.grey,
                                fontSize: categoryFontSize.sp),
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
                                      child: getImage(
                                          seriesInfo.authorAvatar),
                                    ),
                                  ),
                                ),
                                Text(
                                  seriesInfo.authorName!,
                                  style: TextStyle(
                                      fontSize: authorTitleFontSize.sp),
                                )
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 10),
                            child: ExpandableText(
                              seriesInfo.description,
                              style:
                                  TextStyle(fontSize: descriptionFontSize.sp),
                              expandText: 'show more',
                              collapseText: 'show less',
                              maxLines: 6,
                              linkColor: Colors.blue,
                            ),
                          ),
                          Obx(() => GridView.builder(
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                itemCount: controller.episodes.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return EpisodeCard(
                                      episode: controller.episodes[index]);
                                },
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 2,
                                        crossAxisSpacing: 0,
                                        mainAxisSpacing: 0,
                                        childAspectRatio: 4 / 5.7),
                              )),
                          NumberPaginator(
                            numberPages: numberOfPages,
                            initialPage: 0,
                            onPageChange: (index) {
                              controller.getEpisodes(serieId, index + 1);
                            },
                            buttonShape: BeveledRectangleBorder(
                              borderRadius: BorderRadius.circular(6),
                            ),
                            buttonSelectedForegroundColor: Colors.white,
                            buttonSelectedBackgroundColor: Colors.blue,
                            buttonUnselectedForegroundColor: Colors.black,
                            buttonUnselectedBackgroundColor: Colors.white,
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              );
            }
          } else if (snapshot.hasError)
            return Column(
              children: [
                Text(
                  snapshot.error.toString(),
                ),
              ],
            );
          return CircularProgressIndicator();
        });
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
