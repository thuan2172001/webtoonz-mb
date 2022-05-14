import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:untitled/model/custom_dio.dart';
import 'package:untitled/model/message.dart';
import '../global_controller.dart';

class ChatController extends GetxController {
  RxList<MessageModel> messages = <MessageModel>[].obs;
  TextEditingController chatBody = TextEditingController();
  RxBool flag = false.obs;
  RxString conversationId = "".obs;
  RxString receiverId = "8770eb81-d2e5-4c3e-ab68-f5beed99bcd8".obs;

  Future getConversation() async {
    try {
      CustomDio customDio = CustomDio();
      customDio.dio.options.headers["Authorization"] =
          Get.put(GlobalController()).user.value.certificate.toString();
      var response = await customDio.get("/conversation/$conversationId");
      var json = jsonDecode(response.toString());
      print("debug");
      if (json["success"] == true) {
        messages.clear();
        var messagesData = json["data"]["messages"];
        for (int i = 0; i < messagesData.length; i++) {
          var messageData = MessageModel.fromJson(messagesData[i]);
          messages.add(messageData);
        }
        messages.value = messages.reversed.toList();
      }
      return true;
    } catch (e) {
      return false;
    }
  }

  Future sendMessage(String mesRole) async {
    try {
      CustomDio customDio = CustomDio();
      customDio.dio.options.headers["Authorization"] =
          Get.put(GlobalController()).user.value.certificate.toString();
      var response = await customDio.post("/chat", {
        "receiver": receiverId.value,
        "message": chatBody.text,
      });
      var json = jsonDecode(response.toString());
      if (json["success"] == true) {
        messages.insert(
            0,
            MessageModel(
              time: DateTime.now().millisecond,
              sendBy: mesRole,
              body: chatBody.text,
            ));
        chatBody.text = "";
      }
      return true;
    } catch (e) {
      return false;
    }
  }
}
