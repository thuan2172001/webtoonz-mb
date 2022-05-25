import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:untitled/model/Serie.dart';

import '../../main.dart';
import '../../model/custom_dio.dart';

class EditSeriesController extends GetxController {
  String seriesId="";
  RxBool isLoading = false.obs;
  TextEditingController seriesName = TextEditingController();
  String seriesCategory = "";
  TextEditingController description = TextEditingController();
  Rx<File> logo = File("").obs;
  Rx<File> banner = File("").obs;
  String cover = "";
  String thumbnail = "";

  EditSeriesController({required Series serieData}){
    seriesId=serieData.serieId;
    seriesName.text = serieData.serieName;
    seriesCategory = serieData.categoryId;
    description.text = serieData.description;
    thumbnail = serieData.thumbnail;
    cover = serieData.cover;
  }

  Future updateSeries() async {
    try {
      if (seriesName.text.isEmpty) return false;
      if (seriesCategory.isEmpty) return false;
      if (description.text.isEmpty) return false;
      if (banner.value.path.isNotEmpty){
        cover = await globalController.uploadFile(banner.value);
        cover = "https://webtoonz.uetbc.xyz/uploads/" + cover;
      }
      if (logo.value.path.isNotEmpty) {
        thumbnail = await globalController.uploadFile(logo.value);
        thumbnail = "https://webtoonz.uetbc.xyz/uploads/" + thumbnail;
      }
      CustomDio customDio = CustomDio();
      var data = {
        "serieName": seriesName.text,
        "categoryId": seriesCategory,
        "description": description.text,
        "thumbnail": thumbnail,
        "cover": cover,
      };
      var response = await customDio.put("/serie/$seriesId", data);
      response = jsonDecode(response.toString());
      if (response["success"] != true) return false;
      return true;
    } catch (e, s) {
      return false;
    }
  }
}
