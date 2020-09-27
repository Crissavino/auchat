import 'dart:async';
import 'dart:math';
import 'package:au_chat/models/chat_room_model.dart';
import 'package:au_chat/models/device_message_model.dart';
import 'package:au_chat/models/message_model.dart';
import 'package:au_chat/models/user_model.dart';
import 'package:au_chat/providers/message_provider.dart';
import 'package:au_chat/services/chat_room.dart';

class MessageBloc {
  static MessageBloc _singleton;

  factory MessageBloc() {
    if (_singleton == null) {
      _singleton = MessageBloc._internal();
    }

    return _singleton;
  }

  MessageBloc._internal();

  final _messageController =
      StreamController<List<DeviceMessageModel>>.broadcast();

  final _randomController = StreamController<double>.broadcast();

  Stream<List<DeviceMessageModel>> get messageStream =>
      _messageController.stream;

  Stream<List<DeviceMessageModel>> getMessagesStream(
      String chatRoomId, UserModel currentUser) async* {
    final messages = await ChatRoomService()
        .getAllChatRoomMessages(chatRoomId, currentUser.id);
    yield messages;
  }

  Stream<double> getRandomValues() async* {
    var random = Random(2);
    while (true) {
      await Future.delayed(Duration(seconds: 1));
      // yield random.nextDouble();
      _randomController.add(random.nextDouble());
    }
  }

  // final _messageController = StreamController<DeviceMessageModel>.broadcast();

  // Stream<DeviceMessageModel> get messageStream => _messageController.stream;

  final _chatRoomController = StreamController<List<ChatRoomModel>>.broadcast();

  Stream<List<ChatRoomModel>> get chatRoomStream => _chatRoomController.stream;

  dispose() {
    _messageController?.close();
    _chatRoomController?.close();
  }

  getMessages(String chatRoomId, UserModel currentUser) async {
    final messages = await ChatRoomService()
        .getAllChatRoomMessages(chatRoomId, currentUser.id);

    _messageController.sink.add(messages);
  }

  getAllMyChatRooms(String firebaseId) async {
    final chatRooms = await ChatRoomService().getAllMyChatRooms(firebaseId);

    _chatRoomController.sink.add(chatRooms);
  }

  addMessage(MessageModel message, UserModel currentUser) async {
    await MessageProvider().newMessage(message, currentUser);
    // getMessagesStream(message.chatRoom.id, currentUser);
    await getMessages(message.chatRoom.id, currentUser);
    // getAllMyChatRooms(currentUser.firebaseId);
  }
}
