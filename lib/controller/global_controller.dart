import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:untitled/model/User.dart';
import 'package:untitled/model/custom_dio.dart';

class StateModal {
  String? id;
  String? name;
}

class Category {
  String id = "";
  String name = "";
  int numberOrder = 0;
  String image = "";
}

class GlobalController extends GetxController {
  var db;
  Rx<User> user = User().obs;

  late PageController pageController;
  RxInt currentPage = 0.obs;

  @override
  void onInit() {
    super.onInit();
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
}
