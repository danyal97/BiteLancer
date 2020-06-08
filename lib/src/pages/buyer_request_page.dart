import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:foodfreelancing/src/models/buyer_request.dart';
import 'package:foodfreelancing/src/models/fooditemslist.dart';
import 'package:foodfreelancing/src/models/user.dart';
import 'package:foodfreelancing/src/services/BuyerRequest.dart';
import 'package:foodfreelancing/src/services/FoodItems.dart';
import 'package:foodfreelancing/src/services/auth.dart';
import 'package:foodfreelancing/src/services/database.dart';
import 'package:foodfreelancing/src/shared/loading.dart';
import 'package:provider/provider.dart';

// DAta
import '../data/category_data.dart';

// Model
import '../models/category_model.dart';

class AddBuyerRequest extends StatefulWidget {
  @override
  _AddBuyerRequestState createState() => _AddBuyerRequestState();
}

class _AddBuyerRequestState extends State<AddBuyerRequest> {
  final _formKey = GlobalKey<FormState>();
  // List<String> _colors = <String>['', 'red', 'green', 'blue', 'orange'];
  // String _color = '';
  final AuthService _auth = AuthService();
  var userinfo;
  String buyerFoodItemRequired;
  String buyerName;
  String buyerPhoneNumber;
  String buyerAddress;
  String buyerPrice;
  String buyerDescription;
  bool documentRetrieval = false;
  final DatabaseService _database = DatabaseService();
  String id;
  bool loading = true;
  Future retrieveDocument(String id) async {
    userinfo = await _database.getSellerInfo(id);
    // return Loading();
    // print(userinfo.toString());
    setState(() {
      print("Username");
      print(userinfo['username']);
      loading = false;
    });
  }

  // Future retrieveDocument2(
  //     String id, CollectionReference documentCollection) async {
  //   DocumentSnapshot documentData = await documentCollection.document(id).get();
  //   documentData.data.forEach((key, value) {
  //     print(value);
  //   });
  // }

  // final BuyerRequests request = BuyerRequests();
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    id = user.uid;

    if (loading) {
      retrieveDocument(id);
      return Loading();
    } else {
      return new Scaffold(
          appBar: AppBar(
            leading: IconButton(
              icon: Icon(
                Icons.arrow_back,
                color: Colors.black,
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            title: Text(
              "     Enter Your Request",
              style:
                  TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
            ),
            backgroundColor: Colors.white,
          ),
          body: new SafeArea(
              top: false,
              bottom: false,
              child: new Form(
                  key: _formKey,
                  autovalidate: true,
                  child: new ListView(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    children: <Widget>[
                      Divider(
                        height: 10.0,
                        // color: Colors.grey,
                      ),
                      new TextFormField(
                        decoration: const InputDecoration(
                          icon: const Icon(Icons.title),
                          hintText: 'Enter your title of food',
                          labelText: 'Food Title',
                        ),
                        onChanged: (value) {
                          setState(() {
                            buyerFoodItemRequired = value;
                          });
                        },
                      ),
                      new TextFormField(
                        decoration: const InputDecoration(
                          icon: const Icon(
                            Icons.description,
                          ),
                          hintText: 'Enter your Description',
                          labelText: 'Description',
                        ),
                        // keyboardType: TextInputType.datetime,
                        maxLines: 4,
                        onChanged: (value) {
                          setState(() {
                            buyerDescription = value;
                          });
                        },
                      ),
                      new TextFormField(
                        decoration: const InputDecoration(
                          icon: const Icon(Icons.add_location),
                          hintText: 'Enter your Address',
                          labelText: 'Address',
                        ),
                        // keyboardType: TextInputType.datetime,
                        maxLines: 3,
                        onChanged: (value) {
                          setState(() {
                            buyerAddress = value;
                          });
                        },
                      ),
                      // new TextFormField(
                      //   decoration: const InputDecoration(
                      //     icon: const Icon(Icons.phone),
                      //     hintText: 'Enter a phone number',
                      //     labelText: 'Phone',
                      //   ),
                      //   keyboardType: TextInputType.phone,
                      //   inputFormatters: [
                      //     // WhitelistingTextInputFormatter.digitsOnly,
                      //   ],
                      // ),
                      // new TextFormField(
                      //   decoration: const InputDecoration(
                      //     icon: const Icon(Icons.email),
                      //     hintText: 'Enter a email address',
                      //     labelText: 'Email',
                      //   ),
                      //   keyboardType: TextInputType.emailAddress,
                      // ),
                      new TextFormField(
                        decoration: const InputDecoration(
                          icon: const Text("Rs :"),
                          hintText: 'Enter the Price',
                          labelText: 'Price',
                        ),
                        keyboardType: TextInputType.phone,
                        onChanged: (value) {
                          setState(() {
                            buyerPrice = value.toString();
                          });
                        },
                      ),
                      // new FormField(
                      //   builder: (FormFieldState state) {
                      //     return InputDecorator(
                      //       decoration: InputDecoration(
                      //         icon: const Icon(Icons.color_lens),
                      //         labelText: 'Color',
                      //       ),
                      //       isEmpty: _color == '',
                      //       child: new DropdownButtonHideUnderline(
                      //         child: new DropdownButton(
                      //           value: _color,
                      //           isDense: true,
                      //           onChanged: (String newValue) {
                      //             setState(() {
                      //               // newContact.favoriteColor = newValue;
                      //               _color = newValue;
                      //               state.didChange(newValue);
                      //             });
                      //           },
                      //           items: _colors.map((String value) {
                      //             return new DropdownMenuItem(
                      //               value: value,
                      //               child: new Text(value),
                      //             );
                      //           }).toList(),
                      //         ),
                      //       ),
                      //     );
                      //   },
                      // ),
                      new Container(
                          padding: const EdgeInsets.only(left: 40.0, top: 20.0),
                          child: new RaisedButton(
                              color: Colors.blueAccent[20],
                              child: const Text('Submit Your Request'),
                              onPressed: () async {
                                print(userinfo);
                                return await BuyerRequests(uid: user.uid)
                                    .addBuyerReuest(
                                        buyerFoodItemRequired,
                                        userinfo['username'],
                                        userinfo['phoneNo'],
                                        userinfo['img'],
                                        buyerAddress,
                                        buyerPrice,
                                        buyerDescription)
                                    .then(
                                        (value) => Navigator.of(context).pop());
                              })),
                    ],
                  ))));
    }
  }
}
