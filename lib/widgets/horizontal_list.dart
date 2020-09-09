import 'package:au_chat/models/user_model.dart';
import 'package:flutter/material.dart';

class HorizontalPlayersList extends StatelessWidget {
  final List<UserModel> usersToAddToGroup;
  HorizontalPlayersList({this.usersToAddToGroup});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10.0),
      child: Container(
        height: 120.0,
        child: ListView.builder(
          padding: EdgeInsets.only(left: 10.0),
          scrollDirection: Axis.horizontal,
          itemCount: usersToAddToGroup.length,
          itemBuilder: (BuildContext context, int index) {
            return GestureDetector(
              onTap: () => print('Eliminar'),
              child: Padding(
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
                      usersToAddToGroup[index].fullName,
                      style: TextStyle(
                        color: Colors.grey,
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
    );
  }
}
