import 'package:au_chat/bloc/user_bloc.dart';
import 'package:au_chat/models/user_model.dart';
import 'package:au_chat/screens/chats/chats.dart';
import 'package:au_chat/services/chat_room.dart';
import 'package:au_chat/utilities/constants.dart';
import 'package:au_chat/widgets/grid_view_players.dart';
import 'package:flutter/material.dart';

class CreateChatRoom extends StatefulWidget {
  final UserModel currentUser;
  final List<UserModel> usersToAddToGroup;
  final UserBloc userBloc;
  CreateChatRoom({this.currentUser, this.usersToAddToGroup, this.userBloc});

  @override
  _CreateChatRoomState createState() => _CreateChatRoomState();
}

class _CreateChatRoomState extends State<CreateChatRoom> {
  final _formKey = GlobalKey<FormState>();
  String error = '';
  String groupName = '';

  Widget _buildGroupNameTF() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          GROUP_NAME,
          style: kLabelStyle,
        ),
        SizedBox(height: 10.0),
        Container(
          padding: EdgeInsets.only(left: 30.0),
          alignment: Alignment.centerLeft,
          decoration: kBoxDecorationStyle,
          height: 60.0,
          child: TextFormField(
            keyboardType: TextInputType.text,
            style: TextStyle(
              color: Colors.grey[700],
              fontFamily: 'OpenSans',
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 14.0),
              hintText: GROUP_NAME,
              hintStyle: kHintTextStyle,
            ),
            validator: (val) => val.isEmpty ? ENTER_A_NAME : null,
            onChanged: (val) {
              setState(() => groupName = val);
            },
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
            CREATE_GROUP,
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
                stream: widget.userBloc.usersStream,
                builder: (context, snapshot) {
                  bool allUsersDeleted = false;
                  if (snapshot.hasData) {
                    List<UserModel> usersStream = snapshot.data;
                    if (usersStream.isEmpty) {
                      allUsersDeleted = true;
                    }
                  }
                  return Container(
                    padding: EdgeInsets.only(right: 20.0),
                    child: Center(
                      child: GestureDetector(
                        child: Text(
                          CREATE,
                          style: TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        onTap: () async {
                          if (_formKey.currentState.validate() &&
                              !allUsersDeleted) {
                            bool result = await ChatRoomService()
                                .createChatRoom(widget.currentUser, groupName,
                                    widget.usersToAddToGroup);
                            if (result) {
                              Navigator.of(context)
                                  .pushAndRemoveUntil(
                                      MaterialPageRoute(
                                        builder: (_) => Chats(
                                          user: widget.currentUser,
                                        ),
                                      ),
                                      (route) => false)
                                  .then((val) async {
                                setState(() {});
                              });
                            } else {
                              print('mostrar error');
                            }
                            // if (result == null) {
                            //   setState(() {
                            //     loading = false;
                            //     error =
                            //         'Could not sign in with those credentials';
                            //   });
                            // }
                          }
                        },
                      ),
                    ),
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
                  child: Container(),
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
                      child: Column(
                        children: [
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 20.0),
                            child: Form(
                              key: _formKey,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  _buildGroupNameTF(),
                                  SizedBox(
                                    height: 30.0,
                                  ),
                                  Divider(
                                    thickness: 3.0,
                                  ),
                                  SizedBox(
                                    height: 10.0,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 20.0),
                                    child: Text(
                                      PARTICIPANTS,
                                      style: TextStyle(
                                        color: Colors.grey,
                                        fontFamily: 'OpenSans',
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20.0,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 30.0,
                                  ),
                                  GridViewPlayers(
                                    usersToAddToGroup: widget.usersToAddToGroup,
                                    userBloc: widget.userBloc,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
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
