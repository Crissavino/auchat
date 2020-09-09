import 'package:au_chat/bloc/user_bloc.dart';
import 'package:au_chat/models/chat_room_model.dart';
import 'package:au_chat/models/user_model.dart';
import 'package:au_chat/screens/chats/add_participants.dart';
import 'package:au_chat/services/node.dart';
import 'package:au_chat/widgets/player_row.dart';
import 'package:flutter/material.dart';

class SearchPlayerWidget extends StatefulWidget {
  List<UserModel> users;
  UserModel currentUser;
  ChatRoomModel chatRooom;
  String search;
  UserBloc userBloc;
  SearchPlayerWidget({
    Key key,
    this.users,
    this.currentUser,
    this.chatRooom,
    this.search,
    this.userBloc,
  }) : super(key: key);

  @override
  _SearchPlayerWidgetState createState() => _SearchPlayerWidgetState();
}

class _SearchPlayerWidgetState extends State<SearchPlayerWidget> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<Object>(
        stream: widget.userBloc.usersStream,
        builder: (context, usersStreamSnapshot) {
          List<UserModel> usersStream = List();
          if (usersStreamSnapshot.hasData) {
            usersStream = usersStreamSnapshot.data;
          }
          return FutureBuilder(
            future: NodeService().getAllUsers(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (!snapshot.hasData) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              List userResults;
              final term = widget.search.toLowerCase();
              if (term != '') {
                userResults = snapshot.data
                    .where((UserModel user) =>
                        user.fullName.toLowerCase().contains(term))
                    .toList();
              } else {
                userResults = snapshot.data;
              }
              return ListView.builder(
                itemCount: userResults.length,
                itemBuilder: (BuildContext context, int index) {
                  UserModel user = userResults[index];
                  bool isAlreadyHere;
                  if (widget.chatRooom != null) {
                    isAlreadyHere =
                        user.chatRooms.contains(widget.chatRooom.id);
                  } else {
                    if (usersStream != null) {
                      isAlreadyHere = usersStream
                          .where((UserModel userStream) =>
                              userStream.firebaseId == user.firebaseId)
                          .isNotEmpty;
                    } else {
                      isAlreadyHere = false;
                    }
                  }
                  // return _buildPlayerRow(user, isAlreadyHere);
                  if (user.firebaseId != widget.currentUser.firebaseId) {
                    return PlayerRow(
                      user: user,
                      isAlreadyHere: isAlreadyHere,
                      userBloc: userBloc,
                    );
                  } else {
                    return Container();
                  }
                },
              );
            },
          );
        });
  }

  FutureBuilder _buildPlayersList() {
    return FutureBuilder(
      future: NodeService().getAllUsers(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        List userResults;
        final term = widget.search.toLowerCase();
        if (term != '') {
          userResults = snapshot.data
              .where((UserModel user) =>
                  user.fullName.toLowerCase().contains(term))
              .toList();
        } else {
          userResults = snapshot.data;
        }
        return ListView.builder(
          itemCount: userResults.length,
          itemBuilder: (BuildContext context, int index) {
            UserModel user = userResults[index];
            bool isAlreadyHere;
            if (widget.chatRooom != null) {
              isAlreadyHere = user.chatRooms.contains(widget.chatRooom.id);
            } else {
              isAlreadyHere = false;
            }
            // return _buildPlayerRow(user, isAlreadyHere);
            return PlayerRow(
              user: user,
              isAlreadyHere: isAlreadyHere,
            );
          },
        );
      },
    );
  }

  Container _buildPlayerRow(UserModel user, bool isAlreadyHere) {
    return Container(
      margin: EdgeInsets.only(top: 10.0, bottom: 2.0, right: 10.0, left: 10.0),
      padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
      decoration: BoxDecoration(
        color: Color(0xFFFFEFEE),
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          CircleAvatar(
            radius: 35.0,
            backgroundImage: NetworkImage(
              // user.imageUrl
              'https://img2.freepng.es/20180228/grw/kisspng-logo-football-photography-vector-football-5a97847a010f99.3151271415198792900044.jpg',
            ),
          ),
          Text(
            user.fullName,
            style: TextStyle(
              color: Colors.grey,
              fontSize: 15.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          IconButton(
            icon: isAlreadyHere
                ? Icon(Icons.check)
                : Icon(Icons.add_circle_outline),
            iconSize: 30.0,
            color: Colors.green[400],
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}
