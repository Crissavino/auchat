import 'package:au_chat/bloc/user_bloc.dart';
import 'package:au_chat/models/chat_room_model.dart';
import 'package:au_chat/models/user_model.dart';
import 'package:au_chat/utilities/constants.dart';
import 'package:au_chat/widgets/search_player.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class SearchPlayer extends StatefulWidget {
  ChatRoomModel chatRooom;
  UserModel currentUser;
  SearchPlayer({
    Key key,
    this.chatRooom,
    this.currentUser,
  }) : super(key: key);

  @override
  _SearchPlayerState createState() => _SearchPlayerState();
}

class _SearchPlayerState extends State<SearchPlayer> {
  dynamic search = '';
  UserBloc userBloc;
  List<UserModel> users;

  @override
  void initState() {
    super.initState();
    userBloc = UserBloc();
  }

  Widget _buildSearchTF() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(left: 50.0, right: 25.0),
          child: Container(
            margin: EdgeInsets.only(top: 40.0),
            decoration: BoxDecoration(
              color: Colors.grey[100],
              borderRadius: BorderRadius.circular(20.0),
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 6.0,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            height: 30.0,
            child: TextFormField(
              keyboardType: TextInputType.text,
              style: TextStyle(
                color: Colors.grey[700],
                fontFamily: 'OpenSans',
              ),
              decoration: InputDecoration(
                border: InputBorder.none,
                contentPadding: EdgeInsets.only(top: -3),
                prefixIcon: Icon(
                  Icons.search,
                  color: Colors.grey,
                ),
                hintText: 'Search',
                hintStyle: kHintTextStyle,
              ),
              onChanged: (val) {
                setState(() {
                  search = val;
                });
              },
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: horizontalGradient,
      child: Scaffold(
        appBar: AppBar(
          elevation: 0.0,
          flexibleSpace: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: [
                  Colors.green[400],
                  Colors.green[500],
                  Colors.green[600],
                  Colors.green[700],
                ],
                stops: [0.1, 0.4, 0.7, 0.9],
              ),
            ),
            child: _buildSearchTF(),
          ),
        ),
        body: Container(
            decoration: horizontalGradient,
            child: SafeArea(
              bottom: false,
              child: Column(
                children: [
                  Expanded(
                    child: Container(
                      width: double.infinity,
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
                        child: SearchPlayerWidget(
                          chatRooom: widget.chatRooom,
                          search: search,
                          currentUser: widget.currentUser,
                          userBloc: userBloc,
                          addPlayerToGroup: true,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            )),
      ),
    );
  }
}
