import 'dart:convert';

import 'package:au_chat/models/user_model.dart';

MessageModel messageModelFromJson(String str) =>
    MessageModel.fromJson(json.decode(str));

String messageModelToJson(MessageModel data) => json.encode(data.toJson());

class MessageModel {
  UserModel sender;
  DateTime time;
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

// YOU - current user
final UserModel currentUser = UserModel(
  firebaseId: '0',
  fullName: 'Current User',
  imageUrl: 'assets/images/greg.jpg',
);

// USERS
final UserModel greg = UserModel(
  firebaseId: '1',
  fullName: 'Greg',
  imageUrl: 'assets/images/greg.jpg',
);
final UserModel james = UserModel(
  firebaseId: '2',
  fullName: 'James',
  imageUrl: 'assets/images/james.jpg',
);
final UserModel john = UserModel(
  firebaseId: '3',
  fullName: 'John',
  imageUrl: 'assets/images/john.jpg',
);
final UserModel olivia = UserModel(
  firebaseId: '4',
  fullName: 'Olivia',
  imageUrl: 'assets/images/olivia.jpg',
);
final UserModel sam = UserModel(
  firebaseId: '5',
  fullName: 'Sam',
  imageUrl: 'assets/images/sam.jpg',
);
final UserModel sophia = UserModel(
  firebaseId: '6',
  fullName: 'Sophia',
  imageUrl: 'assets/images/sophia.jpg',
);
final UserModel steven = UserModel(
  firebaseId: '7',
  fullName: 'Steven',
  imageUrl: 'assets/images/steven.jpg',
);

// FAVORITE CONTACTS
List<UserModel> favorites = [sam, steven, olivia, john, greg];

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

// EXAMPLE MESSAGES IN CHAT SCREEN
// List<MessageModel> messages = [
//   MessageModel(
//     sender: james,
//     time: '5:30 PM',
//     text: 'Hey, how\'s it going? What did you do today?',
//     isLiked: true,
//     unread: true,
//   ),
//   MessageModel(
//     sender: currentUser,
//     time: '4:30 PM',
//     text: 'Just walked my doge. She was super duper cute. The best pupper!!',
//     isLiked: false,
//     unread: true,
//   ),
//   MessageModel(
//     sender: james,
//     time: '3:45 PM',
//     text: 'How\'s the doggo?',
//     isLiked: false,
//     unread: true,
//   ),
//   MessageModel(
//     sender: james,
//     time: '3:15 PM',
//     text: 'All the food',
//     isLiked: true,
//     unread: true,
//   ),
//   MessageModel(
//     sender: currentUser,
//     time: '2:30 PM',
//     text: 'Nice! What kind of food did you eat?',
//     isLiked: false,
//     unread: true,
//   ),
//   MessageModel(
//     sender: james,
//     time: '2:00 PM',
//     text: 'I ate so much food today.',
//     isLiked: false,
//     unread: true,
//   ),
// ];
