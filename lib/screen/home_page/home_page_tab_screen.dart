import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:untitled/controller/global_controller.dart';
import 'package:untitled/utils/config.dart';

class HomePageTabScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      margin: EdgeInsets.symmetric(horizontal: getWidth(16)),
      child: ListView(
        children: [
          SizedBox(
            height: getHeight(60),
          ),
          Text(
            "Homepage",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: getWidth(20),
            ),
          ),
          SizedBox(
            height: getHeight(40),
          ),
        ],
      ),
    );
  }

  GestureDetector actionTab(
      {required Color color,
      required String icon,
      required String tag,
      Function? function}) {
    return GestureDetector(
      onTap: () {
        if (function != null) {
          function();
        }
      },
      child: Container(
        width: getWidth(165),
        height: getWidth(130),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(
            getWidth(6),
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(getWidth(44)),
              child: Container(
                width: getWidth(44),
                height: getWidth(44),
                color: Colors.white,
                padding: EdgeInsets.all(getWidth(9)),
                child: SvgPicture.asset(
                  icon,
                ),
              ),
            ),
            Text(
              tag.tr,
              style: TextStyle(fontSize: getWidth(15)),
            )
          ],
        ),
      ),
    );
  }
}
