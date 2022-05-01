import 'dart:convert';

import 'package:get/get.dart';

import '../../main.dart';
import '../../model/Serie.dart';
import '../../model/custom_dio.dart';

class SerieDetailController extends GetxController {
  final int limit = 8;
  RxList<SeriesEpisode> episodes = <SeriesEpisode>[].obs;

  void initEpisodes(List<SeriesEpisode> initEpisodes) {
    episodes.value = initEpisodes;
    //episodes.refresh();
  }

  Future getEpisodes(String serieId, int page) async {
    CustomDio customDio = CustomDio();
    customDio.dio.options.headers["Authorization"] =
        globalController.user.value.certificate.toString();
    var response = await customDio
        .get("/serie/$serieId?guest=true&page=$page&limit=$limit");
    response = jsonDecode(response.toString());
    var episodesData = response["data"];
    episodes.value = List.generate(
        episodesData["episodes"].length,
        (index) => SeriesEpisode(
            episodesData["episodes"][index]["name"],
            episodesData["episodes"][index]["thumbnail"],
            episodesData["episodes"][index]["price"],
            episodesData["episodes"][index]["likeInit"],
            episodesData["episodes"][index]["comments"]));
    episodes.refresh();
  }
}
