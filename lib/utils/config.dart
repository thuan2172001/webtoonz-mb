import 'package:flutter/material.dart';
import 'package:get/get.dart';

double designWidth = 349;
double designHeight = 651;

String differenceTime(String s) {
  var today = DateTime.now();
  var date = DateTime.parse(s);
  var sub = today.difference(date);
  if (sub.inDays > 0) return "${sub.inDays} phút trước";
  if (sub.inHours > 0) return "${sub.inHours} giờ trước";
  if (sub.inMinutes > 0) return "${sub.inMinutes} phút trước";
  if(sub.inSeconds>0)return "${sub.inSeconds} giây trước";
  return "0 giây trước";
}

double screenWidth() {
  return MediaQuery.of(Get.context!).size.width;
}

double screenHeight() {
  return MediaQuery.of(Get.context!).size.height;
}

double getWidth(double width) {
  return width * screenWidth() / designWidth;
}

double getHeight(double height) {
  return height * screenHeight() / designHeight;
}
