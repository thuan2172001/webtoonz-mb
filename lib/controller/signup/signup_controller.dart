import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:untitled/api/certificate_service.dart';
import 'package:untitled/model/custom_dio.dart';
import 'package:timer_count_down/timer_controller.dart';

class SignupController extends GetxController {
  TextEditingController email = TextEditingController();
  TextEditingController phoneNumber = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController confirmPassword = TextEditingController();
  TextEditingController fullName = TextEditingController();

  RxBool isHidePassword = true.obs;
  RxBool isHideCfPassword = true.obs;
  RxBool isCustomerMode = true.obs;
  RxBool isAgree = false.obs;

  void resetInput() {
    email.clear();
    phoneNumber.clear();
    password.clear();
    confirmPassword.clear();
    isAgree.value = false;
  }

  void updateTime() {
    update(["validateOTP"]);
  }

  void changeHidePassword() {
    isHidePassword.value = !isHidePassword.value;
  }

  void changeHideCfPassword() {
    isHideCfPassword.value = !isHideCfPassword.value;
  }

  Future checkAccount() async {
    try {
      CustomDio customDio = CustomDio();
      var response = await customDio
          .get("/auth/check?mail=${email.text}&phone=${phoneNumber.text}");

      var json = jsonDecode(response.toString());
      if (json["success"] == true) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future signup() async {
    try {
      var keyPair = generateKeyPairAndEncrypt(password.text);
      CustomDio customDio = CustomDio();
      var data = {
        "email": email.text,
        "username": email.text,
        "phoneNumber": phoneNumber.text,
        "encryptedPrivateKey": keyPair["encryptedPrivateKey"],
        "publicKey": keyPair["publicKey"],
        "fullName": fullName.text,
        "age": 18,
      };

      var response = await customDio.post(
        "/user",
        data,
      );
      var json = jsonDecode(response.toString());
      var result = json["data"];
      return result ?? json;
    } catch (e, s) {
      return null;
    }
  }
}
