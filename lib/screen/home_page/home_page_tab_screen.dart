import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:untitled/controller/home_page/home_page_controller.dart';
import 'package:untitled/main.dart';
import 'package:untitled/model/Serie.dart';
import 'package:untitled/screen/home_page/home_page_component.dart';
import 'package:untitled/screen/home_page/search_result_screen.dart';
import 'package:untitled/screen/series_detail/episode_card.dart';
import 'package:untitled/utils/config.dart';
import 'package:untitled/widgets/app_bar.dart';
import 'package:untitled/widgets/input.dart';
import 'package:carousel_slider/carousel_slider.dart';

class HomePageTabScreen extends StatelessWidget {
  HomePageController homePageController = Get.put(HomePageController());

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
            GestureDetector(
              child: SvgPicture.asset(
                "assets/icons/cart.svg",
                width: getWidth(24),
              ),
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
        child: ListView(
          // shrinkWrap: true,
          children: [
            SizedBox(
              height: getHeight(25),
            ),
            Container(
              child: inputSearch(
                context,
                hintText: "Search product name",
                textEditingController: homePageController.searchText,
                onSearch: () {
                  if (homePageController.searchText.text != "") {
                    homePageController.search();
                    Get.to(SearchResultScreen());
                  }
                },
                fillColor: 0xFFFAFAFA,
                borderColor: 0xFFFAFAFA,
              ),
            ),
            SizedBox(
              height: getHeight(28),
            ),
            CarouselSlider(
              items: [1, 2, 3, 4]
                  .map((e) => Builder(
                        builder: (BuildContext context) {
                          return Container(
                            width: getWidth(307),
                            child: Image.asset("assets/naruto.png"),
                          );
                        },
                      ))
                  .toList(),
              options: CarouselOptions(
                height: getHeight(160),
              ),
            ),
            SizedBox(
              height: getHeight(28),
            ),
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
              child: Obx(() {
                return ListView(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  physics: const BouncingScrollPhysics(),
                  children: globalController.categories.value.map((e) {
                    return Container(
                      margin: EdgeInsets.only(right: getWidth(20)),
                      child: Column(
                        children: [
                          SvgPicture.asset(
                            "assets/icons/sample-category.svg",
                            width: getWidth(60),
                          ),
                          Text(
                            e["categoryName"],
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                );
              }),
            ),
            Container(
              alignment: Alignment.centerLeft,
              child: Text(
                "New released",
                style: TextStyle(
                  fontSize: getWidth(15),
                ),
                textAlign: TextAlign.left,
              ),
            ),
            SizedBox(height: getHeight(20)),
            Obx(() {
              return GridView.count(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                primary: false,
                crossAxisSpacing: getWidth(20),
                mainAxisSpacing: getHeight(20),
                crossAxisCount: 2,
                childAspectRatio: 4 / 5.7,
                children: homePageController.seriesList.map((e) {
                  return SeriesItem(
                    seriesInfo: e,
                  );
                }).toList(),
              );
            }),
          ],
        ),
      ),
    );
  }
}
