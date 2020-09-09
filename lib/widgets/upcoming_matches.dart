import 'package:au_chat/models/user_model.dart';
import 'package:flutter/material.dart';

class UpcomingMatches extends StatelessWidget {
  final UserModel user;
  UpcomingMatches({this.user});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10.0),
      child: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  'Proximos partidos',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.0,
                  ),
                ),
              ],
            ),
          ),
          Container(
            height: 120.0,
            child: ListView.builder(
              padding: EdgeInsets.only(left: 10.0),
              scrollDirection: Axis.horizontal,
              itemCount: 6,
              itemBuilder: (BuildContext context, int index) {
                return GestureDetector(
                  // onTap: () => Navigator.push(
                  //   context,
                  //   MaterialPageRoute(
                  //     builder: (_) => ChatRoom(
                  //       user: favorites[index],
                  //     ),
                  //   ),
                  // ),
                  onTap: () => print('Debo ir al partido'),
                  child: Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Column(
                      children: <Widget>[
                        CircleAvatar(
                            radius: 35.0,
                            backgroundImage:
                                AssetImage('assets/matches/placeholder.png')),
                        SizedBox(height: 6.0),
                        Text(
                          'EDLP $index',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16.0,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
