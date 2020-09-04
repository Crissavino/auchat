import 'package:au_chat/models/user_model.dart';
import 'package:flutter/material.dart';

class Matches extends StatelessWidget {
  final UserModel user;
  Matches({this.user});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text('Partidos'),
    );
  }
}
