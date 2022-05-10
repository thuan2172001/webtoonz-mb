import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../main.dart';
import '../../model/custom_dio.dart';

class CreateEpisodeController extends GetxController {
  final String seriesId;
  Rx<File> logo = File("").obs;
  Rx<File> file = File("").obs;
  Rx<String>fileName="".obs;
  TextEditingController episodeName = TextEditingController();
  TextEditingController price = TextEditingController();
  TextEditingController description = TextEditingController();

  CreateEpisodeController({required this.seriesId});

  Future createEpisode()async{
    try {
      var key = await globalController.uploadFile(file.value);
      var thumbnail=await globalController.uploadFile(logo.value);
      print(key);
      print(thumbnail);
      // var key="1c399904-9cbd-4449-ae6b-bd3db0bee088-a.jpg";
      // var thumbnail="4daaec36-3bbc-481d-bf92-1bccd48e4c94-image_picker7120698755525514652.jpg";
      thumbnail="https://webtoonz.uetbc.xyz/uploads/"+thumbnail;
      CustomDio customDio = CustomDio();
      var data={
        "chapter":"1",
        "pageNumber":"1",
        "name": episodeName.text,
        "key": key,
        "description": description.text,
        "serieId": seriesId,
        "thumbnail": thumbnail,
        "price": price.text,
      };
      var response = await customDio.post("/episode", data);

      return response;
    } catch (e, s) {
      return null;
    }
  }
}
