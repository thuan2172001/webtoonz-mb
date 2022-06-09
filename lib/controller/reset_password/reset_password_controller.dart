import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:untitled/api/certificate_service.dart';
import 'package:untitled/model/custom_dio.dart';
import 'package:untitled/widgets/dialog.dart';

class ResetPasswordController extends GetxController {
  TextEditingController password = TextEditingController();
  TextEditingController confirmPassword = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController code = TextEditingController();

  RxBool isHidePassword = true.obs;
  RxBool isHideCfPassword = true.obs;

  void changeHidePassword() {
    isHidePassword.value = !isHidePassword.value;
  }

  void changeHideCfPassword() {
    isHideCfPassword.value = !isHideCfPassword.value;
  }

  Future<bool> forgotPassword(var context) async {
    try {
      CustomDio customDio = CustomDio();
      var response = await customDio.post(
        "/auth/forgot-password",
        {
          "email": email.text,
        },
      );
      var json = jsonDecode(response.toString());
      if (json["success"] == false) {
        return false;
      }
      return true;
    } catch (e) {
      print(e);
      CustomDialog(context, "FAILED").show({"message": e.toString()});
      return false;
    }
  }

  Future<bool> resetPassword(var context) async {
    try {
      CustomDio customDio = CustomDio();
      var encryptedKeyPair = generateKeyPairAndEncrypt(password.text);
      var response = await customDio.put(
        "/auth/reset-password",
        {
          "email": email.text,
          "codeId": code.text,
          "encryptedPrivateKey": encryptedKeyPair["encryptedPrivateKey"],
          "publicKey": encryptedKeyPair["publicKey"],
        },
      );
      var json = jsonDecode(response.toString());
      if (json["success"] == false) {
        return false;
      }
      return true;
    } catch (e) {
      print(e);
      CustomDialog(context, "FAILED").show({"message": e.toString()});
      return false;
    }
  }
}
