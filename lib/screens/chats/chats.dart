import 'package:au_chat/models/user_model.dart';
import 'package:au_chat/services/auth.dart';
import 'package:au_chat/services/node.dart';
import 'package:au_chat/user_preference/user_preference.dart';
import 'package:au_chat/utilities/constants.dart';
import 'package:au_chat/widgets/favorite_contacts.dart';
import 'package:au_chat/widgets/recent_chats.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Chats extends StatefulWidget {
  final UserModel user;
  Chats({
    Key key,
    @required this.user,
  }) : super(key: key);

  @override
  _ChatsState createState() => _ChatsState();
}

class _ChatsState extends State<Chats> {
  UserModel currentUser;
  dynamic search = '';

  @override
  void initState() {
    super.initState();

    getCurrentUser();
  }

  Future<UserModel> getCurrentUser() async {
    String firebaseId = UserPreferences().firebaseId;

    UserModel currentUser = await NodeService().getUserByFirebaseId(firebaseId);
    return currentUser;
  }

  Widget _buildSearchTF() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(left: 25.0, right: 25.0),
          child: Container(
            margin: EdgeInsets.only(top: 30.0),
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
                setState(() => search = val);
                print(search);
              },
            ),
          ),
        ),
      ],
    );
  }

  final AuthService _auth = AuthService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
      body: SafeArea(
        child: Column(
          children: [
            // FavoriteContacts(),
            RecentChats(user: widget.user),
            FlatButton.icon(
              icon: Icon(Icons.person),
              label: Text('logout'),
              onPressed: () async {
                await _auth.signOut();
              },
            ),
          ],
        ),
      ),
    );
  }
}
