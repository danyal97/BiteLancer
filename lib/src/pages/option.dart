import 'package:flutter/material.dart';
import 'package:foodfreelancing/src/animation/FadeAnimation.dart';
import 'package:foodfreelancing/src/services/auth.dart';
import 'package:foodfreelancing/src/shared/loading.dart';

class OptionPage extends StatefulWidget {
  String email = "";
  String password = "";
  String label = "";
  String username = "";
  @override
  OptionPage({this.email, this.password, this.label, this.username});
  _OptionPageState createState() => _OptionPageState();
}

class _OptionPageState extends State<OptionPage> {
  final AuthService _auth = AuthService();
  bool loading = false;
  String error = "";
  // print(widget.email);
  // print(widget.password);
  @override
  Widget build(BuildContext context) {
    return loading
        ? Loading()
        : Scaffold(
            resizeToAvoidBottomInset: true,
            backgroundColor: Colors.white,
            appBar: AppBar(
              elevation: 0,
              brightness: Brightness.light,
              backgroundColor: Colors.white,
              leading: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(
                  Icons.arrow_back_ios,
                  size: 20,
                  color: Colors.black,
                ),
              ),
            ),
            body: SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 40),
                height: MediaQuery.of(context).size.height - 50,
                width: double.infinity,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Column(
                      children: <Widget>[
                        FadeAnimation(
                            1,
                            Text(
                              "Select an option",
                              style: TextStyle(
                                  fontSize: 30, fontWeight: FontWeight.bold),
                            )),
                        SizedBox(
                          height: 20,
                        ),
                        FadeAnimation(
                            1.2,
                            Text(
                              "Once opted you can always change it.",
                              style: TextStyle(
                                  fontSize: 15, color: Colors.grey[700]),
                            )),
                      ],
                    ),
                    Column(
                      children: <Widget>[
                        FadeAnimation(
                            1.5,
                            Container(
                              margin: const EdgeInsets.only(bottom: 20.0),
                              padding: EdgeInsets.only(top: 3, left: 3),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(50),
                                  border: Border(
                                    bottom: BorderSide(color: Colors.black),
                                    top: BorderSide(color: Colors.black),
                                    left: BorderSide(color: Colors.black),
                                    right: BorderSide(color: Colors.black),
                                  )),
                              child: MaterialButton(
                                minWidth: double.infinity,
                                height: 60,
                                onPressed: () async {
                                  // loading = true;
                                  setState(() {
                                    loading = true;
                                  });
                                  final type = "Consumer";
                                  dynamic result;
                                  if (widget.label == "login") {
                                    result =
                                        await _auth.signInWithEmailAndPassword(
                                            widget.email, widget.password);
                                  } else if (widget.label == "signup") {
                                    print("label Signup called");
                                    result = await _auth
                                        .registerWithEmailAndPassword(
                                      widget.email,
                                      widget.password,
                                      widget.username,
                                      type
                                    );
                                  }

                                  if (result is String) {
                                    setState(() {
                                      error = result.split(",")[1];
                                      loading = false;
                                    });
                                    Navigator.pop(context);
                                  } else {
                                    Navigator.pop(context);
                                  }
                                },
                                color: Colors.yellow,
                                elevation: 0,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(50)),
                                child: Text(
                                  "Become a Consumer",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 18),
                                ),
                              ),
                            )),
                        FadeAnimation(
                            1.5,
                            Container(
                              padding: EdgeInsets.only(top: 3, left: 3),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(50),
                                  border: Border(
                                    bottom: BorderSide(color: Colors.black),
                                    top: BorderSide(color: Colors.black),
                                    left: BorderSide(color: Colors.black),
                                    right: BorderSide(color: Colors.black),
                                  )),
                              child: MaterialButton(
                                minWidth: double.infinity,
                                height: 60,
                                onPressed: () async {
                                  // loading = true;
                                  setState(() {
                                    loading = true;
                                  });
                                  final type = "Caterer";
                                  dynamic result;
                                  if (widget.label == "login") {
                                    result =
                                        await _auth.signInWithEmailAndPassword(
                                            widget.email, widget.password);
                                  } else if (widget.label == "signup") {
                                    print("label Signup called");
                                    result = await _auth
                                        .registerWithEmailAndPassword(
                                      widget.email,
                                      widget.password,
                                      widget.username,
                                      type
                                    );
                                  }

                                  if (result is String) {
                                    setState(() {
                                      error = result.split(",")[1];
                                      loading = false;
                                    });
                                    Navigator.pop(context);
                                  } else {
                                    Navigator.pop(context);
                                  }
                                },
                                color: Colors.greenAccent,
                                elevation: 0,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(50)),
                                child: Text(
                                  "Become a Caterer",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 18),
                                ),
                              ),
                            )),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
  }
}
