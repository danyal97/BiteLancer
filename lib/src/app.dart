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
import 'package:foodfreelancing/src/services/database.dart';
import 'package:foodfreelancing/src/shared/loading.dart';
import 'screens/Buyer_main_screen.dart';
class App extends StatefulWidget {
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  var userinfo;
  var id;
  bool checker = false;
final MainModel mainModel = MainModel();
final DatabaseService _database = DatabaseService();
  Future getUser(String uid) async {
  userinfo = await _database.getType(uid);
  setState(() {
      checker = true;
    });
  }
  @override
  Widget build(BuildContext context) {
    print("APP CALLED");
    final user = Provider.of<User>(context);
    print("app user :");
    // print(user.uid);
    print(checker);
    if (user == null) {
      print("user==null:  Called");
      setState(() {
      checker = false;
    });
      return Authenticate();
    } 
    else {
      // return OptionPage();
      print("Home Called");
      // Navigator.push(
      //     context, MaterialPageRoute(builder: (context) => OptionPage()));
      // return OptionPage();
      // return Authenticate();
      //  print("hahahhhhah");
      // print(type);
      print(checker);
    if (!checker) {
    print(1);
      getUser(user.uid);
    return Loading();
    } 
    else{
      print(userinfo);
      print("Shahzaib the boss");
      if(userinfo == "Seller")
      {
        print(userinfo);
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
    else{
      print(userinfo);
      return ScopedModel<MainModel>(
        model: mainModel,
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: "Food Delivery App",
          theme: ThemeData(primaryColor: Colors.blueAccent),
          home: BuyerMainScreen(model: mainModel),
          // home: AddFoodItem(),
        ),
      );
    }
    }
    }
  }
  
}
// class App extends StatelessWidget {
//   final MainModel mainModel = MainModel();
//   final DatabaseService _database = DatabaseService();
//   var userinfo;
//   var id;
//   bool check = false;
//   bool check1 = true;
//   Future getUser(String uid) async {
//     userinfo = await _database.getSellerInfo(uid);
//     setState(() {
//       check = true;
//     });
//   }
//   @override
//   Widget build(BuildContext context) {
//     print("APP CALLED");
//     final user = Provider.of<User>(context);
//     print("app user :");
//     // print(user.uid);

//     if (user == null) {
//       print("user==null:  Called");
//       return Authenticate();
//     } else {
//       // return OptionPage();
//       print("Home Called");
//       // Navigator.push(
//       //     context, MaterialPageRoute(builder: (context) => OptionPage()));
//       // return OptionPage();
//       // return Authenticate();
//        dynamic type =  getBanda(user.uid);
//       //  print("hahahhhhah");
//       // print(type);
//       if (!check) {
//        print(1);
//         getUser(user.uid);
//       return Loading();
//     } 
//     else{
//       return ScopedModel<MainModel>(
//         model: mainModel,
//         child: MaterialApp(
//           debugShowCheckedModeBanner: false,
//           title: "Food Delivery App",
//           theme: ThemeData(primaryColor: Colors.blueAccent),
//           home: MainScreen(model: mainModel),
//           // home: AddFoodItem(),
//         ),
//       );
//     }
//     }
//   }
//   Future<String> getBanda(String uid) async {
//   return await _database.getType(uid);
//   }
// }
