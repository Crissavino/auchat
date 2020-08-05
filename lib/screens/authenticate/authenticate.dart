import 'package:au_chat/screens/authenticate/login_screen.dart';
import 'package:au_chat/screens/authenticate/register.dart';
import 'package:flutter/material.dart';

class Authenticate extends StatefulWidget {
  @override
  _AuthenticateState createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {
  bool showSignIn = true;
  void toggleView() {
    setState(() => showSignIn = !showSignIn);
  }

  @override
  Widget build(BuildContext context) {
    if (showSignIn) {
      return Register(toggleView: toggleView);
    } else {
      return Text('Register');
      // return Register(toggleView:  toggleView);
    }
  }
}
