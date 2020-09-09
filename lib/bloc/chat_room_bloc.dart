import 'dart:async';
import 'package:au_chat/models/chat_room_model.dart';

class ChatRoomBloc {
  static ChatRoomBloc _singleton = ChatRoomBloc._internal();

  factory ChatRoomBloc() {
    if (_singleton == null) {
      _singleton = ChatRoomBloc._internal();
    }

    return _singleton;
  }

  ChatRoomBloc._internal() {}

  final _chatRoomController = StreamController<List<ChatRoomModel>>.broadcast();

  Stream<List<ChatRoomModel>> get chatRoomStream => _chatRoomController.stream;

  dispose() {
    _chatRoomController?.close();
  }
}
