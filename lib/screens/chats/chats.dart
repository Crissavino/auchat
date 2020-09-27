import 'package:au_chat/models/user_model.dart';
import 'package:au_chat/screens/chats/add_participants.dart';
import 'package:au_chat/screens/configurations/configurations.dart';
import 'package:au_chat/screens/matches/add_match_info.dart';
import 'package:au_chat/screens/matches/matches.dart';
import 'package:au_chat/services/node.dart';
import 'package:au_chat/utilities/constants.dart';
import 'package:au_chat/utilities/slide_bottom_route.dart';
import 'package:au_chat/widgets/recent_chats.dart';
import 'package:au_chat/widgets/upcoming_matches.dart';
import 'package:flutter/material.dart';

class Chats extends StatefulWidget {
  static final String routeName = 'chats';
  final String userFirebaseId;
  Chats({
    Key key,
    @required this.userFirebaseId,
  }) : super(key: key);

  @override
  _ChatsState createState() => _ChatsState();
}

class _ChatsState extends State<Chats> {
  UserModel currentUser;
  dynamic search = '';
  int currentIndex = 0;

  Future<UserModel> initUser() async {
    return await NodeService().getUserByFirebaseId(widget.userFirebaseId);
  }

  @override
  void initState() {
    super.initState();
  }

  Widget _buildSearchTF() {
    return Row(
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: (currentIndex == 2)
                  ? const EdgeInsets.only(left: 20.0)
                  : const EdgeInsets.only(left: 25.0, right: 25.0),
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
                width: (currentIndex == 2)
                    ? MediaQuery.of(context).size.width * 0.9
                    : MediaQuery.of(context).size.width * 0.7,
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
                    hintText: 'Buscar',
                    hintStyle: kHintTextStyle,
                  ),
                  onChanged: (val) {
                    setState(() => search = val);
                  },
                ),
              ),
            ),
          ],
        ),
        (currentIndex == 0)
            ? _buildCreateGroupButton()
            : (currentIndex == 1) ? _buildCreateMatchButton() : Container(),
      ],
    );
  }

  Column _buildCreateGroupButton() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 30.0),
          child: IconButton(
            icon: Icon(Icons.add_circle_outline),
            iconSize: 30.0,
            color: Colors.white,
            onPressed: () {
              Navigator.push(
                context,
                SlideBottomRoute(
                  page: AddParticipants(
                    currentUser: currentUser,
                  ),
                ),
              ).then((val) async {
                setState(() {});
              });
            },
          ),
        ),
      ],
    );
  }

  Widget userFutureBuilder(Widget widgetToReturn) {
    return FutureBuilder(
      future: initUser(),
      builder: (BuildContext context, AsyncSnapshot<UserModel> snapshot) {
        if (!snapshot.hasData) {
          return Container();
        } else {
          currentUser = snapshot.data;
          return widgetToReturn;
        }
      },
    );
  }

  Column _buildCreateMatchButton() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 30.0),
          child: IconButton(
            icon: Icon(Icons.add_circle_outline),
            iconSize: 30.0,
            color: Colors.white,
            onPressed: () {
              Navigator.push(
                context,
                SlideBottomRoute(
                  page: AddMatchInfo(
                    currentUser: currentUser,
                  ),
                ),
              ).then((val) async {
                setState(() {});
              });
            },
          ),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return userFutureBuilder(
      Scaffold(
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
          child: _callPage(currentIndex),
        ),
        bottomNavigationBar: _buildBottomNavigationBar(),
      ),
    );
  }

  Widget _callPage(int paginaActual) {
    return FutureBuilder(
      future: initUser(),
      builder: (BuildContext context, AsyncSnapshot<UserModel> snapshot) {
        if (!snapshot.hasData) {
          return Container(
            child: Center(
              child: circularLoading,
            ),
          );
        } else {
          switch (paginaActual) {
            case 0:
              return SafeArea(
                child: Column(
                  children: [
                    UpcomingMatches(),
                    RecentChats(user: currentUser),
                  ],
                ),
              );
            case 1:
              return SafeArea(
                child: Column(
                  children: [
                    Matches(user: currentUser),
                  ],
                ),
              );
              break;
            case 2:
              return SafeArea(
                child: Column(
                  children: [
                    Configurations(user: currentUser),
                  ],
                ),
              );
              break;
            default:
              return SafeArea(
                child: Column(
                  children: [
                    UpcomingMatches(),
                    RecentChats(user: currentUser),
                  ],
                ),
              );
          }
        }
      },
    );
  }

  Widget _buildBottomNavigationBar() {
    return BottomNavigationBar(
      showUnselectedLabels: false,
      selectedItemColor: Colors.green[400],
      unselectedItemColor: Colors.green[900],
      currentIndex: currentIndex,
      onTap: (index) {
        setState(() {
          currentIndex = index;
        });
      },
      items: [
        BottomNavigationBarItem(
          // ignore: deprecated_member_use
          title: Text('Chats'),
          icon: Icon(Icons.chat_bubble_outline_rounded),
        ),
        BottomNavigationBarItem(
          // ignore: deprecated_member_use
          title: Text('Partidos'),
          icon: Icon(Icons.sports_soccer),
        ),
        BottomNavigationBarItem(
          // ignore: deprecated_member_use
          title: Text('Configuracion'),
          icon: Icon(Icons.brightness_5),
        ),
      ],
    );
  }
}
