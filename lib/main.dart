import 'package:flutter/material.dart';
import 'package:foodfreelancing/src/app.dart';
// import '/screens/wrapper.dart';
import 'package:foodfreelancing/src/services/auth.dart';
import 'package:provider/provider.dart';
import "package:foodfreelancing/src/models/user.dart";

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print("MAIN CALLED");
    return StreamProvider<User>.value(
      value: AuthService().user,
      child: MaterialApp(home: App()),
    );
  }
}
