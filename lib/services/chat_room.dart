import 'dart:convert';
import 'package:au_chat/models/chat_room_model.dart';
import 'package:au_chat/models/message_model.dart';
import 'package:au_chat/screens/chats/chat_room.dart';
import 'package:http/http.dart' as http;

class ChatRoomService {
  final String _url = 'http://localhost:4000/api/chatRooms';

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

    // decodedData.forEach((id, product) {
    //   final prodTemp = ProductModel.fromJson(product);
    //   prodTemp.id = id;

    //   products.add(prodTemp);
    // });

    // return products;
  }
}
