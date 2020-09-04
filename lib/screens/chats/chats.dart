import 'package:au_chat/models/user_model.dart';
import 'package:au_chat/screens/configurations/configurations.dart';
import 'package:au_chat/screens/matches/matches.dart';
import 'package:au_chat/services/node.dart';
import 'package:au_chat/utilities/constants.dart';
import 'package:au_chat/widgets/recent_chats.dart';
import 'package:flutter/material.dart';

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
  int currentIndex = 0;

  @override
  void initState() {
    super.initState();

    getCurrentUser();
  }

  Future<UserModel> getCurrentUser() async {
    String firebaseId = widget.user.firebaseId;

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
      body: _callPage(currentIndex),
      bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }

  Widget _callPage(int paginaActual) {
    switch (paginaActual) {
      case 0:
        return SafeArea(
          child: Column(
            children: [
              // FavoriteContacts(),
              RecentChats(user: widget.user),
            ],
          ),
        );
      case 1:
        return SafeArea(
          child: Column(
            children: [
              // FavoriteContacts(),
              Matches(user: widget.user),
            ],
          ),
        );
        break;
      case 2:
        return SafeArea(
          child: Column(
            children: [
              // FavoriteContacts(),
              Configurations(user: widget.user),
            ],
          ),
        );
        break;
      default:
        return SafeArea(
          child: Column(
            children: [
              // FavoriteContacts(),
              RecentChats(user: widget.user),
            ],
          ),
        );
    }
  }

  Widget _buildBottomNavigationBar() {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      onTap: (index) {
        setState(() {
          currentIndex = index;
        });
      },
      items: [
        BottomNavigationBarItem(
          title: Text('Chat'),
          icon: Icon(Icons.chat_bubble_outline_rounded),
        ),
        BottomNavigationBarItem(
          title: Text('Matches'),
          icon: Icon(Icons.sports_soccer),
        ),
        BottomNavigationBarItem(
          title: Text('Configurations'),
          icon: Icon(Icons.brightness_5),
        ),
      ],
    );
  }
}
