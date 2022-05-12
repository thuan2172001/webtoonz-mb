import 'dart:convert';

import 'package:get/get.dart';
import 'package:untitled/controller/episode_detail/episode_detail_controller.dart';
import 'package:untitled/model/custom_dio.dart';
import 'package:untitled/model/espisode.dart';

import '../global_controller.dart';

class CartController extends GetxController {
  RxList episodeIds = [].obs;
  RxList<Episode> episodeList = <Episode>[].obs;

  RxString cardId = "".obs;
  RxString cardNumber = "".obs;

  Future getCartList() async {
    try {
      episodeList.clear();
      CustomDio customDio = CustomDio();
      customDio.dio.options.headers["Authorization"] =
          Get.put(GlobalController()).user.value.certificate.toString();
      var response = await customDio.get("/user/cart");
      var json = jsonDecode(response.toString());
      print(json["data"]);
      episodeIds.value = json["data"];

      for (int i = 0; i < json["data"].length; i++) {
        var ep = await getEpisodeDetail(json["data"][i]);
        if (ep != null) {
          episodeList.add(ep);
        }
      }
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<Episode?> getEpisodeDetail(String episodeId) async {
    try {
      CustomDio customDio = CustomDio();
      var response = await customDio.get("/episode/$episodeId");
      response = jsonDecode(response.toString());
      return Episode.fromJson(response);
    } catch (e, s) {
      print(e.toString());
      return null;
    }
  }

  Future updateCart() async {
    try {
      episodeList.clear();
      CustomDio customDio = CustomDio();
      customDio.dio.options.headers["Authorization"] =
          Get.put(GlobalController()).user.value.certificate.toString();
      var response = await customDio.put(
        "/user/cart",
        {
          "cartItems": episodeIds,
        },
      );
      var json = jsonDecode(response.toString());
      print(json);
      if (json["success"]) {
        await getCartList();
      }
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future checkout() async {
    try {
      CustomDio customDio = CustomDio();
      customDio.dio.options.headers["Authorization"] =
          Get.put(GlobalController()).user.value.certificate.toString();
      var response = await customDio.post(
        "/payment/checkout",
        {
          "cartList": episodeIds.value,
          "payment": cardId.value,
          "currency": "USD",
        },
      );
      var json = jsonDecode(response.toString());
      print(json);

      return json["success"];
    } catch (e) {
      print(e);
      return false;
    }
  }
}
