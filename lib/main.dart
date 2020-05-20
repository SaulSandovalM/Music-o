import 'package:flutter/material.dart';
import 'package:music_finder/util/state_widget.dart';
import 'package:music_finder/screens/login/redirector.dart';
import 'package:music_finder/screens/login/sign_in.dart';
import 'package:music_finder/screens/login/sign_up.dart';
import 'package:music_finder/screens/login/forgot_password.dart';
import 'package:music_finder/screens/profile/profile.dart';
import 'package:music_finder/widgets/menu.dart';

class MyApp extends StatelessWidget {
  MyApp() {
    //Navigation.initPaths();
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        '/': (context) => CategoryRoute(),
        '/signin': (context) => SignIn(),
        '/signup': (context) => SignUp(),
        '/forgot-password': (context) => ForgotPassword(),
        '/profile': (context) => Profile(),
        '/profile2': (context) => CategoryRoute()
      },
    );
  }
}

void main() {
  StateWidget stateWidget = new StateWidget(
    child: new MyApp(),
  );
  runApp(stateWidget);
}