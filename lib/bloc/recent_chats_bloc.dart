import 'dart:async';
import 'package:au_chat/models/chat_room_model.dart';
import 'package:au_chat/models/message_model.dart';
import 'package:au_chat/models/user_model.dart';
import 'package:au_chat/services/chat_room.dart';
import 'package:au_chat/services/node.dart';

class RecentChatBloc {
  final UserModel user;
  RecentChatBloc({this.user});

  final _chatRoomController = StreamController<List<ChatRoomModel>>.broadcast();

  Stream<List<ChatRoomModel>> get chatRoomStream => _chatRoomController.stream;

  dispose() {
    _chatRoomController?.close();
  }

  getAllMyChatRooms(String firebaseId) async {
    final chatRooms = await ChatRoomService().getAllMyChatRooms(firebaseId);
    _chatRoomController.sink.add(chatRooms);
  }
}
