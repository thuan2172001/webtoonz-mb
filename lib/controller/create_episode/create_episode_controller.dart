import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../main.dart';
import '../../model/custom_dio.dart';

class CreateEpisodeController extends GetxController {
  RxBool isLoading = false.obs;
  final String seriesId;
  Rx<File> logo = File("").obs;
  Rx<File> file = File("").obs;
  Rx<String> fileName = "".obs;
  TextEditingController episodeName = TextEditingController();
  TextEditingController price = TextEditingController();
  TextEditingController description = TextEditingController();

  CreateEpisodeController({required this.seriesId});

  void reset()
  {
    logo.value=File("");
    file.value=File("");
    fileName.value="";
    episodeName.text="";
    price.text="";
    description.text="";
  }

  Future createEpisode() async {
    try {
      if(episodeName.text.isEmpty)return null;
      if(price.text.isEmpty)return null;
      if(description.text.isEmpty)return null;
      if(logo.value.path.isEmpty)return null;
      if(file.value.path.isEmpty)return null;
      var key = await globalController.uploadFile(file.value);
      var thumbnail = await globalController.uploadFile(logo.value);
      thumbnail = "https://webtoonz.uetbc.xyz/uploads/" + thumbnail;
      CustomDio customDio = CustomDio();
      var data = {
        "chapter": "1",
        "pageNumber": "1",
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
