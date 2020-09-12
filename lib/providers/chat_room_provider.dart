import 'dart:convert';
import 'package:au_chat/models/chat_room_model.dart';
import 'package:au_chat/utilities/constants.dart';
import 'package:http/http.dart' as http;

class ChatRoomPrivider {
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
}
