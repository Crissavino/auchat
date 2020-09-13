import 'package:au_chat/models/user_model.dart';
import 'package:au_chat/screens/wrapper.dart';
import 'package:au_chat/services/auth.dart';
import 'package:au_chat/services/node.dart';
import 'package:au_chat/user_preference/user_preference.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = UserPreferences();
  await prefs.initPref();

  UserModel nodeUser;
  await AuthService().user.first.then((UserModel user) async {
    if (user != null) {
      nodeUser = await NodeService().getUserByFirebaseId(user.firebaseId);
    }
  });

  runApp(MyApp(
    nodeUser: nodeUser,
  ));
}

class MyApp extends StatelessWidget {
  UserModel nodeUser;
  MyApp({this.nodeUser});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return StreamProvider<UserModel>.value(
      value: AuthService().user,
      child: MaterialApp(
        home: Wrapper(
          nodeUser: nodeUser,
        ),
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            //   // Define the default brightness and colors.
            //   brightness: Brightness.light,
            //   primaryColor: Colors.green[400],
            //   accentColor: Colors.green[900],

            //   // Define the default font family.
            //   // fontFamily: 'Georgia',

            //   // Define the default TextTheme. Use this to specify the default
            //   // text styling for headlines, titles, bodies of text, and more.
            //   // textTheme: TextTheme(
            //   //   headline1: TextStyle(fontSize: 72.0, fontWeight: FontWeight.bold),
            //   //   headline6: TextStyle(fontSize: 36.0, fontStyle: FontStyle.italic),
            //   //   bodyText2: TextStyle(fontSize: 14.0, fontFamily: 'Hind'),
            //   // ),
            ),
      ),
    );
  }
}
