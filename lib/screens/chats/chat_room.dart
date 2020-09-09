import 'package:au_chat/bloc/message_bloc.dart';
import 'package:au_chat/models/chat_room_model.dart';
import 'package:au_chat/models/device_message_model.dart';
import 'package:au_chat/models/message_model.dart';
import 'package:au_chat/models/user_model.dart';
import 'package:au_chat/screens/chats/search_player.dart';
import 'package:au_chat/utilities/constants.dart';
import 'package:flutter/material.dart';

class ChatRoom extends StatefulWidget {
  final ChatRoomModel chatRoom;
  final UserModel currentUser;

  ChatRoom({this.chatRoom, this.currentUser});

  @override
  _ChatRoomState createState() => _ChatRoomState();
}

class _ChatRoomState extends State<ChatRoom> {
  String textMessage;
  final _textController = TextEditingController();

  @override
  void initState() {
    super.initState();

    _textController.addListener(_getLatestValue);
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is removed from the
    // widget tree.
    _textController.dispose();
    super.dispose();
  }

  _getLatestValue() {
    setState(() {
      textMessage = _textController.text;
    });
  }

  _buildMessage(dynamic message, bool isMe) {
    final Container msg = Container(
      margin: isMe
          ? EdgeInsets.only(
              top: 8.0,
              bottom: 8.0,
              left: 50.0,
            )
          : EdgeInsets.only(
              top: 8.0,
              bottom: 8.0,
            ),
      padding: EdgeInsets.symmetric(horizontal: 25.0, vertical: 15.0),
      width: MediaQuery.of(context).size.width * 0.85,
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: isMe
            ? BorderRadius.only(
                topLeft: Radius.circular(15.0),
                bottomLeft: Radius.circular(15.0),
              )
            : BorderRadius.only(
                topRight: Radius.circular(15.0),
                bottomRight: Radius.circular(15.0),
              ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                message.sender['fullName'],
                // message.time.toString(),
                style: TextStyle(
                  color: Colors.blueGrey,
                  fontSize: 16.0,
                  fontWeight: FontWeight.w600,
                ),
                overflow: TextOverflow.ellipsis,
              ),
              Text(
                '10:26',
                // message.time.toString(),
                style: TextStyle(
                  color: Colors.blueGrey,
                  fontSize: 16.0,
                  fontWeight: FontWeight.w600,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
          SizedBox(height: 8.0),
          Text(
            message.text,
            style: TextStyle(
              color: Colors.blueGrey,
              fontSize: 16.0,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
    if (isMe) {
      return msg;
    }
    return Row(
      children: <Widget>[msg],
    );
  }

  _buildMessageComposer(MessageBloc messageBloc) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.0),
      height: 70.0,
      color: Colors.white,
      child: Row(
        children: <Widget>[
          // IconButton(
          //   icon: Icon(Icons.photo),
          //   iconSize: 25.0,
          //   color: Colors.green[400],
          //   onPressed: () {},
          // ),
          SizedBox(
            width: 25.0,
          ),
          Expanded(
            child: TextField(
              controller: _textController,
              textCapitalization: TextCapitalization.sentences,
              decoration: InputDecoration.collapsed(
                hintText: 'Send a message...',
              ),
            ),
          ),
          IconButton(
            icon: Icon(Icons.send),
            iconSize: 25.0,
            color: Colors.green[400],
            onPressed: () {
              if (textMessage != null || textMessage.isNotEmpty) {
                final message = MessageModel();
                message.sender = widget.currentUser;
                message.time = DateTime.now().toIso8601String();
                message.text = textMessage;
                message.isLiked = false;
                message.unread = false;
                message.language = 'es';
                message.chatRoom = widget.chatRoom;

                messageBloc.addMessage(message, widget.currentUser.firebaseId);

                _textController.clear();
              }
            },
          ),
        ],
      ),
    );
  }

  void choiceAction(String choice) async {
    if (choice == ADD_PLAYER) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => SearchPlayer(chatRooom: widget.chatRoom),
        ),
      ).then((val) async {
        setState(() {});
      });
    } else if (choice == CREATE_GAME) {
      print('Tocaste create partido');
    } else if (choice == LEAVE_GROUP) {
      print('Tocaste irte?');
    }
  }

  @override
  Widget build(BuildContext context) {
    final messageBloc =
        MessageBloc(user: widget.currentUser, chatRoom: widget.chatRoom);
    messageBloc.getMessages(widget.chatRoom.id, widget.currentUser.firebaseId);

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
          ),
          actions: <Widget>[
            PopupMenuButton<String>(
              onSelected: choiceAction,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              icon: Icon(Icons.more_horiz),
              padding: EdgeInsets.only(
                right: 10.0,
              ),
              itemBuilder: (BuildContext context) {
                return chatRoomMenuChoices.map((String choice) {
                  return PopupMenuItem(
                    value: choice,
                    child: Text(choice),
                  );
                }).toList();
              },
            ),
          ],
        ),
        body: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Column(
            children: <Widget>[
              Expanded(
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
                    child: StreamBuilder(
                      stream: messageBloc.messageStream,
                      initialData: widget.chatRoom.messages,
                      builder: (BuildContext context, AsyncSnapshot snapshot) {
                        if (!snapshot.hasData) {
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        }

                        final messages = snapshot.data;

                        if (messages.length == 0) {
                          return Center(
                            child: Text(''),
                          );
                        }

                        return ListView.builder(
                          reverse: true,
                          padding: EdgeInsets.only(top: 15.0),
                          // itemCount: messages.length,
                          itemCount: messages.length,
                          itemBuilder: (BuildContext context, int index) {
                            if (!(messages[index] is String)) {
                              final DeviceMessageModel message =
                                  messages[index];

                              final bool isMe = message.sender['firebaseId'] ==
                                  widget.currentUser.firebaseId;
                              return _buildMessage(message, isMe);
                            } else {
                              return Center(
                                child: Text(''),
                              );
                            }
                          },
                        );
                      },
                    ),
                  ),
                ),
              ),
              _buildMessageComposer(messageBloc),
            ],
          ),
        ),
      ),
    );
  }
}
