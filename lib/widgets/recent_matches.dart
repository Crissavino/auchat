import 'package:au_chat/models/chat_room_model.dart';
import 'package:au_chat/models/user_model.dart';
import 'package:au_chat/screens/chats/chat_room.dart';
import 'package:au_chat/services/chat_room.dart';
import 'package:au_chat/utilities/constants.dart';
import 'package:flutter/material.dart';

class RecentMatches extends StatelessWidget {
  final UserModel user;
  RecentMatches({this.user});

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
          child: _buildChatRoomList(),
        ),
      ),
    );
  }

  FutureBuilder<List<ChatRoomModel>> _buildChatRoomList() {
    return FutureBuilder(
      future: chatRoomService.getAllMyChatRooms(user.firebaseId),
      builder: (context, futureChats) {
        if (futureChats.hasData) {
          final List<ChatRoomModel> chats = futureChats.data;
          return ListView.builder(
            itemCount: chats.length,
            itemBuilder: (BuildContext context, int index) {
              final ChatRoomModel chat = chats[index];
              return _buildChatRoomRow(context, chat);
            },
          );
        } else {
          return Center(
            child: circularLoading,
          );
        }
      },
    );
  }

  GestureDetector _buildChatRoomRow(BuildContext context, ChatRoomModel chat) {
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
      child: Container(
        margin: EdgeInsets.only(top: 5.0, bottom: 2.0, right: 5.0, left: 5.0),
        padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
        decoration: BoxDecoration(
          color: chat.unreadMessages ? Color(0xFFFFEFEE) : Colors.white,
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Row(
              children: <Widget>[
                CircleAvatar(
                  radius: 35.0,
                  backgroundImage: NetworkImage(
                      'https://img2.freepng.es/20180228/grw/kisspng-logo-football-photography-vector-football-5a97847a010f99.3151271415198792900044.jpg'),
                ),
                SizedBox(width: 10.0),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      chat.name,
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 15.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 5.0),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.45,
                      child: Text(
                        (chat.lastMessage != null) ? chat.lastMessage.text : '',
                        style: TextStyle(
                          color: Colors.blueGrey,
                          fontSize: 15.0,
                          fontWeight: FontWeight.w600,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Column(
              children: <Widget>[
                Text(
                  '15:00',
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 15.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 5.0),
                chat.unreadMessages
                    ? Container(
                        width: 40.0,
                        height: 20.0,
                        decoration: BoxDecoration(
                          color: Colors.green[400],
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          'NEW',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 12.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      )
                    : Text(''),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
