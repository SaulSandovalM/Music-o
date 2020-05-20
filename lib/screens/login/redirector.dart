import 'package:flutter/material.dart';
import 'package:music_finder/models/state.dart';
import 'package:music_finder/util/state_widget.dart';
import 'package:music_finder/screens/login/sign_in.dart';
import 'package:music_finder/widgets/loading.dart';
import 'package:music_finder/screens/profile/profile.dart';

class Redirector extends StatefulWidget {
  _RedirectorState createState() => _RedirectorState();
}

class _RedirectorState extends State<Redirector> {
  StateModel appState;
  bool _loadingVisible = false;
  @override
  void initState() {
    super.initState();
  }

  Widget build(BuildContext context) {
    appState = StateWidget.of(context).state;
    if (!appState.isLoading &&
        (appState.firebaseUserAuth == null ||
            appState.user == null ||
            appState.settings == null)) {
      return SignIn();
    } else {
      if (appState.isLoading) {
        _loadingVisible = true;
      } else {
        _loadingVisible = false;
      }
      return Profile();
    }
  }
}