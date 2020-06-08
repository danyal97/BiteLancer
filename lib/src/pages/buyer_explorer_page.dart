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
import 'dart:async';
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
        return StreamBuilder<QuerySnapshot>(
        stream: Firestore.instance.collection('SellerRequest').snapshots(),
        builder: (context, snapshot) {
           final user = Provider.of<User>(context);
          if (snapshot.hasData && snapshot.data.documents.length > 0) {
            List<Request> requests = snapshot.data.documents
                .map(
                  (seller) => Request(
                    id: seller.documentID,
                    requestID: seller.data['BuyerUid'],
                    name: seller.data['SellerUid'],
                    imagePath: seller.data['SellerImage'],
                    address: "",
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
      stream: Firestore.instance.collection("Seller").snapshots(),
      builder: (context, snapshot) {
        final user = Provider.of<User>(context);
        bool buyerFound = false;
        bool sellerFound = false;
        bool bothFound = false;
        var name ,img ,add;
        if (snapshot.data != null) {
          snapshot.data.documents.forEach((element) {
            buyerFound = false;
            sellerFound = false;
            if(element.documentID == food.name){
               sellerFound = true;
               name = element['username'];
               img = element['img'];
               add = element['Address'];
            }
        
            if (user.uid == food.requestID) {
              if (sellerFound) {
                bothFound = true;
              }
            }
          });
        }
        if (bothFound) {
          return Container(
            margin: EdgeInsets.only(bottom: 20.0),
            child: BoughtFood(
              id: food.id,
              // requestID: food.requestID,
              name: name,
              imagePath: img,
              address: add,
              title: " ",
              price: null,
              description: "I want To Provide Services to you",
            ),
          );
        } else {
          return Container();
        }
      });
}
