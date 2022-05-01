import 'dart:convert';
import 'package:get/get.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:untitled/controller/global_controller.dart';
import 'package:untitled/model/custom_dio.dart';
import '../../model/Serie.dart';

// List<Series> buildFavoriteSeries() {
//   List<SeriesEpisode> testEpisodes = [];
//   for (int i = 0; i < 10; i++) {
//     testEpisodes.add(SeriesEpisode(
//         "Under the sea season 3",
//         "26",
//         "https://nftjapan.s3.ap-southeast-1.amazonaws.com/image/f7cee056-a816-439b-a37e-5cdbdebdd132-AriumWeb1x1.008.png",
//         921,
//         1995));
//   }
//   Series series = Series(
//       "Sky on the garden",
//       "Light Wealthy Awkward Spite Ice Angelic Pleasant Entry Only Bright Far-off Decisive Argument Formal Shock Acrobatic Thing Primary Previous Building Illustrious Reach Interest Park Efficiency Optimistic Boss Present Opportunity Cabinet Beat Lead Velvety Nonstop Forthright High Enraged Flawed Voice Double ",
//       "https://nftjapan.s3.ap-southeast-1.amazonaws.com/image/346fa06b-c795-405d-b12c-63b8c21860d7-AriumWeb1x1.028.png",
//       "https://nftjapan.s3.ap-southeast-1.amazonaws.com/image/f0c37c95-af79-42d4-bd96-5888181031e8-AriumWeb20x9.004.png",
//       60,
//       1000,
//       1000,
//       "Drama",
//       testEpisodes,
//       "Author Name",
//       "https://files.catbox.moe/8sv2t3.jpg");
//
//   List<Series> testFavoriteSeries = [];
//   for (int i = 0; i < 10; i++) {
//     testFavoriteSeries.add(series);
//   }
//   return testFavoriteSeries;
// }

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
      print("1234");
      print(favoriteSeries.value.listSeries);
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

  Map<String, dynamic> toJson() => _$FavoriteSeriesToJson(this);
}

FavoriteSeries _$FavoriteSeriesFromJson(Map<String, dynamic> json) => FavoriteSeries(
  listSeries: (json["data"]["data"] as List<dynamic>)
      .map((e) => Series.fromJson(e as Map<String, dynamic>))
      .toList(),
  totalSeries: json["data"]["totalSeries"],
);

Map<String, dynamic> _$FavoriteSeriesToJson(FavoriteSeries instance) => <String, dynamic>{
  'data': instance.listSeries,
  'totalSeries': instance.totalSeries,
};