import 'dart:convert';
import 'package:get/get.dart';
import 'package:untitled/controller/global_controller.dart';
import 'package:untitled/model/custom_dio.dart';
import 'package:untitled/controller/favorite/favorite_episode_controller.dart';

class BookshelfController extends GetxController {
  Rx<FavoriteEpisode> bookshelf = FavoriteEpisode(listEpisode: []).obs;

  @override
  void onInit() async {
    super.onInit();
    await getBookshelf();
  }

  Future getBookshelf() async {
    try {
      CustomDio customDio = CustomDio();
      customDio.dio.options.headers["Authorization"] =
          Get.put(GlobalController()).user.value.certificate.toString();
      var response = await customDio.get("/user/bookshelf-data");
      response = jsonDecode(response.toString());
      bookshelf.value = FavoriteEpisode.fromJson(response);
      return true;
    } catch (e, s) {
      return false;
    }
  }
}
