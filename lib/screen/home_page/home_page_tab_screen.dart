import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:untitled/main.dart';
import 'package:untitled/utils/config.dart';
import 'package:untitled/widgets/app_bar.dart';

class HomePageTabScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(
          title: "Webtoonz",
          hideBackButton: true,
          centerTitle: true,
          elevation: 1.0,
          actions: [
            SvgPicture.asset(
              "assets/icons/bell.svg",
              width: getWidth(24),
            ),
            SizedBox(
              width: getWidth(20),
            ),
            SvgPicture.asset(
              "assets/icons/cart.svg",
              width: getWidth(24),
            ),
            SizedBox(
              width: getWidth(20),
            ),
          ]),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: Colors.white,
        padding: EdgeInsets.symmetric(horizontal: getWidth(20)),
        child: Column(
          children: [
            Container(
              alignment: Alignment.centerLeft,
              child: Text(
                "Categories",
                style: TextStyle(
                  fontSize: getWidth(15),
                ),
                textAlign: TextAlign.left,
              ),
            ),
            SizedBox(height: getHeight(20)),
            Container(
              height: getHeight(140),
              child: Expanded(
                child: ListView(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  physics: const BouncingScrollPhysics(),
                  children: globalController.categories.value.map((e) {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: EdgeInsets.only(left: getWidth(20)),
                          child: SvgPicture.asset(
                            "assets/icons/sample-category.svg",
                            width: getWidth(60),
                          ),
                        ),
                        Container(
                          width: getWidth(60),
                          margin: EdgeInsets.only(left: getWidth(20)),
                          child: Text(
                            e["categoryName"],
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    );
                  }).toList(),
                ),
              ),
            ),
            Container(
              alignment: Alignment.centerLeft,
              child: Text(
                "New release",
                style: TextStyle(
                  fontSize: getWidth(15),
                ),
                textAlign: TextAlign.left,
              ),
            ),
            SizedBox(height: getHeight(20)),
          ],
        ),
      ),
    );
  }
}
