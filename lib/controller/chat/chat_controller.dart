import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:untitled/model/custom_dio.dart';
import 'package:untitled/model/message.dart';
import '../global_controller.dart';

class ChatController extends GetxController {
  RxList<MessageModel> messages = <MessageModel>[].obs;
  RxList<dynamic> conversations = <dynamic>[].obs;
  TextEditingController chatBody = TextEditingController();
  RxBool flag = false.obs;
  RxString conversationId = "".obs;
  RxString receiverId = "8770eb81-d2e5-4c3e-ab68-f5beed99bcd8".obs;
  late Timer fetchConversations;
  late Timer fetchDetail;

  void onInit() async {
    super.onInit();
    startFetchConversations();
    startFetchDetail();
  }

  void onDispose() {
    fetchConversations.cancel();
    fetchDetail.cancel();
  }

  void stopFetchConversations() {
    fetchConversations.cancel();
  }

  void stopFetchDetail() {
    fetchDetail.cancel();
  }

  void startFetchConversations() {
    fetchConversations = Timer.periodic(new Duration(seconds: 2), (timer) {
      print("fetch conversation");
      getConversations();
    });
    ;
  }

  void startFetchDetail() {
    fetchDetail = Timer.periodic(new Duration(seconds: 1), (timer) {
      if (conversationId.value != "") {
        print("fetch ${conversationId.value}");
        getConversation();
      }
    });
    ;
  }

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
      messages.value = [];
      return false;
    }
  }

  Future getConversations() async {
    try {
      CustomDio customDio = CustomDio();
      customDio.dio.options.headers["Authorization"] =
          Get.put(GlobalController()).user.value.certificate.toString();
      var response = await customDio.get("/conversation");
      var json = jsonDecode(response.toString());
      if (json["success"] == true) {
        conversations.clear();
        conversations.value = json["data"]["data"];
      }
      return true;
    } catch (e) {
      conversations.value = [];
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
