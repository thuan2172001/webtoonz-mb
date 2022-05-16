import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:untitled/controller/chat/chat_controller.dart';
import 'package:untitled/controller/global_controller.dart';
import 'package:untitled/model/message.dart';
import 'package:untitled/utils/config.dart';
import 'package:untitled/widgets/app_bar.dart';

class MessagesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    GlobalController globalController = Get.put(GlobalController());
    ChatController chatController = Get.put(ChatController());
    chatController.getConversation();
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
            title: "Thuan",
            actions: <Widget>[
              IconButton(
                icon: Icon(Icons.more_horiz),
                iconSize: 30,
                color: Colors.white,
                onPressed: () {},
              )
            ],
            backFunction: () {
              chatController.conversationId.value = "";
              chatController.stopFetchDetail();
            }),
        body: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Column(
            children: <Widget>[
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.grey[100],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                    ),
                    child: Obx(
                      () => ListView.builder(
                        reverse: true,
                        padding: EdgeInsets.only(top: 15),
                        itemCount: chatController.messages.length,
                        itemBuilder: (BuildContext context, int index) {
                          MessageModel message = chatController.messages[index];
                          final bool isMe = message.sendBy == mesRole;
                          return _buildMessage(message, isMe);
                        },
                      ),
                    ),
                  ),
                ),
              ),
              _buildMessageInput(chatController, mesRole)
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMessageInput(ChatController chatController, String mesRole) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.0),
      height: 70.0,
      color: Colors.grey[300],
      child: Row(
        children: <Widget>[
          SizedBox(
            width: getWidth(10),
          ),
          Expanded(
            child: TextField(
              maxLines: 1,
              controller: chatController.chatBody,
              cursorColor: Colors.black,
              textCapitalization: TextCapitalization.sentences,
              decoration:
                  InputDecoration.collapsed(hintText: 'Type something...'),
            ),
          ),
          IconButton(
            icon: Icon(Icons.send),
            iconSize: 25,
            color: Colors.black,
            onPressed: () async {
              String msg = chatController.chatBody.text;
              if (msg.isNotEmpty) {
                await chatController.sendMessage(mesRole);
              }
            },
          ),
        ],
      ),
    );
  }

  Widget _buildMessage(MessageModel message, bool isMe) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment:
          isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
      children: [
        Container(
          margin: isMe
              ? EdgeInsets.only(top: 8.0, bottom: 8.0, left: 80, right: 20)
              : EdgeInsets.only(top: 8.0, bottom: 8.0, right: 80, left: 20),
          padding: EdgeInsets.symmetric(horizontal: 25, vertical: 15),
          decoration: BoxDecoration(
            borderRadius: isMe
                ? BorderRadius.only(
                    topLeft: Radius.circular(15),
                    bottomLeft: Radius.circular(15))
                : BorderRadius.only(
                    topRight: Radius.circular(15),
                    bottomRight: Radius.circular(15)),
            color: isMe ? Colors.blue : Colors.black,
          ),
          child: Text(
            "${message.body}",
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
            textAlign: isMe ? TextAlign.right : TextAlign.left,
          ),
        )
      ],
    );
  }
}
