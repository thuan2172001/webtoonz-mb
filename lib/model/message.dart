import 'dart:convert';

MessageModel messageModelFromJson(String str) =>
    MessageModel.fromJson(json.decode(str));

String messageModelToJson(MessageModel data) => json.encode(data.toJson());

class MessageModel {
  String sendBy;
  String body;
  int time;

  MessageModel({
    required this.sendBy,
    required this.body,
    required this.time,
  });

  factory MessageModel.fromJson(Map<String, dynamic> json) => MessageModel(
        sendBy: json["sendBy"],
        body: json["body"],
        time: json["time"],
      );

  Map<String, dynamic> toJson() => {
        "sender": sendBy,
        "body": body,
        "time": time,
      };
}
