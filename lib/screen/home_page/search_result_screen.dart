import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:untitled/controller/home_page/home_page_controller.dart';
import 'package:untitled/screen/home_page/home_page_component.dart';
import 'package:untitled/utils/config.dart';
import 'package:untitled/widgets/app_bar.dart';
import 'package:untitled/widgets/input.dart';

class SearchResultScreen extends StatelessWidget {
  const SearchResultScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var homepageController = Get.put(HomePageController());

    return Scaffold(
      appBar: appBar(
        centerTitle: true,
        title: "Search",
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.only(
          left: getWidth(20),
          right: getWidth(20),
        ),
        child: ListView(
          children: [
            SizedBox(
              height: getHeight(25),
            ),
            Container(
              child: inputSearch(
                context,
                hintText: "Search product name",
                textEditingController: homepageController.searchText,
                onSearch: () {
                  if (homepageController.searchText.text != "")
                    homepageController.search();
                },
                fillColor: 0xFFFAFAFA,
                borderColor: 0xFFFAFAFA,
              ),
            ),
            SizedBox(
              height: getHeight(15),
            ),
            Text(
                "${homepageController.isSearchCreator
                    ? homepageController.searchCreatorList.length : homepageController.searchList.length} items matching \"${homepageController.searchText.text}\" found"),
            SizedBox(
              height: getHeight(15),
            ),
            Obx(() {
              return GridView.count(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                primary: false,
                crossAxisSpacing: 20,
                mainAxisSpacing: 20,
                crossAxisCount: 2,
                childAspectRatio: 4 / 5.7,
                children: homepageController.isSearchCreator
                    ? homepageController.searchCreatorList.map((e) {
                        return CreatorItem(
                          creatorInfo: e,
                        );
                      }).toList()
                    : homepageController.searchList.map((e) {
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
