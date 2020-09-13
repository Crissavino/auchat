import 'package:au_chat/bloc/user_bloc.dart';
import 'package:au_chat/models/user_model.dart';
import 'package:flutter/material.dart';

class GridViewPlayers extends StatefulWidget {
  List<UserModel> usersToAddToGroup;
  final UserBloc userBloc;
  GridViewPlayers({this.usersToAddToGroup, this.userBloc});

  @override
  _GridViewPlayersState createState() => _GridViewPlayersState();
}

class _GridViewPlayersState extends State<GridViewPlayers> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 10.0),
        child: Container(
          height: MediaQuery.of(context).size.height * 0.5,
          child: StreamBuilder<Object>(
            stream: widget.userBloc.usersStream,
            initialData: widget.usersToAddToGroup,
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }

              widget.usersToAddToGroup = snapshot.data;
              return GridView.builder(
                itemCount: widget.usersToAddToGroup.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  // number of items per row
                  crossAxisCount: 3,
                  // vertical spacing between the items
                  mainAxisSpacing: 10,
                  // horizontal spacing between the items
                  crossAxisSpacing: 10,
                ),
                itemBuilder: (BuildContext context, int index) {
                  return Stack(
                    fit: StackFit.expand,
                    children: [
                      Padding(
                        padding: EdgeInsets.all(10.0),
                        child: Column(
                          children: <Widget>[
                            CircleAvatar(
                              radius: 35.0,
                              backgroundImage: NetworkImage(
                                  'https://img2.freepng.es/20180228/grw/kisspng-logo-football-photography-vector-football-5a97847a010f99.3151271415198792900044.jpg'),
                            ),
                            SizedBox(height: 6.0),
                            Text(
                              widget.usersToAddToGroup[index].fullName
                                  .split(' ')[0],
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 16.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Positioned(
                        top: -5,
                        right: 15,
                        child: IconButton(
                          icon: Icon(Icons.cancel),
                          iconSize: 30.0,
                          color: Colors.red[300],
                          onPressed: () {
                            setState(() {
                              widget.userBloc.usersToRemoveStream(
                                  widget.usersToAddToGroup[index]);
                            });
                          },
                        ),
                      ),
                    ],
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }
}
