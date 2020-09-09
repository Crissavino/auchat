import 'dart:convert';

import 'package:au_chat/models/user_model.dart';

MessagePlayerModel messagePlayerModelFromJson(String str) =>
    MessagePlayerModel.fromJson(json.decode(str));

String messagePlayerModelToJson(MessagePlayerModel data) =>
    json.encode(data.toJson());

class MessagePlayerModel {
  UserModel sender;
  dynamic message;
  dynamic player;
  dynamic chatRoom;
  dynamic time;
  String text;
  bool isLiked;
  bool unread;
  String language;

  MessagePlayerModel({
    this.sender,
    this.message,
    this.player,
    this.chatRoom,
    this.time,
    this.text,
    this.isLiked,
    this.unread,
    this.language,
  });

  factory MessagePlayerModel.fromJson(Map<String, dynamic> json) =>
      MessagePlayerModel(
        sender: json["sender"],
        message: json["message"],
        player: json["player"],
        chatRoom: json["chatRoom"],
        time: json["time"],
        text: json["text"],
        isLiked: json["isLiked"],
        unread: json["unread"],
        language: json["language"],
      );

  Map<String, dynamic> toJson() => {
        "sender": sender,
        "message": message,
        "player": player,
        "chatRoom": chatRoom,
        "time": time,
        "text": text,
        "isLiked": isLiked,
        "unread": unread,
        "language": language,
      };
}
