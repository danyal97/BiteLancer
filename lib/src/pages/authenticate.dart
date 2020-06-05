import 'package:foodfreelancing/src/pages/sigin_page.dart';
import 'package:foodfreelancing/src/pages/signup_page.dart';
import "package:flutter/material.dart";

class Authenticate extends StatefulWidget {
  @override
  _AuthenticateState createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {
  bool showSignIn = true;
  void toggleView() {
    setState(() {
      showSignIn = !showSignIn;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (showSignIn) {
      print("Authenticate SignIn Called");
      return SignInPage(toggleView: toggleView);
    } else {
      print("Authenticate SignUp Called");
      return SignUpPage(toggleView: toggleView);
    }
  }
}
