import 'dart:convert';
import 'package:get/get.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:untitled/controller/global_controller.dart';
import 'package:untitled/model/Serie.dart';
import 'package:untitled/model/custom_dio.dart';

class FavoriteSeriesController extends GetxController {
  Rx<FavoriteSeries> favoriteSeries = FavoriteSeries(listSeries: []).obs;

  @override
  void onInit() async {
    super.onInit();
    await getFavoriteSeries();
  }

  Future getFavoriteSeries() async {
    try {
      CustomDio customDio = CustomDio();
      customDio.dio.options.headers["Authorization"] =
          Get.put(GlobalController()).user.value.certificate.toString();
      var response = await customDio.get("/user/favor-data", {
        "type": "SERIES",
      });
      response = jsonDecode(response.toString());
      favoriteSeries.value = FavoriteSeries.fromJson(response);
      return true;
    } catch (e, s) {
      return false;
    }
  }
}

@JsonSerializable()
class FavoriteSeries {
  var totalSeries;
  List<Series> listSeries;

  FavoriteSeries({
    this.totalSeries,
    required this.listSeries,
  });

  factory FavoriteSeries.fromJson(Map<String, dynamic> json) => _$FavoriteSeriesFromJson(json);
}

FavoriteSeries _$FavoriteSeriesFromJson(Map<String, dynamic> json) => FavoriteSeries(
  listSeries: (json["data"]["data"] as List<dynamic>)
      .map((e) => Series.fromJson(e as Map<String, dynamic>))
      .toList(),
  totalSeries: json["data"]["totalSeries"],
);