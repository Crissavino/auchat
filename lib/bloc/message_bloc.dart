import 'dart:async';
import 'package:au_chat/models/chat_room_model.dart';
import 'package:au_chat/models/device_message_model.dart';
import 'package:au_chat/models/message_model.dart';
import 'package:au_chat/models/user_model.dart';
import 'package:au_chat/services/chat_room.dart';
import 'package:au_chat/services/node.dart';

class MessageBloc {
  final UserModel user;
  final ChatRoomModel chatRoom;
  MessageBloc({this.user, this.chatRoom});

  // static final MessageBloc _singleton;

  // factory MessageBloc() {
  // if (_singleton == null) {
  //   _singleton = MessageBloc._internal(
  //     user: user,
  //     chatRoom: chatRoom,
  //   );
  // }

  // return _singleton;
  // }

  // MessageBloc._internal({this.user, this.chatRoom})
  //     : super(user: user, chatRoom: chatRoom);

  // MessageBloc._internal(ChatRoomModel chatRoom, UserModel user) {
  //   getMessages(chatRoom.id, user.id);
  // }

  final _messageController =
      StreamController<List<DeviceMessageModel>>.broadcast();

  Stream<List<DeviceMessageModel>> get messageStream =>
      _messageController.stream;

  final _chatRoomController = StreamController<List<ChatRoomModel>>.broadcast();

  Stream<List<ChatRoomModel>> get chatRoomStream => _chatRoomController.stream;

  dispose() {
    _messageController?.close();
    _chatRoomController?.close();
  }

  getMessages(String chatRoomId, String firebaseId) async {
    UserModel user = await NodeService().getUserByFirebaseId(firebaseId);
    final messages =
        await ChatRoomService().getAllChatRoomMessages(chatRoomId, user.id);

    _messageController.sink.add(messages);
  }

  getAllMyChatRooms(String firebaseId) async {
    final chatRooms = await ChatRoomService().getAllMyChatRooms(firebaseId);

    _chatRoomController.sink.add(chatRooms);
  }

  addMessage(MessageModel message, String firebaseId) async {
    await ChatRoomService().newMessage(message, user);
    getMessages(message.chatRoom.id, firebaseId);
  }
}
