import 'dart:convert';

import 'package:au_chat/models/user_model.dart';

TeamModel teamModelFromJson(String str) => TeamModel.fromJson(json.decode(str));

String teamModelToJson(TeamModel data) => json.encode(data.toJson());

class TeamModel {
  String name;
  dynamic chatRoom;
  List<dynamic> players;
  UserModel owner;

  TeamModel({
    this.name,
    this.chatRoom,
    this.players,
    this.owner,
  });

  factory TeamModel.fromJson(Map<String, dynamic> json) {
    return TeamModel(
      name: json["name"],
      chatRoom: json["chatRoom"],
      players: json["players"],
      owner: json["owner"],
    );
  }

  Map<String, dynamic> toJson() => {
        "name": name,
        "chatRoom": chatRoom,
        "players": players,
        "owner": owner,
      };
}
