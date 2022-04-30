import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sizer/sizer.dart';
import 'package:untitled/model/Serie.dart';

class EpisodeCard extends StatelessWidget {
  final SeriesEpisode episode;
  final double episodeTitleFontSize = 15;
  final double priceFontSize = 12;
  final double statusFontSize = 7;

  const EpisodeCard({Key? key, required this.episode}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(child: LayoutBuilder(builder: (ctx, constraints) {
              return Container(
                width: constraints.maxWidth,
                height: constraints.maxHeight * 3 / 2,
                child: Image.network(
                  episode.thumbnail,
                  fit: BoxFit.cover,
                ),
              );
            })),
            Padding(
              padding: const EdgeInsets.only(bottom: 3),
              child: Text(
                episode.name,
                style: TextStyle(fontSize: episodeTitleFontSize.sp),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 10),
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
                SvgPicture.asset('assets/icons/dot_menu.svg',
                    width: statusFontSize.sp)
              ],
            )
          ],
        ),
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      elevation: 5,
      margin: EdgeInsets.all(10),
    );
  }
}
