import 'dart:ui';

import 'package:au_chat/models/chat_room_model.dart';
import 'package:au_chat/models/user_model.dart';
import 'package:au_chat/screens/chats/chat_room.dart';
import 'package:au_chat/services/chat_room.dart';
import 'package:flutter/material.dart';

class Matches extends StatelessWidget {
  final UserModel user;
  Matches({this.user});

  final ChatRoomService chatRoomService = ChatRoomService();

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30.0),
            topRight: Radius.circular(30.0),
          ),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30.0),
            topRight: Radius.circular(30.0),
          ),
          child: _buildMatchesList(),
        ),
      ),
    );
  }

  FutureBuilder<List<ChatRoomModel>> _buildMatchesList() {
    return FutureBuilder(
      future: chatRoomService.getAllMyChatRooms(user.firebaseId),
      builder: (context, futureChats) {
        if (futureChats.hasData) {
          final List<ChatRoomModel> chats = futureChats.data;
          return ListView.builder(
            itemCount: chats.length,
            itemBuilder: (BuildContext context, int index) {
              final ChatRoomModel chat = chats[index];
              return _buildMatch(context, chat);
            },
          );
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }

  GestureDetector _buildMatch(BuildContext context, ChatRoomModel chat) {
    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => ChatRoom(
            chatRoom: chat,
            currentUser: user,
          ),
        ),
      ),
      child: _botonesRedondeados(),
    );
  }

  Widget _botonesRedondeados() {
    return Table(
      children: [
        TableRow(children: [
          _crearBotonRedondeado(Colors.green, Icons.sports_soccer, 'Partido'),
        ]),
      ],
    );
  }

  Widget _crearBotonRedondeado(Color color, IconData icon, String text) {
    return ClipRRect(
      child: Container(
        height: 180.0,
        margin: EdgeInsets.all(15.0),
        decoration: BoxDecoration(
            color: Colors.green[100].withOpacity(0.7),
            borderRadius: BorderRadius.circular(20.0)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            SizedBox(
              height: 5.0,
            ),
            CircleAvatar(
              radius: 35.0,
              backgroundColor: color,
              child: Icon(icon, color: Colors.white, size: 30.0),
            ),
            Text(text, style: TextStyle(color: color)),
            SizedBox(
              height: 5.0,
            )
          ],
        ),
      ),
    );
  }
}
