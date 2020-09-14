import 'package:au_chat/bloc/message_bloc.dart';
import 'package:au_chat/models/chat_room_model.dart';
import 'package:au_chat/models/device_message_model.dart';
import 'package:au_chat/models/user_model.dart';
import 'package:au_chat/screens/chats/chat_room.dart';
import 'package:au_chat/services/chat_room.dart';
import 'package:au_chat/utilities/slide_bottom_route.dart';
import 'package:flutter/material.dart';

class RecentChats extends StatefulWidget {
  final UserModel user;
  RecentChats({this.user});

  @override
  _RecentChatsState createState() => _RecentChatsState();
}

class _RecentChatsState extends State<RecentChats> {
  final ChatRoomService chatRoomService = ChatRoomService();
  MessageBloc messageBloc = MessageBloc();

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

  _buildChatRoomList() {
    return FutureBuilder(
      future: chatRoomService.getAllMyChatRooms(widget.user.firebaseId),
      builder: (BuildContext context, AsyncSnapshot futureChats) {
        if (futureChats.hasData) {
          final List<ChatRoomModel> chats = futureChats.data;
          return StreamBuilder(
            stream: messageBloc.chatRoomStream,
            initialData: chats,
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              return ListView.builder(
                itemCount: (snapshot.data != null) ? snapshot.data.length : 0,
                itemBuilder: (BuildContext context, int index) {
                  final ChatRoomModel chat = chats[index];
                  return _buildChatRoomRow(context, chat);
                },
              );
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

  GestureDetector _buildChatRoomRow(BuildContext context, ChatRoomModel chat) {
    return GestureDetector(
      onTap: () async {
        final List<DeviceMessageModel> allMyChatRoomMessage =
            await chatRoomService.getAllChatRoomMessages(
                chat.id, widget.user.id);

        Navigator.push(
          context,
          SlideBottomRoute(
            page: ChatRoom(
              chatRoom: chat,
              currentUser: widget.user,
              allMyChatRoomMessages: allMyChatRoomMessage,
            ),
          ),
        ).then(
          (val) async {
            setState(() {});
          },
        );
      },
      child: Container(
        margin:
            EdgeInsets.only(top: 10.0, bottom: 2.0, right: 10.0, left: 10.0),
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
                        (chat.lastMessage != null)
                            ? chat.lastMessage['text']
                            : '',
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
