import 'package:au_chat/bloc/message_bloc.dart';
import 'package:au_chat/models/chat_room_model.dart';
import 'package:au_chat/models/device_message_model.dart';
import 'package:au_chat/models/message_model.dart';
import 'package:au_chat/models/user_model.dart';
import 'package:au_chat/screens/chats/search_player.dart';
import 'package:au_chat/services/chat_room.dart';
import 'package:au_chat/utilities/constants.dart';
import 'package:au_chat/widgets/fade_in_message.dart';
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
  final TextEditingController _textController = TextEditingController();
  final MessageBloc messageBloc = MessageBloc();
  final ScrollController listScrollController = ScrollController();

  /// Will used to access the Animated list
  final GlobalKey<AnimatedListState> listKey = GlobalKey<AnimatedListState>();

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

  _buildMessageComposer() {
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
              bool blank = textMessage?.trim()?.isEmpty ?? true;
              if (!blank) {
                final message = MessageModel();
                message.sender = widget.currentUser;
                message.time = DateTime.now().toIso8601String();
                message.text = textMessage;
                message.isLiked = false;
                message.unread = false;
                message.language = 'es';
                message.chatRoom = widget.chatRoom;

                messageBloc.addMessage(message, widget.currentUser);
                if (listScrollController.hasClients) {
                  listScrollController.animateTo(
                    0.0,
                    duration: Duration(seconds: 5),
                    curve: Curves.easeIn,
                  );
                }

                _textController.clear();
              } else {
                // Fluttertoast.showToast(msg: 'Nothing to send');
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
            _buildPopupMenu(),
          ],
        ),
        body: Column(
          children: <Widget>[
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: screenBorders,
                ),
                child: ClipRRect(
                  borderRadius: screenBorders,
                  child: _buildStreamBuilder(),
                ),
              ),
            ),
            _buildMessageComposer(),
          ],
        ),
      ),
    );
  }

  Widget _buildStreamBuilder() {
    return StreamBuilder(
        stream: messageBloc.getMessagesStream(
            widget.chatRoom.id, widget.currentUser),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          print(snapshot.hasData);

          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.green[400]),
              ),
            );
          } else {
            return GestureDetector(
              onTap: () => FocusScope.of(context).unfocus(),
              child: ListView.builder(
                reverse: true,
                padding: EdgeInsets.only(top: 15.0),
                itemCount: snapshot.data.length,
                controller: listScrollController,
                itemBuilder: (BuildContext context, int index) =>
                    _buildItem(index, (snapshot.data[index])),
              ),
            );
          }
        });

    return FutureBuilder(
      future: ChatRoomService()
          .getAllChatRoomMessages(widget.chatRoom.id, widget.currentUser.id),
      builder: (BuildContext context, AsyncSnapshot futureMessage) {
        if (!futureMessage.hasData) {
          return Center(
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.green[400]),
            ),
          );
        } else {
          print('snapshot.data ${futureMessage.data.length}');
          final messages = futureMessage.data;

          return StreamBuilder(
            stream: messageBloc.messageStream,
            initialData: messages,
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              print('snapshot.data ${snapshot.data.length}');
              return GestureDetector(
                onTap: () => FocusScope.of(context).unfocus(),
                child: ListView.builder(
                  reverse: true,
                  padding: EdgeInsets.only(top: 15.0),
                  itemCount: snapshot.data.length,
                  controller: listScrollController,
                  itemBuilder: (BuildContext context, int index) =>
                      _buildItem(index, (snapshot.data[index])),
                ),
              );
            },
          );
        }
      },
    );
  }

  Widget _buildStreamBuilder2() {
    return FutureBuilder(
      future: ChatRoomService()
          .getAllChatRoomMessages(widget.chatRoom.id, widget.currentUser.id),
      builder: (BuildContext context, AsyncSnapshot futureMessage) {
        if (!futureMessage.hasData) {
          return Center(
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.green[400]),
            ),
          );
        } else {
          print('snapshot.data ${futureMessage.data.length}');
          final messages = futureMessage.data;

          return StreamBuilder(
            stream: messageBloc.messageStream,
            initialData: messages,
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              print('snapshot.data ${snapshot.data.length}');
              return GestureDetector(
                onTap: () => FocusScope.of(context).unfocus(),
                child: ListView.builder(
                  reverse: true,
                  padding: EdgeInsets.only(top: 15.0),
                  itemCount: snapshot.data.length,
                  controller: listScrollController,
                  itemBuilder: (BuildContext context, int index) =>
                      _buildItem(index, (snapshot.data[index])),
                ),
              );
            },
          );
        }
      },
    );
  }

  _buildItem(int index, message, {ScrollController controller}) {
    if (!(message is String)) {
      final bool isMe =
          message.sender['firebaseId'] == widget.currentUser.firebaseId;
      return _buildMessage(message, isMe);
      // return FadeInMessage(0.5, _buildMessage(message, isMe));
    } else {
      return Center(
        child: Text(''),
      );
    }
  }

  PopupMenuButton<String> _buildPopupMenu() {
    return PopupMenuButton<String>(
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
    );
  }
}
