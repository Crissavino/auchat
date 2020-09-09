import 'package:au_chat/models/user_model.dart';
import 'package:au_chat/services/auth.dart';
import 'package:flutter/material.dart';

class Configurations extends StatelessWidget {
  final UserModel user;
  Configurations({this.user});

  final AuthService _auth = AuthService();
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
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
          child: Container(
            width: double.infinity,
            child: Column(
              children: [
                _logoutButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _logoutButton() {
    return FlatButton.icon(
      icon: Icon(Icons.logout),
      label: Text('logout'),
      onPressed: () async {
        await _auth.signOut();
      },
    );
  }
}
