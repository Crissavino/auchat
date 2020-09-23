import 'package:au_chat/bloc/user_bloc.dart';
import 'package:au_chat/models/chat_room_model.dart';
import 'package:au_chat/models/user_model.dart';
import 'package:au_chat/screens/chats/add_participants.dart';
import 'package:au_chat/services/node.dart';
import 'package:au_chat/widgets/player_row.dart';
import 'package:flutter/material.dart';

class SearchPlayerWidget extends StatefulWidget {
  UserModel currentUser;
  ChatRoomModel chatRooom;
  String search;
  UserBloc userBloc;
  bool addPlayerToGroup;
  bool addPlayerToMatch;
  bool addPlayerToNewGroup;
  bool addPlayerToNewMatch;
  SearchPlayerWidget({
    Key key,
    this.currentUser,
    this.chatRooom,
    this.search,
    this.userBloc,
    this.addPlayerToGroup,
    this.addPlayerToMatch,
    this.addPlayerToNewGroup,
    this.addPlayerToNewMatch,
  }) : super(key: key);

  @override
  _SearchPlayerWidgetState createState() => _SearchPlayerWidgetState();
}

class _SearchPlayerWidgetState extends State<SearchPlayerWidget> {
  @override
  void initState() {
    super.initState();
    // if (widget.showIntegrants == null) {
    //   setState(() {
    //     widget.showIntegrants = true;
    //   });
    // }
  }

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
                userResults = snapshot.data; //yaMm5UfczSVvFZO5u0MkowfRpKh2
              }
              return ListView.builder(
                itemCount: userResults.length,
                itemBuilder: (BuildContext context, int index) {
                  UserModel user = userResults[index];
                  bool isAlreadyHere;
                  if (widget.chatRooom != null) {
                    isAlreadyHere =
                        user.chatRooms.contains(widget.chatRooom.id);
                  } else if (usersStream != null) {
                    isAlreadyHere = usersStream
                        .where((UserModel userStream) =>
                            userStream.firebaseId == user.firebaseId)
                        .isNotEmpty;
                  } else {
                    isAlreadyHere = false;
                  }
                  // return _buildPlayerRow(user, isAlreadyHere);
                  // final addToNewGroup = true;
                  if (widget.addPlayerToNewGroup == true) {
                    return _buildAddToNewGroup(user, isAlreadyHere);
                  } else if (widget.addPlayerToGroup == true) {
                    return _buildAddToGroup(user, isAlreadyHere);
                  } else {
                    return Container();
                  }
                  // (user.firebaseId != widget.currentUser.firebaseId &&
                  // (!widget.showIntegrants && !isAlreadyHere))
                },
              );
            },
          );
        });
  }

  Widget _buildAddToNewGroup(user, isAlreadyHere) {
    if (user.firebaseId != widget.currentUser.firebaseId) {
      return PlayerRow(
        user: user,
        isAlreadyHere: isAlreadyHere,
        userBloc: userBloc,
        addPlayerToNewGroup: true,
      );
    } else {
      return Container();
    }
  }

  Widget _buildAddToGroup(user, isAlreadyHere) {
    if (user.firebaseId != widget.currentUser.firebaseId && !isAlreadyHere) {
      return PlayerRow(
        user: user,
        isAlreadyHere: isAlreadyHere,
        userBloc: userBloc,
        addPlayerToGroup: true,
        chatRoom: widget.chatRooom,
      );
    } else {
      return Container();
    }
  }
}
