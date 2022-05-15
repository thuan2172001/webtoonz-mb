import 'dart:convert';
import 'package:get/get.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:untitled/controller/favorite/favorite_series_controller.dart';
import 'package:untitled/controller/global_controller.dart';
import 'package:untitled/model/Serie.dart';
import 'package:untitled/model/custom_dio.dart';

class CreatorDetailController extends GetxController {
  Rx<CreatorInfo> creatorInfo = CreatorInfo().obs;
  RxList<Series> listSeries = <Series>[].obs;
  RxList<Series> pageSeries = <Series>[].obs;

  final int limit = 6;

  Future init() async {
    await getCreatorInfo();
    await getList();
  }

  Future getCreatorInfo() async {
    try {
      CustomDio customDio = CustomDio();
      customDio.dio.options.headers["Authorization"] =
          Get.put(GlobalController()).user.value.certificate.toString();
      var response =
      await customDio.get("/creator/1c2347cc-160d-11ec-a238-cb22be0d8bab");
      response = jsonDecode(response.toString());
      creatorInfo.value = CreatorInfo.fromJson(response);

      return true;
    } catch (e, s) {
      return false;
    }
  }

  Future getSeries(int page) async {
    try {
      CustomDio customDio = CustomDio();
      customDio.dio.options.headers["Authorization"] =
          Get.put(GlobalController()).user.value.certificate.toString();
      var response = await customDio.get("/serie?limit=$limit&page=$page");
      response = jsonDecode(response.toString());
      pageSeries.value = FavoriteSeries.fromJson(response).listSeries;

      return true;
    } catch (e, s) {
      return false;
    }
  }

  Future getList() async {
    try {
      CustomDio customDio = CustomDio();
      customDio.dio.options.headers["Authorization"] =
          Get.put(GlobalController()).user.value.certificate.toString();
      var response = await customDio.get("/serie");
      response = jsonDecode(response.toString());
      listSeries.value = FavoriteSeries.fromJson(response).listSeries;
      pageSeries.value = listSeries.sublist(0, limit);
      return true;
    } catch (e, s) {
      return false;
    }
  }
}

@JsonSerializable()
class CreatorInfo {
  var id;
  var fullName;
  var avatar;
  var description;
  var sns;
  var createdAt;
  var seriesQuantity;
  var episodeQuantity;
  var mediaLinks;

  CreatorInfo({
    this.id,
    this.fullName,
    this.avatar,
    this.description,
    this.sns,
    this.createdAt,
    this.seriesQuantity,
    this.episodeQuantity,
    this.mediaLinks,
  });

  factory CreatorInfo.fromJson(Map<String, dynamic> json) {
    return CreatorInfo(
        id: json["data"]["creator"]["_id"],
        fullName: json["data"]["creator"]["fullName"],
        avatar: json["data"]["creator"]["avatar"],
        description: json["data"]["creator"]["description"],
        sns: json["data"]["creator"]["sns"],
        createdAt: json["data"]["creator"]["createdAt"],
        mediaLinks: json["data"]["creator"]["mediaLinks"],
        seriesQuantity: json["data"]["seriesQuantity"],
        episodeQuantity: json["data"]["episodeQuantity"]);
  }
}
