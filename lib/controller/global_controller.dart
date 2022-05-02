import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:untitled/model/User.dart';
import 'package:untitled/model/custom_dio.dart';

class GlobalController extends GetxController {
  var db;
  Rx<User> user = User().obs;
  RxList categories = List.empty(growable: true).obs;

  RxList episodeIdsInCart = List.empty(growable: true).obs;
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

  Future getEpisodeIdsInCart() async {
    try {
      CustomDio customDio = CustomDio();
      var response = await customDio.get("/user/cart");
      response = jsonDecode(response.toString());
      episodeIdsInCart.value = response["data"]?? [];
      return true;
    } catch (e, s) {
      print(e.toString());
      return false;
    }
  }

  bool checkInCart(String episodeId){
    return episodeIdsInCart.value.contains(episodeId);
  }

  Future addToCart(String episodeId) async {
    try {
      CustomDio customDio = CustomDio();
      episodeIdsInCart.value.add(episodeId);
      var data = {"cartItems": episodeIdsInCart.value};
      var response = await customDio.put("/user/cart", data);
      return true;
    } catch (e, s) {
      print(e.toString());
      return false;
    }
  }

  Future removeFomCart(String episodeId) async {
    try {
      CustomDio customDio = CustomDio();
      episodeIdsInCart.value.remove(episodeId);
      var data = {"cartItems": episodeIdsInCart.value};
      var response = await customDio.put("/user/cart", data);
      return true;
    } catch (e, s) {
      print(e.toString());
      return false;
    }
  }
}
