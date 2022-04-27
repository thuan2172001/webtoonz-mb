import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:untitled/model/User.dart';
import 'package:untitled/model/custom_dio.dart';

class GlobalController extends GetxController {
  var db;
  Rx<User> user = User().obs;
  RxList categories = List.empty(growable: true).obs;

  late PageController pageController;
  RxInt currentPage = 0.obs;

  @override
  void onInit() async {
    super.onInit();
    await getCategories();
    pageController = PageController(initialPage: 0, keepPage: true);
  }

  void onChangeTab(int value) {
    try {
      currentPage.value = value;
      pageController.jumpToPage(value);
    } catch (e) {
      currentPage.value = value;
      pageController = PageController(initialPage: value, keepPage: true);
    }
  }

  Future getCategories() async {
    try {
      CustomDio customDio = CustomDio();
      var response = await customDio.get("/category");
      response = jsonDecode(response.toString());
      var data = response["data"] ?? [];
      categories.value = data;
    } catch (e, s) {
      return null;
    }
  }
}
