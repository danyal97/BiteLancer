import 'package:foodfreelancing/src/models/user.dart';
import 'package:foodfreelancing/src/services/database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import "dart:async";

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Create User Object
  User _userFromFirebase(FirebaseUser user) {
    return user != null ? User(uid: user.uid) : null;
  }

  Stream<User> get user {
    print("Get Function Called");
    return _auth.onAuthStateChanged
        .map((FirebaseUser user) => _userFromFirebase(user));
  }

  // sign in email and password
  Future signInAnon() async {
    try {
      AuthResult result = await _auth.signInAnonymously();
      FirebaseUser user = result.user;
      return _userFromFirebase(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  // sign in anonymously
  User userFromFirebase(FirebaseUser user) => _userFromFirebase(user);

  // registeration
  Future registerWithEmailAndPassword(
   
      String email, String password, String username,String type) async {
    try {
      AuthResult result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);

      FirebaseUser user = result.user;
      user.sendEmailVerification();
      // print(user);
      if(type == "Consumer"){
      await DatabaseService(uid: user.uid).addBuyer(username);
      }
      else{
        await DatabaseService(uid: user.uid).addSeller(username);
      }
      
      return _userFromFirebase(user);
    } catch (e) {
      print(e.toString());
      return e.toString();
    }
  }

  someMethod() async {
      FirebaseUser user = await FirebaseAuth.instance.currentUser();
      print("Shahzaib");
      print(user.uid);   
      }
      
  Future changePassword(String password) async{
  //Create an instance of the current user. 
  FirebaseUser user = await FirebaseAuth.instance.currentUser();

  //Pass in the password to updatePassword.
  user.updatePassword(password).then((_){
    print("Succesfull changed password");
  }).catchError((error){
    print("Password can't be changed" + error.toString());
    //This might happen, when the wrong password is in, the user isn't found, or if the user hasn't logged in recently.
  });
  }    
  Future signInWithEmailAndPassword(String email, String password) async {
    try {
      AuthResult result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      FirebaseUser user = result.user;
      // await DatabaseService(uid: user.uid).updateFoodItems("food1", 90);
      return _userFromFirebase(user);
    } catch (e) {
      print(e.toString());
      return e.toString();
    }
  }

  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
