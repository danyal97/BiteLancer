// import 'dart:html';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:foodfreelancing/src/scoped-model/main_model.dart';
import 'package:foodfreelancing/src/shared/loading.dart';
import 'package:foodfreelancing/src/widgets/bought_foods(3).dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:foodfreelancing/src/widgets/home_top_info.dart';
import 'package:foodfreelancing/src/widgets/food_category.dart';
import 'package:foodfreelancing/src/widgets/search_file.dart';
import '../data/food_data.dart';
// Model
import '../models/food_model.dart';
import 'package:provider/provider.dart';
import 'package:foodfreelancing/src/models/user.dart';
import 'package:foodfreelancing/src/models/buyer_request.dart';
import '../models/request_model.dart';

class BuyerExplorerPage extends StatefulWidget {
  @override
  _BuyerExplorerPageState createState() => _BuyerExplorerPageState();
}

class _BuyerExplorerPageState extends State<BuyerExplorerPage> {
  bool loading = true;
  List<Food> _foods;
  List<Food> _foods2 = foods;
  final textStyle = TextStyle(fontSize: 32.0, fontWeight: FontWeight.bold);
  @override
  void initState() {
    super.initState();
  }

  QuerySnapshot docs;
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    return StreamBuilder<QuerySnapshot>(
        stream: Firestore.instance.collection('Seller').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData && snapshot.data.documents.length > 0) {
            List<Request> requests = snapshot.data.documents
                .map(
                  (seller) => Request(
                    id: seller.documentID,
                    requestID: "",
                    name: seller.data['username'],
                    imagePath: seller.data['img'],
                    address: seller.data['Address'] ?? "",
                    title: "",
                    price: 34,
                    description: "",
                  ),
                )
                .toList();
            print(requests.length);
            return Scaffold(
              backgroundColor: Colors.white,
              body: ListView(
                padding: EdgeInsets.only(left: 20.0, right: 20.0),
                children: <Widget>[
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Text("Seller Request", style: textStyle),
                    ],
                  ),

                  // SizedBox(
                  //   height: 20.0,
                  // ),

                  SizedBox(
                    height: 20.0,
                  ),

                  SizedBox(height: 20.0),
                  //ScopedModelDescendant<MainModel>(
                  // builder: (BuildContext context, Widget child, MainModel model) {
                  //return

                  Column(
                    children: requests.map(_buildFoodItems).toList(),
                  ),

                  //},
                  //),
                ],
              ),
            );
          } else {
            return Container(
              width: 0.0,
              height: 0.0,
            );
          }
        });
  }
}

Widget _buildFoodItems(Request food) {
  return StreamBuilder<QuerySnapshot>(
      stream: Firestore.instance.collection("SellerRequest").snapshots(),
      builder: (context, snapshot) {
        final user = Provider.of<User>(context);
        bool buyerFound = false;
        bool sellerFound = false;
        bool bothFound = false;
        if (snapshot.data != null) {
          snapshot.data.documents.forEach((element) {
            buyerFound = false;
            sellerFound = false;
            element.data.forEach((key, value) {
              if (key == 'BuyerUid') {
                if (user.uid == value) {
                  print("Buyer Id: ");
                  // print(user.uid);
                  print(value);
                  print(user.uid);
                  buyerFound = true;
                }
              }
              if (key == 'SellerUid') {
                if (food.id == value) {
                  print(value);
                  print(food.id);
                  sellerFound = true;
                }
              }
            });
            if (buyerFound) {
              if (sellerFound) {
                bothFound = true;
              }
            }
          });
        }

        // print("Printing Buyer Found");
        // print(bothNotFound);
        // print("Buyer Found");
        if (bothFound) {
          return Container(
            margin: EdgeInsets.only(bottom: 20.0),
            child: BoughtFood(
              id: food.id,
              // requestID: food.requestID,
              name: food.name,
              imagePath: food.imagePath,
              address: food.address,
              title: food.title,
              // price: food.price.toDouble(),
              description: "I want To Provide Services to you",
            ),
          );
        } else {
          return Container();
        }
      });
}
