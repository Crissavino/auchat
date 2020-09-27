import 'package:au_chat/utilities/constants.dart';
import 'package:flutter/material.dart';

class Match extends StatefulWidget {
  @override
  _MatchState createState() => _MatchState();
}

class _MatchState extends State<Match> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Crear partido',
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
        body: Container(
          decoration: horizontalGradient,
          child: SafeArea(
            bottom: false,
            child: Column(
              children: [
                Expanded(
                  child: _buildFutbolField(),
                ),
              ],
            ),
          ),
        ));
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
        return matchMenuChoices.map((String choice) {
          return PopupMenuItem(
            value: choice,
            child: Text(choice),
          );
        }).toList();
      },
    );
  }

  void choiceAction(String choice) async {
    if (choice == ADD_PLAYER) {
      // List<UserModel> allUsers = await NodeService().getAllUsers();
      // Navigator.push(
      //   context,
      //   MaterialPageRoute(
      //     builder: (_) =>
      //         SearchPlayer(users: allUsers, chatRooom: widget.chatRoom),
      //   ),
      // ).then((val) async {
      //   setState(() {});
      // });
    } else if (choice == CREATE_GAME) {
      print('Tocaste create partido');
    } else if (choice == LEAVE_GROUP) {
      print('Tocaste irte?');
    }
  }

  Widget _buildFutbolField() {
    final bordeCancha = Transform.scale(
      scale: 1.0,
      child: Container(
        height: MediaQuery.of(context).size.height * 0.85,
        width: MediaQuery.of(context).size.width * 0.95,
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.grey[50],
            width: 5.0,
          ),
        ),
        child: Divider(
          color: Colors.white,
          height: 5.0,
          thickness: 5.0,
        ),
      ),
    );

    final areaGrande = Transform.scale(
      scale: 1.0,
      child: Container(
        height: MediaQuery.of(context).size.height * 0.15,
        width: MediaQuery.of(context).size.width * 0.60,
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.grey[50],
            width: 5.0,
          ),
        ),
      ),
    );

    final areaChica = Transform.scale(
      scale: 1.0,
      child: Container(
        height: MediaQuery.of(context).size.height * 0.09,
        width: MediaQuery.of(context).size.width * 0.40,
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.grey[50],
            width: 5.0,
          ),
        ),
      ),
    );

    final circuloCentral = Transform.scale(
      scale: 1.0,
      child: Container(
        height: 200.0,
        width: 200.0,
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.grey[50],
            width: 5.0,
          ),
          borderRadius: BorderRadius.circular(100),
        ),
      ),
    );

    return Stack(
      children: [
        Positioned(
          top: 0.0,
          left: MediaQuery.of(context).size.width * 0.0225,
          // left: 10.0,
          child: bordeCancha,
        ),
        Positioned(
          top: 0.0,
          left: MediaQuery.of(context).size.width / 5,
          child: areaGrande,
        ),
        Positioned(
          top: 0.0,
          left: MediaQuery.of(context).size.width / 3.3,
          child: areaChica,
        ),
        Positioned(
          top: MediaQuery.of(context).size.height * 0.31,
          // bottom: 35.0,
          left: MediaQuery.of(context).size.width / 3.8,
          child: circuloCentral,
        ),
        Positioned(
          top: MediaQuery.of(context).size.height * 0.70,
          // bottom: 35.0,
          left: MediaQuery.of(context).size.width / 5,
          child: areaGrande,
        ),
        Positioned(
          top: MediaQuery.of(context).size.height * 0.76,
          // bottom: 35.0,
          left: MediaQuery.of(context).size.width / 3.3,
          child: areaChica,
        ),
      ],
    );
  }
}
