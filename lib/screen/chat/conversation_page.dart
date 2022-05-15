import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:untitled/controller/chat/chat_controller.dart';
import 'package:untitled/controller/global_controller.dart';
import 'package:untitled/screen/chat/chat_page.dart';
import 'package:untitled/utils/config.dart';
import 'package:untitled/widgets/app_bar.dart';

class ConversationPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    GlobalController globalController = Get.put(GlobalController());
    ChatController chatController = Get.put(ChatController());
    String mesRole =
        globalController.user.value.role == "creator" ? "receiver" : "sender";
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        backgroundColor: Colors.grey[100],
        appBar: appBar(
            elevation: 0,
            title: "Messages",
            centerTitle: true,
            actions: <Widget>[
              IconButton(
                icon: Icon(Icons.more_horiz),
                iconSize: 30,
                color: Colors.white,
                onPressed: () {},
              )
            ],
            backFunction: () {
              chatController.stopFetchConversations();
              Get.delete<ChatController>();
            }),
        body: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30),
                topRight: Radius.circular(30),
              ),
              child: Obx(
                () => ListView.builder(
                  reverse: false,
                  padding: EdgeInsets.only(top: 15),
                  itemCount: chatController.conversations.length,
                  itemBuilder: (BuildContext context, int index) {
                    var data = chatController.conversations[index];
                    return GestureDetector(
                      onTap: () async {
                        chatController.conversationId.value =
                            data["conversationId"];
                        chatController.receiverId.value =
                            data["friendInfo"]["_id"];
                        Get.to(MessagesPage());
                      },
                      child: Container(
                          padding: EdgeInsets.symmetric(
                              vertical: getHeight(10),
                              horizontal: getWidth(10)),
                          decoration: BoxDecoration(
                            border: Border(
                                top: BorderSide(
                                    width: 1, color: Colors.black26)),
                          ),
                          child: Row(
                            children: [
                              CircleAvatar(
                                radius: getWidth(24),
                                backgroundColor: Colors.white,
                                child: CircleAvatar(
                                  radius: getWidth(20),
                                  child: Image.asset(
                                      "assets/icons/user-default.png"),
                                ),
                              ),
                              SizedBox(
                                width: getWidth(4),
                              ),
                              Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      data["friendInfo"]["fullName"],
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                        fontSize: getWidth(18),
                                      ),
                                    ),
                                    Text(
                                      data["lastMessage"],
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.normal,
                                        fontSize: getWidth(12),
                                      ),
                                    ),
                                  ]),
                            ],
                          )),
                    );
                  },
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
