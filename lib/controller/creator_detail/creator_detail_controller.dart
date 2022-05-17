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

  Future init(String id) async {
    // await getCreatorInfo(id);
    // await getList(id);
  }

  Future getCreatorInfo(String id) async {
    if (id == "") return;
    try {
      CustomDio customDio = CustomDio();
      customDio.dio.options.headers["Authorization"] =
          Get.put(GlobalController()).user.value.certificate.toString();
      var response = await customDio.get("/creator/$id");
      response = jsonDecode(response.toString());
      creatorInfo.value = CreatorInfo.fromJson(response);
      return true;
    } catch (e, s) {
      return false;
    }
  }

  Future getConversationId(String id) async {
    if (id == "") return;
    try {
      CustomDio customDio = CustomDio();
      customDio.dio.options.headers["Authorization"] =
          Get.put(GlobalController()).user.value.certificate.toString();
      var response = await customDio.get("/conversation-id?receiver=$id");
      response = jsonDecode(response.toString());
      if (response["success"] == true) {
        return response["data"]["conversationId"];
      }
      return null;
    } catch (e, s) {
      print(e);
      return null;
    }
  }

  Future getSeries(int page, String id) async {
    try {
      CustomDio customDio = CustomDio();
      customDio.dio.options.headers["Authorization"] =
          Get.put(GlobalController()).user.value.certificate.toString();
      var response =
          await customDio.get("/serie?limit=$limit&page=$page&creatorId=$id");
      response = jsonDecode(response.toString());
      pageSeries.value = FavoriteSeries.fromJson(response).listSeries;

      return true;
    } catch (e, s) {
      return false;
    }
  }

  Future getList(String id) async {
    try {
      CustomDio customDio = CustomDio();
      customDio.dio.options.headers["Authorization"] =
          Get.put(GlobalController()).user.value.certificate.toString();
      var response = await customDio.get("/serie?creatorId=$id");
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

  factory CreatorInfo.fromJsonInList(Map<String, dynamic> json) {
    return CreatorInfo(
        id: json["_id"],
        fullName: json["fullName"],
        avatar: json["avatar"],
        description: json["description"],
        sns: json["sns"],
        createdAt: json["createdAt"],
        mediaLinks: json["mediaLinks"],
        seriesQuantity: json["seriesQuantity"],
        episodeQuantity: json["episodeQuantity"]);
  }
}
