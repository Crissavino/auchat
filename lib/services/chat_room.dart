import 'dart:convert';
import 'package:au_chat/models/chat_room_model.dart';
import 'package:au_chat/models/device_message_model.dart';
import 'package:au_chat/models/message_model.dart';
import 'package:au_chat/models/player_model.dart';
import 'package:au_chat/models/user_model.dart';
import 'package:au_chat/utilities/constants.dart';
import 'package:http/http.dart' as http;

class ChatRoomService {
  final String _url = '$NGROK_HTTP/api/chatRooms';

  Future<List<ChatRoomModel>> getAllMyChatRooms(String firebaseId) async {
    final url = '$_url/getAllMyChatRooms?firebaseId=$firebaseId';
    final resp = await http.get(url);
    final Map<String, dynamic> decodedData = json.decode(resp.body);

    if (decodedData == null) return [];
    if (decodedData['error'] != null) return [];

    final chatRoomsFromNode = decodedData['chatRooms'];
    List<ChatRoomModel> chatRooms = List();

    chatRoomsFromNode.forEach((value) {
      final chatRoom = ChatRoomModel.fromJson(value);
      chatRooms.add(chatRoom);
    });
    return chatRooms;
  }

  Future<List<DeviceMessageModel>> getAllChatRoomMessages(
      String chatRoomId, String userId) async {
    final url =
        '$_url/getAllMyChatRoomMessage?userId=$userId&chatRoomId=$chatRoomId';
    final resp = await http.get(url);

    final Map<String, dynamic> decodedData = json.decode(resp.body);

    if (decodedData == null) return [];
    if (decodedData['error'] != null) return [];

    final chatRoomMessagesFromNode = decodedData['deviceMessages'];
    List<DeviceMessageModel> messages = List();
    chatRoomMessagesFromNode.forEach((value) {
      final message = DeviceMessageModel.fromJson(value);
      messages.add(message);
    });

    return messages;
  }

  Future<List<DeviceMessageModel>> newMessage(
      MessageModel message, UserModel user) async {
    final url = '$_url/createMessages?firebaseId=${user.firebaseId}';

    final resp = await http.post(url,
        headers: {"Content-Type": "application/json"},
        body: messageModelToJson(message));

    final Map<String, dynamic> decodedData = json.decode(resp.body);

    if (decodedData == null) return null;
    if (decodedData['success'] != true) return null;

    final myLasDeviceMessageFromNode = decodedData['myLastDeviceMessage'];

    List<DeviceMessageModel> deviceMessages = List();
    myLasDeviceMessageFromNode.forEach((value) {
      final message = DeviceMessageModel.fromJson(value);
      deviceMessages.add(message);
    });

    print(deviceMessages);

    return deviceMessages;
  }

  Future<bool> createChatRoom(UserModel currentUser, String groupName,
      List<UserModel> usersToAddToGroup) async {
    final url = '$_url/create?firebaseId=${currentUser.firebaseId}';

    final data = <String, dynamic>{
      'currentUser': currentUser,
      'groupName': groupName,
      'usersToAddToGroup': usersToAddToGroup,
    };

    final resp = await http.post(url,
        headers: {"Content-Type": "application/json"}, body: json.encode(data));

    final decodedData = json.decode(resp.body);

    if (decodedData['success']) {
      return true;
    } else {
      return false;
    }
  }
}
