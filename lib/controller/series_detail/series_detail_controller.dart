import 'dart:convert';

import 'package:get/get.dart';

import '../../main.dart';
import '../../model/Serie.dart';
import '../../model/custom_dio.dart';

class SerieDetailController extends GetxController {
  String serieId = "";
  final int limit = 8;
  RxList<SeriesEpisode> episodes = <SeriesEpisode>[].obs;
  RxList<SeriesEpisode> searchResults = <SeriesEpisode>[].obs;
  RxBool isChangingStatus=false.obs;
  RxBool isDeleting=false.obs;
  RxBool isPublished=false.obs;
  void initialize(List<SeriesEpisode> initEpisodes, String _serieId,bool _isPublished) {
    episodes.value = initEpisodes;
    serieId = _serieId;
    isPublished.value = _isPublished;
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
            episodesData["episodes"][index]["chapter"]));
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
            episodesData["episodes"][index]["chapter"]));
    searchResults.refresh();
  }
  Future changeStatus() async {
    try {
      CustomDio customDio = CustomDio();
      var data = {
          "serieId": serieId,
          "type": isPublished.value?"UNPUBLISH":"PUBLISH",
      };
      var response = await customDio.post(
        "/serie/status",
        data,
      );
      var json = jsonDecode(response.toString());
      isPublished.value=!isPublished.value;
      return json;
    } catch (e, s) {
      return null;
    }
  }

  Future deleteSeries() async {
    try {
      CustomDio customDio = CustomDio();
      var response = await customDio.delete(
        "/serie/$serieId"
      );
      var json = jsonDecode(response.toString());
      return json;
    } catch (e, s) {
      return null;
    }
  }
}
