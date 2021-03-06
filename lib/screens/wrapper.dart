import 'package:au_chat/models/user_model.dart';
import 'package:au_chat/screens/authenticate/authenticate.dart';
import 'package:au_chat/screens/chats/chats.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserModel>(context);
    // return either the Home or Authenticate widget
    if (user == null) {
      return Authenticate();
    } else {
      // return Chats(user: user);
      return Chats(
        userFirebaseId: user.firebaseId,
      );
    }
  }
}
