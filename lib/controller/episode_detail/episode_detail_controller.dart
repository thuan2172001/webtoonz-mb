import 'dart:convert';

import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

import '../../model/custom_dio.dart';
import '../../model/espisode.dart';

class EpisodeDetailController extends GetxController with StateMixin{
  final String episodeId;
  Rx<Episode> episode = Episode().obs;
  RxList comments = List.empty(growable: true).obs;
  EpisodeDetailController({required this.episodeId});
  RxBool seeAll=false.obs;
  @override
  void onInit() async {
    super.onInit();
    change(null, status: RxStatus.loading());
    await getEpisodeDetail();
    await getComments();
    change(null, status: RxStatus.success());
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
      comments .value = data;
      return true;
    } catch (e, s) {
      print(e.toString());
      return false;
    }
  }
}
