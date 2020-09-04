import 'dart:convert';

import 'package:au_chat/models/user_model.dart';
import 'package:au_chat/models/message_model.dart';

ChatRoomModel chatRoomModelFromJson(String str) =>
    ChatRoomModel.fromJson(json.decode(str));

String chatRoomModelToJson(ChatRoomModel data) => json.encode(data.toJson());

class ChatRoomModel {
  String name;
  String description;
  bool isPinned;
  bool unreadMessages;
  dynamic team;
  List<dynamic> messages;
  dynamic players;
  dynamic lastMessage;
  String image;

  ChatRoomModel({
    this.name,
    this.description,
    this.isPinned,
    this.unreadMessages,
    this.team,
    this.messages,
    this.players,
    this.lastMessage,
    this.image,
  });

  factory ChatRoomModel.fromJson(Map<String, dynamic> json) => ChatRoomModel(
        name: json["name"],
        description: json["description"],
        isPinned: json["isPinned"],
        unreadMessages: json["unreadMessages"],
        team: json["team"],
        messages: json["messages"],
        players: json["players"],
        lastMessage: json["lastMessage"],
        image: json["image"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "description": description,
        "isPinned": isPinned,
        "unreadMessages": unreadMessages,
        "team": team,
        "messages": messages,
        "players": players,
        "lastMessage": lastMessage,
        "image": image,
      };
}

// EXAMPLE CHATS ON HOME SCREEN
// List<MessageModel> chats = [
//   MessageModel(
//     sender: james,
//     time: '5:30 PM',
//     text: 'Hey, how\'s it going? What did you do today?',
//     isLiked: false,
//     unread: true,
//   ),
//   MessageModel(
//     sender: olivia,
//     time: '4:30 PM',
//     text: 'Hey, how\'s it going? What did you do today?',
//     isLiked: false,
//     unread: true,
//   ),
//   MessageModel(
//     sender: john,
//     time: '3:30 PM',
//     text: 'Hey, how\'s it going? What did you do today?',
//     isLiked: false,
//     unread: false,
//   ),
//   MessageModel(
//     sender: sophia,
//     time: '2:30 PM',
//     text: 'Hey, how\'s it going? What did you do today?',
//     isLiked: false,
//     unread: true,
//   ),
//   MessageModel(
//     sender: steven,
//     time: '1:30 PM',
//     text: 'Hey, how\'s it going? What did you do today?',
//     isLiked: false,
//     unread: false,
//   ),
//   MessageModel(
//     sender: sam,
//     time: '12:30 PM',
//     text: 'Hey, how\'s it going? What did you do today?',
//     isLiked: false,
//     unread: false,
//   ),
//   MessageModel(
//     sender: greg,
//     time: '11:30 AM',
//     text: 'Hey, how\'s it going? What did you do today?',
//     isLiked: false,
//     unread: false,
//   ),
// ];
