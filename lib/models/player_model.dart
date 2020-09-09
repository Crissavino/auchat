import 'dart:convert';

import 'package:au_chat/models/user_model.dart';

PlayerModel playerModelFromJson(String str) =>
    PlayerModel.fromJson(json.decode(str));

String playerModelToJson(PlayerModel data) => json.encode(data.toJson());

class PlayerModel {
  UserModel user;
  List<dynamic> teams;
  List<dynamic> devices;
  List<dynamic> messages;

  PlayerModel({
    this.user,
    this.teams,
    this.devices,
    this.messages,
  });

  factory PlayerModel.fromJson(Map<String, dynamic> json) {
    return PlayerModel(
      user: json["user"],
      teams: json["teams"],
      devices: json["devices"],
      messages: json["messages"],
    );
  }

  Map<String, dynamic> toJson() => {
        "user": user,
        "teams": teams,
        "devices": devices,
        "messages": messages,
      };
}
