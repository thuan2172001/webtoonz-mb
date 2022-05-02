import 'dart:convert';
import 'package:get/get.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:untitled/controller/global_controller.dart';
import 'package:untitled/model/Serie.dart';
import 'package:untitled/model/custom_dio.dart';

class FavoriteEpisodeController extends GetxController {
  Rx<FavoriteEpisode> favoriteEpisode = FavoriteEpisode(listEpisode: []).obs;

  @override
  void onInit() async {
    super.onInit();
    await getFavoriteEpisode();
  }

  Future getFavoriteEpisode() async {
    try {
      CustomDio customDio = CustomDio();
      customDio.dio.options.headers["Authorization"] =
          Get.put(GlobalController()).user.value.certificate.toString();
      var response = await customDio.get("/user/favor-data");
      response = jsonDecode(response.toString());
      favoriteEpisode.value = FavoriteEpisode.fromJson(response);
      return true;
    } catch (e, s) {
      return false;
    }
  }
}

@JsonSerializable()
class FavoriteEpisode {
  var totalEpisode;
  List<SeriesEpisode> listEpisode;

  FavoriteEpisode({
    this.totalEpisode,
    required this.listEpisode,
  });

  factory FavoriteEpisode.fromJson(Map<String, dynamic> json) => _$FavoriteEpisodeFromJson(json);
}

FavoriteEpisode _$FavoriteEpisodeFromJson(Map<String, dynamic> json) => FavoriteEpisode(
  listEpisode: (json["data"]["data"] as List<dynamic>)
      .map((e) => SeriesEpisode.fromJson(e as Map<String, dynamic>))
      .toList(),
  totalEpisode: json["data"]["totalEpisode"],
);