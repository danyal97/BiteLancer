import 'package:flutter/material.dart';
import 'package:foodfreelancing/src/pages/authenticate.dart';
import 'package:foodfreelancing/src/pages/option.dart';
import 'package:foodfreelancing/src/pages/signup.dart';
import 'package:foodfreelancing/src/scoped-model/main_model.dart';
import 'package:scoped_model/scoped_model.dart';
import 'screens/main_screen.dart';
import "package:foodfreelancing/src/models/user.dart";
import 'package:provider/provider.dart';
import 'package:foodfreelancing/src/pages/sigin_page.dart';

class App extends StatelessWidget {
  final MainModel mainModel = MainModel();
  @override
  Widget build(BuildContext context) {
    print("APP CALLED");
    final user = Provider.of<User>(context);
    print("app user :");
    // print(user.uid);

    if (user == null) {
      print("user==null:  Called");
      return Authenticate();
    } else {
      // return OptionPage();
      print("Home Called");
      // Navigator.push(
      //     context, MaterialPageRoute(builder: (context) => OptionPage()));
      // return OptionPage();
      // return Authenticate();

      return ScopedModel<MainModel>(
        model: mainModel,
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: "Food Delivery App",
          theme: ThemeData(primaryColor: Colors.blueAccent),
          home: MainScreen(model: mainModel),
          // home: AddFoodItem(),
        ),
      );
    }
  }
}
