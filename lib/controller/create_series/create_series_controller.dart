import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../main.dart';
import '../../model/custom_dio.dart';

class CreateSeriesController extends GetxController {
  RxBool isLoading = false.obs;
  TextEditingController seriesName = TextEditingController();
  String seriesCategory="";
  TextEditingController description = TextEditingController();
  Rx<File> logo = File("").obs;
  Rx<File> banner = File("").obs;

  void reset()
  {
    seriesName.text="";
    description.text="";
    logo.value=File("");
    banner.value=File("");
  }

  Future createSeries() async {
    try {
      if(seriesName.text.isEmpty)return;
      if(seriesCategory.isEmpty)return;
      if(description.text.isEmpty)return;
      if(logo.value.path.isEmpty)return;
      if(banner.value.path.isEmpty)return;
      var cover = await globalController.uploadFile(banner.value);
      var thumbnail = await globalController.uploadFile(logo.value);
      cover = "https://webtoonz.uetbc.xyz/uploads/" + cover;
      thumbnail = "https://webtoonz.uetbc.xyz/uploads/" + thumbnail;
      CustomDio customDio = CustomDio();
      var data = {
        "serieName": seriesName.text,
        "categoryId": seriesCategory,
        "description": description.text,
        "thumbnail": thumbnail,
        "cover": cover,
      };
      var response = await customDio.post("/serie", data);

      return response;
    } catch (e, s) {
      return null;
    }
  }
}
