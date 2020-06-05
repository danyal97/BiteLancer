import 'package:foodfreelancing/src/models/user.dart';
// import 'package:foodfreelancing/src/services/database.dart';
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
  Future registerWithEmailAndPassword(String email, String password) async {
    try {
      AuthResult result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      FirebaseUser user = result.user;
      // print(user);

      // await DatabaseService(uid: user.uid).updateFoodItems("food1", 17);
      return _userFromFirebase(user);
    } catch (e) {
      print(e.toString());
      return e.toString();
    }
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
