import 'package:flutter/material.dart';
import 'package:untitled/utils/config.dart';
import 'package:get/get.dart';

SizedBox getAppName() {
  return SizedBox(
    width: getWidth(127),
    child: Center(
      child: Container(
        alignment: Alignment.center,
        height: getHeight(40),
        width: getWidth(127),
        decoration: BoxDecoration(
          color: Color(0xFF3669C9),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Text(
          "appName".tr,
          style: TextStyle(
            color: Colors.white,
            fontSize: getHeight(20),
          ),
        ),
      ),
    ),
  );
}
