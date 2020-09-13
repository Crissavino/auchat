import 'package:au_chat/bloc/user_bloc.dart';
import 'package:au_chat/models/user_model.dart';
import 'package:flutter/material.dart';
// export 'package:au_chat/widgets/player_row.dart';

// List<UserModel> usersToAdd = List();
// List<UserModel> usersToAdd = List();

class PlayerRow extends StatefulWidget {
  UserModel user;
  bool isAlreadyHere;
  UserBloc userBloc;

  PlayerRow({this.user, this.isAlreadyHere, this.userBloc});
  @override
  _PlayerRowState createState() => _PlayerRowState();
}

class _PlayerRowState extends State<PlayerRow> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 10.0, bottom: 2.0, right: 10.0, left: 10.0),
      padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
      decoration: BoxDecoration(
        color: Color(0xFFFFEFEE),
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: StreamBuilder(
        stream: widget.userBloc.usersStream,
        initialData: widget.user,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          List<UserModel> usersToAdd = List();
          if (snapshot.data is List) {
            usersToAdd = snapshot.data;
          }
          if (usersToAdd != null && usersToAdd.isNotEmpty) {
            widget.isAlreadyHere = usersToAdd
                .where((UserModel user) =>
                    user.firebaseId == widget.user.firebaseId)
                .isNotEmpty;
          }
          return Container(
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
                  widget.user.fullName,
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 15.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                IconButton(
                  icon:
                      (widget.isAlreadyHere || usersToAdd.contains(widget.user))
                          ? Icon(Icons.check)
                          : Icon(Icons.add_circle_outline),
                  iconSize: 30.0,
                  color: widget.isAlreadyHere ? Colors.blue : Colors.green[400],
                  onPressed: () {
                    print(widget.user.email);
                    if (widget.isAlreadyHere) {
                      setState(() {
                        widget.isAlreadyHere = false;
                        widget.userBloc.usersToRemoveStream(widget.user);
                      });
                    } else {
                      setState(() {
                        // usersToAdd.add(widget.user);
                        widget.isAlreadyHere = true;
                        widget.userBloc.usersToAddSink(widget.user);
                      });
                    }
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
