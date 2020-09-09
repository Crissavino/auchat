import 'package:au_chat/models/user_model.dart';
import 'package:au_chat/screens/wrapper.dart';
import 'package:au_chat/services/auth.dart';
import 'package:au_chat/user_preference/user_preference.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = UserPreferences();
  await prefs.initPref();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return StreamProvider<UserModel>.value(
      value: AuthService().user,
      child: MaterialApp(
        home: Wrapper(),
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
