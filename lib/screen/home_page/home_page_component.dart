import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:untitled/controller/creator_detail/creator_detail_controller.dart';
import 'package:untitled/model/Serie.dart';
import 'package:untitled/screen/creator_detail/creator_detail_screen.dart';
import 'package:untitled/screen/series_detail/series_detail_screen.dart';
import 'package:untitled/utils/common-function.dart';
import 'package:untitled/utils/config.dart';
import 'package:untitled/widgets/image.dart';

class SeriesItem extends StatelessWidget {
  final Series seriesInfo;

  const SeriesItem({Key? key, required this.seriesInfo}) : super(key: key);

  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.to(() => SeriesDetailScreen(serieId: seriesInfo.serieId));
      },
      child: Container(
        width: getWidth(160),
        margin: EdgeInsets.only(
          left: getWidth(10),
          right: getWidth(10),
        ),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            // border: Border.all(
            //   color: Color(0xFF000000),
            //   width: getWidth(1),
            // ),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.3),
                spreadRadius: 0,
                blurRadius: 10,
                offset: Offset(0, 10),
              )
            ]),
        padding: EdgeInsets.only(
          top: getWidth(14),
          left: getWidth(10),
          right: getWidth(10),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            getImage(
              seriesInfo.thumbnail,
              height: getWidth(121),
              width: getWidth(121),
            ),
            SizedBox(
              height: getHeight(8),
            ),
            Text(
              seriesInfo.serieName,
              style: TextStyle(fontSize: getWidth(13)),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            SizedBox(
              height: getHeight(3),
            ),
            Text(
              'VND ',
              style: TextStyle(fontSize: 11, color: Colors.red),
            ),
            SizedBox(
              height: getHeight(8),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                RichText(
                    text: TextSpan(
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: getWidth(9.5),
                        ),
                        children: [
                      WidgetSpan(
                          child: SvgPicture.asset(
                        'assets/icons/gold_star.svg',
                        width: getWidth(9),
                      )),
                      TextSpan(
                          text:
                              ' ${numberShorten(seriesInfo.likes ?? seriesInfo.totalLikes ?? 0)}')
                    ])),
                Text(
                  ' ${numberShorten(seriesInfo.comments ?? 0)} Comments',
                  style: TextStyle(
                    fontSize: getWidth(9.5),
                  ),
                ),
                GestureDetector(
                  child: Icon(
                    Icons.more_vert,
                    size: getHeight(17),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class CreatorItem extends StatelessWidget {
  final CreatorInfo creatorInfo;

  const CreatorItem({Key? key, required this.creatorInfo}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.to(() => CreatorDetailScreen(creatorId: creatorInfo.id));
      },
      child: Container(
        margin: EdgeInsets.only(
          top: getHeight(22),
          left: getWidth(10),
          right: getWidth(10),
        ),
        width: getWidth(139),
        padding: EdgeInsets.only(
          top: getWidth(14),
          left: getWidth(10),
          right: getWidth(10),
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Color(0xFF6DC0FC),
              spreadRadius: 1,
              blurRadius: 0,
              offset: Offset(0, -5),
            ),
            BoxShadow(
              color: Color(0xFF6DC0FC),
              spreadRadius: 1,
              blurRadius: 0,
              offset: Offset(0, 0),
            ),
            BoxShadow(
              color: Color(0xFF6DC0FC),
              spreadRadius: 1,
              blurRadius: 0,
              offset: Offset(0, -5),
            ),
            // BoxShadow(
            //   color: Color(0xFF6DC0FC),
            //   spreadRadius: 0,
            //   blurRadius: 0,
            //   offset: Offset(-1, 0),
            // ),
          ],
        ),
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(100),
              child: SizedBox(
                  width: getWidth(100),
                  height: getWidth(100),
                  child: getImage(creatorInfo.avatar)),
            ),
            SizedBox(height: getHeight(10)),
            Text(
              "${creatorInfo.fullName}",
              style: TextStyle(
                fontSize: getWidth(15),
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            SizedBox(height: getHeight(10)),
            Text(
              "${creatorInfo.seriesQuantity} series",
              style: TextStyle(
                color: Color(0xFF606060),
                fontSize: getWidth(15),
              ),
            )
          ],
        ),
      ),
    );
  }
}
