import 'dart:convert';

import 'package:get/get.dart';

import '../../main.dart';
import '../../model/Serie.dart';
import '../../model/custom_dio.dart';

class SerieDetailController extends GetxController {
  Rx<Series> seriesInfo = Series().obs;
  String serieId = "";
  final int limit = 8;
  RxList<SeriesEpisode> episodes = <SeriesEpisode>[].obs;
  RxList<SeriesEpisode> searchResults = <SeriesEpisode>[].obs;
  RxBool isChangingStatus = false.obs;
  RxBool isDeleting = false.obs;
  RxBool isPublished = false.obs;

  void initialize(
      List<SeriesEpisode> initEpisodes, String _serieId, bool _isPublished) {
    if (globalController.user.value.role == 'user') {
      initEpisodes.removeWhere((element) => element.isPublished == false);
    }
    episodes.value = initEpisodes;
    serieId = _serieId;
    isPublished.value = _isPublished;
  }

  Future fetchSerie(String serieId) async {
    try {
      CustomDio customDio = CustomDio();
      customDio.dio.options.headers["Authorization"] =
          globalController.user.value.certificate.toString();
      var response =
          await customDio.get("/serie/$serieId?page=1&limit=${limit}");
      response = jsonDecode(response.toString());
      if (response["code"] != 200) return Series();
      var serieData = response["data"];
      var serieEpisodes = List.generate(
          serieData["episodes"].length,
          (index) => SeriesEpisode(
                serieData["episodes"][index]["name"],
                serieData["episodes"][index]["thumbnail"],
                serieData["episodes"][index]["price"],
                serieData["episodes"][index]["likeInit"],
                serieData["episodes"][index]["comments"],
                serieData["episodes"][index]["episodeId"],
                serieData["episodes"][index]["chapter"],
                serieData["episodes"][index]["isPublished"],
              ));
      initialize(serieEpisodes, serieData["serieId"], serieData["isPublished"]);
      var _seriesInfo = Series.fullParam(
        serieData["serieName"],
        serieData["description"],
        serieData["thumbnail"],
        serieData["cover"],
        serieData["totalEpisodes"],
        serieData["likes"],
        serieData["categoryId"],
        serieData["category"]["categoryName"],
        serieData["creatorInfo"]["fullName"],
        serieData["creatorInfo"]["avatar"],
        serieData["serieId"],
      );
      seriesInfo.value = _seriesInfo;
    } catch (e) {
      print(e);
      seriesInfo.value = Series();
    }
  }

  Future getSeriesInfor() async {
    try {
      CustomDio customDio = CustomDio();
      customDio.dio.options.headers["Authorization"] =
          globalController.user.value.certificate.toString();
      var response = await customDio.get("/serie/$serieId?page=1&limit=0");
      print(response);
      response = jsonDecode(response.toString());
      if (response["code"] != 200) return;
      var serieData = response["data"];
      seriesInfo.value = Series.fullParam(
        serieData["serieName"],
        serieData["description"],
        serieData["thumbnail"],
        serieData["cover"],
        serieData["totalEpisodes"],
        serieData["likes"],
        serieData["categoryId"],
        serieData["category"]["categoryName"],
        serieData["creatorInfo"]["fullName"],
        serieData["creatorInfo"]["avatar"],
        serieData["serieId"],
      );
    } catch (e) {
      print(e);
    }
  }

  Future getEpisodes(String _serieId, int page) async {
    CustomDio customDio = CustomDio();
    customDio.dio.options.headers["Authorization"] =
        globalController.user.value.certificate.toString();
    var response =
        await customDio.get("/serie/$_serieId?page=$page&limit=$limit");
    response = jsonDecode(response.toString());
    var episodesData = response["data"];
    episodes.value = List.generate(
        episodesData["episodes"].length,
        (index) => SeriesEpisode(
              episodesData["episodes"][index]["name"],
              episodesData["episodes"][index]["thumbnail"],
              episodesData["episodes"][index]["price"],
              episodesData["episodes"][index]["likeInit"],
              episodesData["episodes"][index]["comments"],
              episodesData["episodes"][index]["episodeId"],
              episodesData["episodes"][index]["chapter"],
              episodesData["episodes"][index]["isPublished"],
            ));
    episodes.refresh();
  }

  Future searchEpisodes(String pattern) async {
    CustomDio customDio = CustomDio();
    customDio.dio.options.headers["Authorization"] =
        globalController.user.value.certificate.toString();
    var response =
        await customDio.get("/serie/$serieId?limit=20&pattern=$pattern");
    response = jsonDecode(response.toString());
    var episodesData = response["data"];
    searchResults.value = List.generate(
        episodesData["episodes"].length,
        (index) => SeriesEpisode(
              episodesData["episodes"][index]["name"],
              episodesData["episodes"][index]["thumbnail"],
              episodesData["episodes"][index]["price"],
              episodesData["episodes"][index]["likeInit"],
              episodesData["episodes"][index]["comments"],
              episodesData["episodes"][index]["episodeId"],
              episodesData["episodes"][index]["chapter"],
              episodesData["episodes"][index]["isPublished"],
            ));
    if (globalController.user.value.role == 'user') {
      searchResults.value.removeWhere((element) => element.isPublished == false);
    }
    searchResults.refresh();
  }

  Future changeStatus() async {
    try {
      CustomDio customDio = CustomDio();
      var data = {
        "serieId": serieId,
        "type": isPublished.value ? "UNPUBLISH" : "PUBLISH",
      };
      var response = await customDio.post(
        "/serie/status",
        data,
      );
      var json = jsonDecode(response.toString());
      isPublished.value = !isPublished.value;
      return json;
    } catch (e, s) {
      return null;
    }
  }

  Future deleteSeries() async {
    try {
      CustomDio customDio = CustomDio();
      var response = await customDio.delete("/serie/$serieId");
      var json = jsonDecode(response.toString());
      return json;
    } catch (e, s) {
      return null;
    }
  }
}
