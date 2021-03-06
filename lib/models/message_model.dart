import 'dart:convert';

import 'package:au_chat/models/user_model.dart';

MessageModel messageModelFromJson(String str) =>
    MessageModel.fromJson(json.decode(str));

String messageModelToJson(MessageModel data) => json.encode(data.toJson());

class MessageModel {
  UserModel sender;
  String time;
  String text;
  bool isLiked;
  bool unread;
  String language;
  dynamic chatRoom;

  MessageModel({
    this.sender,
    this.time,
    this.text,
    this.isLiked,
    this.unread,
    this.language,
    this.chatRoom,
  });

  factory MessageModel.fromJson(Map<String, dynamic> json) => MessageModel(
        sender: json["sender"],
        time: json["time"],
        text: json["text"],
        isLiked: json["isLiked"],
        unread: json["unread"],
        language: json["language"],
        chatRoom: json["chatRoom"],
      );

  Map<String, dynamic> toJson() => {
        "sender": sender,
        "time": time,
        "text": text,
        "isLiked": isLiked,
        "unread": unread,
        "language": language,
        "chatRoom": chatRoom,
      };
}
