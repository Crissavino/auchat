import 'dart:convert';
import 'package:au_chat/models/chat_room_model.dart';
import 'package:au_chat/models/user_model.dart';
import 'package:au_chat/utilities/constants.dart';
import 'package:http/http.dart' as http;

class ChatRoomPrivider {
  final String _url = '$NGROK_HTTP/api/chatRooms';
  String _apiKey = 'cdf773c21cdd290fabe0618a20e4f181';

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

  Future<bool> removePlayerFromGroup(UserModel user, String chatRoomId) async {
    final url = '$_url/removeFromChatRoom?apiKey=$_apiKey';

    final data = <String, dynamic>{
      'userToRemove': user,
      'chatRoomId': chatRoomId
    };

    final resp = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: json.encode(data),
    );

    final decodedData = json.decode(resp.body);

    if (decodedData['success'] != true) return false;

    return true;
  }

  Future<bool> addPlayerToGroup(UserModel user, String chatRoomId) async {
    final url = '$_url/addToChatRoom?apiKey=$_apiKey';

    final data = <String, dynamic>{'userToAdd': user, 'chatRoomId': chatRoomId};

    print(json.encode(data));

    final resp = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: json.encode(data),
    );

    final decodedData = json.decode(resp.body);

    if (decodedData['success'] != true) return false;

    return true;
  }
}
