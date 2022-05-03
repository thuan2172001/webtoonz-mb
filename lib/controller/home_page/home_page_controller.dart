import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:untitled/controller/favorite/favorite_series_controller.dart';
import 'package:untitled/model/Serie.dart';
import 'package:untitled/model/custom_dio.dart';

import '../global_controller.dart';

class HomePageController extends GetxController {
  TextEditingController searchText = TextEditingController();

  RxList<Series> seriesList = <Series>[].obs;
  RxList<Series> searchList = <Series>[].obs;

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

  search() async {
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
}
