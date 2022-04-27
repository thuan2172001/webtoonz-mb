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
            Expanded(
              child: GridView.count(
                primary: false,
                padding: const EdgeInsets.all(10),
                crossAxisSpacing: 20,
                mainAxisSpacing: 20,
                crossAxisCount: 2,
                children: globalController.categories.value.map((e) {
                  return Container(
                    decoration: BoxDecoration(
                        color: Colors.teal[100],
                        borderRadius: BorderRadius.circular(6),
                        border: Border.all(
                          color: Color(0xFF000000),
                          width: getWidth(1),
                        )),
                    padding: const EdgeInsets.all(8),
                    child: const Text("He'd have you all unravel at the"),
                  );
                }).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
