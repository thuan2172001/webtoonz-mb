import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart' hide Response, FormData, MultipartFile;
import 'package:untitled/model/User.dart';
import 'package:untitled/model/custom_dio.dart';
import 'package:dio/src/form_data.dart';
import 'package:dio/dio.dart';

class GlobalController extends GetxController {
  var db;
  PageController pageController =
      PageController(initialPage: 0, keepPage: true);
  Rx<User> user = User().obs;
  RxList categories = List.empty(growable: true).obs;

  RxList episodeIdsInCart = List.empty(growable: true).obs;
  RxInt currentPage = 0.obs;

  @override
  void onInit() async {
    super.onInit();
    await getCategories();
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
      episodeIdsInCart.value = response["data"] ?? [];
      return true;
    } catch (e, s) {
      print(e.toString());
      return false;
    }
  }

  bool checkInCart(String episodeId) {
    return episodeIdsInCart.contains(episodeId);
  }

  Future addToCart(String episodeId) async {
    try {
      CustomDio customDio = CustomDio();
      episodeIdsInCart.value.add(episodeId);
      await customDio.put("/user/cart", {"cartItems": episodeIdsInCart});
      return true;
    } catch (e, s) {
      print(e.toString());
      return false;
    }
  }

  Future removeFomCart(String episodeId) async {
    try {
      CustomDio customDio = CustomDio();
      episodeIdsInCart.remove(episodeId);
      await customDio.put("/user/cart", {"cartItems": episodeIdsInCart});
      return true;
    } catch (e, s) {
      print(e.toString());
      return false;
    }
  }

  Future uploadFile(File file) async {
    try {
      CustomDio customDio = CustomDio();
      var filePost = await MultipartFile.fromFile(file.path);
      FormData formData = FormData.fromMap({
        "file": filePost,
      });
      var response = await customDio.post("/uploadv3", formData);
      response = jsonDecode(response.toString());
      return response["data"]["key"];
    } catch (e, s) {
      return null;
    }
  }
}
