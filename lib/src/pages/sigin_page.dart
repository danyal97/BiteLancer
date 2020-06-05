import 'package:flutter/material.dart';
// import 'package:foodfreelancing/src/pages/signup_page.dart';
import 'package:foodfreelancing/src/services/auth.dart';
import 'package:foodfreelancing/src/shared/loading.dart';
import 'package:foodfreelancing/src/widgets/button.dart';
// import '../pages/signup_page.dart';

class SignInPage extends StatefulWidget {
  @override
  final Function toggleView;

  SignInPage({this.toggleView});

  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  // SignInPageState(this.toggleView);
  final AuthService _auth = AuthService();
  bool loading = false;

  // final _formKey = GlobalKey<FormState>();
  String error = "";
  String email = "";
  String password = "";
  bool _toggleVisibility = true;

  Widget _buildEmailTextField() {
    return TextFormField(
      decoration: InputDecoration(
        hintText: "Your email or username",
        hintStyle: TextStyle(
          color: Color(0xFFBDC2CB),
          fontSize: 18.0,
        ),
      ),
      onChanged: (value) {
        setState(() {
          email = value;
        });
      },
    );
  }

  Widget _buildPasswordTextField() {
    return TextFormField(
      decoration: InputDecoration(
        hintText: "Password",
        hintStyle: TextStyle(
          color: Color(0xFFBDC2CB),
          fontSize: 18.0,
        ),
        suffixIcon: IconButton(
          onPressed: () {
            setState(() {
              _toggleVisibility = !_toggleVisibility;
            });
          },
          icon: _toggleVisibility
              ? Icon(Icons.visibility_off)
              : Icon(Icons.visibility),
        ),
      ),
      obscureText: _toggleVisibility,
      onChanged: (value) {
        setState(() {
          password = value;
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    print("SignIn Called");
    return loading
        ? Loading()
        : Scaffold(
            body: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    "Sign In",
                    style: TextStyle(
                      fontSize: 40.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: 100.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Text(
                        "Forgotten Password?",
                        style: TextStyle(
                          fontSize: 18.0,
                          color: Colors.blueAccent,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Card(
                    elevation: 5.0,
                    child: Padding(
                      padding: EdgeInsets.all(20.0),
                      child: Column(
                        children: <Widget>[
                          _buildEmailTextField(),
                          SizedBox(
                            height: 20.0,
                          ),
                          _buildPasswordTextField(),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 30.0,
                  ),
                  FlatButton(
                      onPressed: () async {
                        // loading = true;
                        setState(() {
                          loading = true;
                        });
                        dynamic result = await _auth.signInWithEmailAndPassword(
                            email, password);
                        if (result is String) {
                          setState(() {
                            error = result.split(",")[1];
                            loading = false;
                          });
                        }
                      },
                      child: Button(
                        btnText: "Sign In",
                      )),
                  Divider(
                    height: 20.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        "Don't have an account?",
                        style: TextStyle(
                            color: Color(0xFFBDC2CB),
                            fontWeight: FontWeight.bold,
                            fontSize: 18.0),
                      ),
                      SizedBox(width: 10.0),
                      GestureDetector(
                        onTap: () {
                          widget.toggleView();
                        },
                        child: Text(
                          "Sign up",
                          style: TextStyle(
                              color: Colors.blueAccent,
                              fontWeight: FontWeight.bold,
                              fontSize: 22.0),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
  }
}
