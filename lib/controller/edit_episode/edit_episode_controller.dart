import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:untitled/model/Serie.dart';

import '../../main.dart';
import '../../model/custom_dio.dart';
import '../../model/espisode.dart';

class EditEpisodeController extends GetxController {
  RxBool isLoading = false.obs;
  Rx<File> logo = File("").obs;
  Rx<File> file = File("").obs;
  RxString fileName="".obs;
  String episodeId = "";
  String urlLogo = "";
  String urlFile = "";
  TextEditingController episodeName = TextEditingController();
  TextEditingController price = TextEditingController();
  TextEditingController description = TextEditingController();

  EditEpisodeController({required Episode episode}) {
    episodeId = episode.id;
    urlLogo = episode.image;
    urlFile = episode.key;
    episodeName.text = episode.name;
    price.text = episode.price.toString();
    description.text = episode.description;
    fileName.value=episode.name+urlFile.substring(urlFile.lastIndexOf("."));
  }

  Future updateEpisode() async {
    try {
      if (episodeName.text.isEmpty) return false;
      if (price.text.isEmpty) return false;
      if (description.text.isEmpty) return false;
      if (logo.value.path.isNotEmpty) {
        urlLogo = await globalController.uploadFile(logo.value);
        urlLogo = "https://webtoonz.uetbc.xyz/uploads/" + urlLogo;
      }
      if (file.value.path.isNotEmpty) {
        urlFile = await globalController.uploadFile(file.value);
      }
      CustomDio customDio = CustomDio();
      var data = {
        "chapter": "1",
        "name": episodeName.text,
        "key": urlFile,
        "pageNumber": "1",
        "description": description.text,
        "thumbnail": urlLogo,
        "price": price.text
      };
      var response = await customDio.put("/episode/$episodeId", data);
      response = jsonDecode(response.toString());
      if (response["success"] != true) return false;
      return true;
    } catch (e, s) {
      return false;
    }
  }
}
