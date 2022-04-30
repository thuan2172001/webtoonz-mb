import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sizer/sizer.dart';
import 'package:untitled/model/Serie.dart';

class EpisodeCard extends StatelessWidget {
  final SeriesEpisode episode;

  const EpisodeCard({Key? key, required this.episode}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double episodeTitleFontSize =
        MediaQuery.of(context).orientation == Orientation.portrait ? 10 : 15;
    double priceFontSize =
        MediaQuery.of(context).orientation == Orientation.portrait ? 9 : 13;
    double statusFontSize =
        MediaQuery.of(context).orientation == Orientation.portrait ? 7 : 8;
    double imageBottomPadding =
        MediaQuery.of(context).orientation == Orientation.portrait ? 2 : 4.5;
    double titleBottomPadding =
        MediaQuery.of(context).orientation == Orientation.portrait
            ? 0.0005
            : 0.0005;
    double priceBottomPadding =
        MediaQuery.of(context).orientation == Orientation.portrait ? 1.5 : 3.5;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(bottom: imageBottomPadding.h),
              child: AspectRatio(
                aspectRatio: 1,
                child: Image.network(
                  episode.thumbnail,
                  fit: BoxFit.cover,
                  width: double.infinity,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: titleBottomPadding.h),
              child: Text(
                episode.name,
                style: TextStyle(fontSize: episodeTitleFontSize.sp),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: priceBottomPadding.h),
              child: Text(
                'VND ${episode.price}',
                style: TextStyle(fontSize: priceFontSize.sp, color: Colors.red),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                RichText(
                    text: TextSpan(
                        style: TextStyle(
                            color: Colors.black, fontSize: statusFontSize.sp),
                        children: [
                      WidgetSpan(
                          child: SvgPicture.asset(
                        'assets/icons/gold_star.svg',
                        width: statusFontSize.sp,
                      )),
                      TextSpan(text: ' ${episode.likeInit}')
                    ])),
                Text(
                  ' ${episode.comments} Comments',
                  style: TextStyle(fontSize: statusFontSize.sp),
                ),
              ],
            )
          ],
        ),
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(6.0),
      ),
      elevation: 5,
      margin: EdgeInsets.all(10),
    );
  }
}
