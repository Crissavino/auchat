import 'package:au_chat/bloc/user_bloc.dart';
import 'package:au_chat/models/user_model.dart';
import 'package:au_chat/screens/chats/create_chat_room.dart';
import 'package:au_chat/utilities/constants.dart';
import 'package:au_chat/widgets/search_player.dart';
import 'package:flutter/material.dart';

UserBloc userBloc = UserBloc();

class AddParticipants extends StatefulWidget {
  final UserModel currentUser;
  AddParticipants({this.currentUser});

  @override
  _AddParticipantsState createState() => _AddParticipantsState();
}

class _AddParticipantsState extends State<AddParticipants> {
  // final bool thereAreParticipants = false;

  @override
  void dispose() {
    userBloc.clearStream();
    super.dispose();
  }

  dynamic search = '';
  Widget _buildSearchTF() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(left: 25.0, right: 25.0),
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
    return Scaffold(
        appBar: AppBar(
          title: Text(
            ADD_PARTICIPANTS,
            style: TextStyle(
              fontSize: 24.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          elevation: 0.0,
          flexibleSpace: Container(
            decoration: horizontalGradient,
          ),
          actions: [
            StreamBuilder<Object>(
                stream: userBloc.usersStream,
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return IconButton(
                      icon: Icon(Icons.arrow_forward_ios),
                      color: Colors.white,
                      onPressed: null,
                    );
                  }
                  List usersToAdd = snapshot.data;
                  return IconButton(
                    icon: Icon(Icons.arrow_forward_ios),
                    color: Colors.white,
                    onPressed: usersToAdd.isEmpty
                        ? null
                        : () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => CreateChatRoom(
                                    currentUser: widget.currentUser,
                                    usersToAddToGroup: usersToAdd,
                                    userBloc: userBloc),
                              ),
                            ).then((val) async {
                              setState(() {});
                            });
                          },
                  );
                }),
          ],
        ),
        body: Container(
          decoration: horizontalGradient,
          child: SafeArea(
            bottom: false,
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.only(
                    bottom: 20.0,
                  ),
                  child: _buildSearchTF(),
                ),
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
                        currentUser: widget.currentUser,
                        search: search,
                        userBloc: userBloc,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
