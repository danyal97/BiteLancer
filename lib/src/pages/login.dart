import 'package:flutter/material.dart';
import 'package:foodfreelancing/src/animation/FadeAnimation.dart';
import 'package:foodfreelancing/src/pages/option.dart';
import 'package:foodfreelancing/src/services/auth.dart';

class LoginPage extends StatefulWidget {
  final Function toggleView;

  LoginPage({this.toggleView});
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool loading = false;
final AuthService _auth = AuthService();
  // final _formKey = GlobalKey<FormState>();
  String error = "";
  String email = "";
  String password = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        brightness: Brightness.light,
        backgroundColor: Colors.white,
        // leading: IconButton(
        //   onPressed: () {
        //     Navigator.pop(context);
        //   },
        //   icon: Icon(
        //     Icons.arrow_back_ios,
        //     size: 20,
        //     color: Colors.black,
        //   ),
        // ),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Column(
                    children: <Widget>[
                        Container(
                      height: 120.0,
                      width: 120.0,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(60.0),
                        boxShadow: [
                          BoxShadow(
                              blurRadius: 3.0,
                              offset: Offset(0, 4.0),
                              color: Colors.black38),
                        ],
                        image: DecorationImage(
                          image: NetworkImage("https://firebasestorage.googleapis.com/v0/b/foodfreelancing.appspot.com/o/Foodpictures%2F323f6041-5444-4073-9170-05ef5d06cca4_200x200.png?alt=media&token=21d09313-e45c-4e38-be84-45939e65b4e5"),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    SizedBox(
                        height: 20,
                      ),
                      FadeAnimation(
                          1,
                          Text(
                            "Login",
                            style: TextStyle(
                                fontSize: 30, fontWeight: FontWeight.bold),
                          )),
                      SizedBox(
                        height: 20,
                      ),
                      FadeAnimation(
                          1.2,
                          Text(
                            "Login to your account",
                            style: TextStyle(
                                fontSize: 15, color: Colors.grey[700]),
                          )),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 40),
                    child: Column(
                      children: <Widget>[
                        FadeAnimation(1.2, makeInput(label: "Email")),
                        FadeAnimation(1.3,
                            makeInput(label: "Password", obscureText: true)),
                      ],
                    ),
                  ),
                   Builder(
        builder: (context) => 
                          FadeAnimation(
                      1.4,
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 40),
                        child: Container(
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
                            onPressed: 
                             () async {
                                  // loading = true;
                                  setState(() {
                                    loading = true;
                                  });
                                  dynamic result;
                                    result =
                                        await _auth.signInWithEmailAndPassword(email, password);

                                  if (result is String) {
                                     error = result.split(",")[1];
                                    _displaySnackBar(context,error);
                                          // Find the Scaffold in the widget tree and use
                                          // it to show a SnackBar.
                                      
                                    setState(() {
                                     
                                      loading = false;
                                    });
                                }
                             },
                            // () {
                            //   Navigator.push(
                            //       context,
                            //       MaterialPageRoute(
                            //           builder: (context) => OptionPage(
                            //                 email: email,
                            //                 password: password,
                            //                 label: "login",
                            //               )));
                            // },
                            height: 60,
                            color: Colors.greenAccent,
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(50)),
                            child: Text(
                              "Login",
                              style: TextStyle(
                                  fontWeight: FontWeight.w600, fontSize: 18),
                            ),
                          ),
                        ),
                      ))
                      ),
                  FadeAnimation(
                      1.5,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text("Don't have an account?"),
                          GestureDetector(
                            onTap: () {
                              widget.toggleView();
                            },
                            child: Text(
                              "Sign up",
                              style: TextStyle(
                                  fontWeight: FontWeight.w600, fontSize: 20.0),
                            ),
                          ),

                          // Text(
                          //   "Sign up",
                          //   style: TextStyle(
                          //       fontWeight: FontWeight.w600, fontSize: 18),
                          // ),
                        ],
                      ))
                ],
              ),
            ),
            FadeAnimation(
                1.2,
                Container(
                  height: MediaQuery.of(context).size.height / 6,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage('assets/background.png'),
                          fit: BoxFit.cover)),
                ))
          ],
        ),
      ),
    );
  }
_displaySnackBar(BuildContext context,String error) {
  final snackBar = SnackBar(content: Text(error,
  style: TextStyle(
  fontSize: 18.0,
  fontWeight: FontWeight.bold,
  color: Colors.white,
  fontStyle: FontStyle.normal,
  ),
  )
  ,
  backgroundColor: Colors.red,);
  Scaffold.of(context).showSnackBar(snackBar);
}
  Widget makeInput({label, obscureText = false}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          label,
          style: TextStyle(
              fontSize: 15, fontWeight: FontWeight.w400, color: Colors.black87),
        ),
        SizedBox(
          height: 5,
        ),
        TextField(
          obscureText: obscureText,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey[400])),
            border: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey[400])),
          ),
          onChanged: (value) {
            setState(() {
              if (label == "Email") {
                email = value;
                print("Email : " + email);
              } else {
                password = value;
                print("Password : " + password);
              }
            });
          },
        ),
        SizedBox(
          height: 30,
        ),
      ],
    );
  }
}

// class LoginPage extends StatelessWidget {

//   @override
//   Widget build(BuildContext context) {}

//   Widget makeInput({label, obscureText = false}) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: <Widget>[
//         Text(
//           label,
//           style: TextStyle(
//               fontSize: 15, fontWeight: FontWeight.w400, color: Colors.black87),
//         ),
//         SizedBox(
//           height: 5,
//         ),
//         TextField(
//           obscureText: obscureText,
//           decoration: InputDecoration(
//             contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
//             enabledBorder: OutlineInputBorder(
//                 borderSide: BorderSide(color: Colors.grey[400])),
//             border: OutlineInputBorder(
//                 borderSide: BorderSide(color: Colors.grey[400])),
//           ),
//         ),
//         SizedBox(
//           height: 30,
//         ),
//       ],
//     );
//   }
// }
