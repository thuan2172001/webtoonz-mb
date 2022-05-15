import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:untitled/controller/creator_detail/creator_detail_controller.dart';
import 'package:untitled/controller/favorite/favorite_series_controller.dart';
import 'package:untitled/model/Serie.dart';
import 'package:untitled/model/custom_dio.dart';

import '../global_controller.dart';

class HomePageController extends GetxController {
  TextEditingController searchText = TextEditingController();

  RxList<Series> seriesList = <Series>[].obs;
  RxList<Series> searchList = <Series>[].obs;
  RxList<Series> newReleased = <Series>[].obs;
  RxList<Series> popular = <Series>[].obs;

  RxList<CreatorInfo> creatorList = <CreatorInfo>[].obs;
  RxList<CreatorInfo> searchCreatorList = <CreatorInfo>[].obs;

  bool isSearchCreator = false;

  Future getSeries() async {
    try {
      CustomDio customDio = CustomDio();
      print(Get.put(GlobalController()).user.value.certificate.toString());
      customDio.dio.options.headers["Authorization"] =
          Get.put(GlobalController()).user.value.certificate.toString();
      var response = await customDio.get("/serie");
      var json = jsonDecode(response.toString());
      print(json);

      seriesList.value = FavoriteSeries.fromJson(json).listSeries;
      newReleased.value = seriesList.sublist(0, 10);
      popular.value = seriesList.sublist(11, 20);
      return true;
    } catch (e, s) {
      return false;
    }
  }

  Future getCreatorSeries() async {
    try {
      CustomDio customDio = CustomDio();
      print(Get.put(GlobalController()).user.value.certificate.toString());
      customDio.dio.options.headers["Authorization"] =
          Get.put(GlobalController()).user.value.certificate.toString();
      var response = await customDio.get("/serie", {"isCreator": true});
      var json = jsonDecode(response.toString());
      print(json);

      seriesList.value = FavoriteSeries.fromJson(json).listSeries;
      return true;
    } catch (e, s) {
      return false;
    }
  }

  search() {
    searchList.clear();
    print(seriesList[0].serieName);

    for (int i = 0; i < seriesList.length; i++) {
      if (seriesList[i]
          .serieName
          .toLowerCase()
          .contains(searchText.text.toLowerCase()))
        searchList.add(seriesList[i]);
    }
  }

  searchCreator() {
    searchCreatorList.clear();

    for (int i = 0; i < creatorList.length; i++) {
      if (creatorList[i]
          .fullName
          .toLowerCase()
          .contains(searchText.text.toLowerCase()))
        searchCreatorList.add(creatorList[i]);
    }
  }

  Future getAllCreators() async {
    try {
      CustomDio customDio = CustomDio();
      customDio.dio.options.headers["Authorization"] =
          Get.put(GlobalController()).user.value.certificate.toString();
      var response = await customDio.get("/creator");
      var json = jsonDecode(response.toString());
      var list = json["data"]["creators"];
      creatorList.clear();

      print(list.length);
      for (int i = 0; i < list.length; i++) {
        print(list[i]);
        creatorList.add(CreatorInfo.fromJsonInList(list[i]));
      }
      return true;
    } catch (e, s) {
      return false;
    }
  }
}
