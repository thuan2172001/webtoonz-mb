import 'dart:convert';

import 'package:get/get.dart';
import '../../model/custom_dio.dart';
import '../../model/espisode.dart';
import 'package:untitled/controller/global_controller.dart';

class EpisodeDetailController extends GetxController with StateMixin {
  final String episodeId;
  Rx<Episode> episode = Episode().obs;
  RxList comments = List.empty(growable: true).obs;

  EpisodeDetailController({required this.episodeId});

  RxBool seeAll = false.obs;
  RxBool inCart = false.obs;

  @override
  void onInit() async {
    super.onInit();
  }

  Future getApi() async {
    await getEpisodeDetail();
    await getComments();
    inCart = Get.put(GlobalController()).checkInCart(episodeId).obs;
  }

  Future getEpisodeDetail() async {
    try {
      CustomDio customDio = CustomDio();
      var response = await customDio.get("/episode/$episodeId");
      response = jsonDecode(response.toString());
      episode.value = Episode.fromJson(response);
      return true;
    } catch (e, s) {
      print(e.toString());
      return false;
    }
  }

  Future getComments() async {
    try {
      CustomDio customDio = CustomDio();
      var response = await customDio.get("/episode/$episodeId/comments");
      response = jsonDecode(response.toString());
      var data = response["data"] ?? [];
      comments.value = data;
      return true;
    } catch (e, s) {
      print(e.toString());
      return false;
    }
  }

  Future addComment(String comment) async {
    try {
      CustomDio customDio = CustomDio();
      var data = {
        "episodeId": episodeId,
        "description": comment,
      };

      var response = await customDio.post(
        "/comment",
        data,
      );
      var json = jsonDecode(response.toString());
      var result = json["data"]["data"];
      return result ?? json;
    } catch (e, s) {
      return null;
    }
  }

  Future addToCard() async {
    try {
      CustomDio customDio = CustomDio();
      var data = {};

      var response = await customDio.post(
        "/user",
        data,
      );
      var json = jsonDecode(response.toString());
      var result = json["data"];
      return result ?? json;
    } catch (e, s) {
      return null;
    }
  }

  Future addToFavorite() async {
    try {
      CustomDio customDio = CustomDio();
      var data = {};

      var response = await customDio.post(
        "/user",
        data,
      );
      var json = jsonDecode(response.toString());
      var result = json["data"];
      return result ?? json;
    } catch (e, s) {
      return null;
    }
  }

  Future like() async {
    try {
      CustomDio customDio = CustomDio();
      var data = {
        "episodeId": episodeId,
      };

      var response = await customDio.post(
        "/like/like",
        data,
      );
      var json = jsonDecode(response.toString());
      var result = json["data"];
      return result ?? json;
    } catch (e, s) {
      return null;
    }
  }

  Future unLike() async {
    try {
      CustomDio customDio = CustomDio();
      var data = {
        "episodeId": episodeId,
      };

      var response = await customDio.post(
        "/like/unlike",
        data,
      );
      var json = jsonDecode(response.toString());
      var result = json["data"];
      return result ?? json;
    } catch (e, s) {
      return null;
    }
  }
}
