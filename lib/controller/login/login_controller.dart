import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:untitled/api/certificate_service.dart';
import 'package:untitled/api/signature_service.dart';
import 'package:untitled/main.dart';
import 'package:untitled/model/User.dart';
import 'package:untitled/model/custom_dio.dart';
import 'package:untitled/model/status.dart';
import 'package:untitled/screen/login/login_screen.dart';
import 'package:untitled/service/date_format.dart';
import 'package:untitled/service/response_validator.dart';

import '../global_controller.dart';

class LoginPageController extends GetxController {
  Rx<LoginOption> loginOption = LoginOption.customer.obs;

  TextEditingController username = TextEditingController();
  TextEditingController password = TextEditingController();

  RxBool isHidePassword = true.obs;
  RxBool isLoading = false.obs;
  var messValidateUsername = "".obs;
  var messValidatePassword = "".obs;

  void changeHidePassword() {
    isHidePassword.value = !isHidePassword.value;
  }

  Future getPing(List<String> certificateList) async {
    try {
      CustomDio customDio = CustomDio();
      customDio.dio.options.headers["Authorization"] = certificateList[0];

      var response = await customDio.post(
        "/auth/ping",
        certificateList[1],
      );
      return response;
    } catch (e, s) {
      return null;
    }
  }

  Future getCredential(String username) async {
    try {
      CustomDio customDio = CustomDio();
      var response = await customDio.post("/auth/credential", {
        "username": username,
        "_actionType": "POST_API-AUTH-CREDENTIAL",
      });
      return response;
    } catch (e, s) {
      return null;
    }
  }

  Future<bool> login() async {
    messValidateUsername.value = "";
    messValidatePassword.value = "";
    if (username.text == "") {
      messValidateUsername.value = "invalid_username";
    } else if (password.text == "") {
      messValidatePassword.value = "invalid_password";
    } else {
      var responseCredential = await getCredential(username.text);
      responseCredential = jsonDecode(responseCredential.toString());

      if (responseCredential["success"] == false) {
        messValidateUsername.value = "invalid_username";
      } else {
        var data = responseCredential["data"];
        var publicKey = data['publicKey'];
        var encryptedPrivateKey = data['encryptedPrivateKey'];
        String? privateKey =
            decryptAESCryptoJS(encryptedPrivateKey, password.text);

        Status validatePassword = Status();

        if (privateKey == null) {
          validatePassword = Status(status: "ERROR", message: "WRONG.PASSWORD");
        } else {
          validatePassword = Status(status: "SUCCESS", message: "SUCCESS");
        }

        if (validatePassword.status == "SUCCESS") {
          var certificateInfo =
              SignatureService.getCertificateInfo(username.text);
          String signature = SignatureService.getSignature(
              certificateInfo, privateKey as String);
          String times = TimeService.getTimeNow().toString();
          List<String> certificateList = SignatureService.getCertificateLogin(
            certificateInfo,
            username.text,
            encryptedPrivateKey,
            signature,
            publicKey,
            times,
          );

          User userInfo = User();

          var responsePing = await getPing(certificateList);
          Status validateServer2 = ResponseValidator.check(responsePing);
          var jsonResponse = jsonDecode(responsePing.toString());
          if (validateServer2.status == "OK") {
            userInfo.id = jsonResponse["data"]["_id"];
            userInfo.username = jsonResponse["data"]["username"];
            userInfo.mail = jsonResponse["data"]["email"];
            userInfo.fullName = jsonResponse["data"]["fullName"];
            userInfo.encryptedPrivateKey =
                jsonResponse["data"]["encryptedPrivateKey"];
            userInfo.role = jsonResponse["data"]["role"];
            userInfo.phone = jsonResponse["data"]["phoneNumber"];
            userInfo.certificate = certificateList[0];
            globalController.user.value = userInfo;
            await globalController.getEpisodeIdsInCart();
            return true;
          } else {
            messValidatePassword.value = "invalid_password";
          }
        } else {
          messValidatePassword.value = "invalid_password";
        }
      }
    }
    return false;
  }
}
