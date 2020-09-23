import 'package:au_chat/models/chat_room_model.dart';
import 'package:au_chat/utilities/constants.dart';
import 'package:flutter/material.dart';

class InfoChat extends StatefulWidget {
  final ChatRoomModel chatRoom;

  InfoChat({this.chatRoom});

  @override
  _InfoChatState createState() => _InfoChatState();
}

class _InfoChatState extends State<InfoChat> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: horizontalGradient,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        // backgroundColor: Theme.of(context).primaryColor,
        appBar: AppBar(
            title: Text(
              widget.chatRoom.name,
              style: TextStyle(
                fontSize: 28.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            elevation: 0.0,
            flexibleSpace: Container(
              decoration: horizontalGradient,
            )),
        body: Column(
          children: <Widget>[
            Expanded(
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: screenBorders,
                ),
                child: ClipRRect(
                  borderRadius: screenBorders,
                  child: Text('Info del grupo'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
