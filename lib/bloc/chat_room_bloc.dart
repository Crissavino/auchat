import 'dart:async';
import 'package:au_chat/models/chat_room_model.dart';
import 'package:au_chat/models/user_model.dart';
import 'package:au_chat/providers/chat_room_provider.dart';

class ChatRoomBloc {
  static ChatRoomBloc _singleton = ChatRoomBloc._internal();
  ChatRoomPrivider _chatRoomPrivider = ChatRoomPrivider();

  factory ChatRoomBloc() {
    if (_singleton == null) {
      _singleton = ChatRoomBloc._internal();
    }

    return _singleton;
  }

  ChatRoomBloc._internal();

  final _chatRoomController = StreamController<List<ChatRoomModel>>.broadcast();

  Stream<List<ChatRoomModel>> get chatRoomStream => _chatRoomController.stream;

  dispose() {
    _chatRoomController?.close();
  }

  void removePlayerFromGroup(UserModel user, String chatRoomId) {
    _chatRoomPrivider.removePlayerFromGroup(user, chatRoomId);
  }

  void addPlayerToGroup(UserModel user, String chatRoomId) {
    _chatRoomPrivider.addPlayerToGroup(user, chatRoomId);
  }
}
