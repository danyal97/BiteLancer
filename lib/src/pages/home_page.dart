// import 'dart:html';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:foodfreelancing/src/models/user.dart';
import 'package:foodfreelancing/src/scoped-model/main_model.dart';
import 'package:foodfreelancing/src/shared/loading.dart';
import 'package:foodfreelancing/src/widgets/bought_foods(2).dart';
import 'package:provider/provider.dart';
// import 'package:foodfreelancing/src/widgets/bought_foods(2).dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:foodfreelancing/src/widgets/home_top_info.dart';
import 'package:foodfreelancing/src/widgets/food_category.dart';
import 'package:foodfreelancing/src/widgets/search_file.dart';
import '../data/food_data.dart';
// Model
import '../models/food_model.dart';
import '../models/request_model.dart';
class HomePage extends StatefulWidget {
  // final FoodModel foodModel;

  // HomePage(this.foodModel);
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool loading = false;
  List<Food> _foods;
  List<Food> _foods2 = foods;

  @override
  void initState() {
    // widget.foodModel.fetchFoods();
    super.initState();
  }

  QuerySnapshot docs;

  Future retrieve() async {
    QuerySnapshot querySnapshot =
        await Firestore.instance.collection("BuyerRequestAll").getDocuments();
    var list = querySnapshot.documents;

    print("dsdasdasdasd");
    print(list.length);
    setState(() {
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    return StreamBuilder<QuerySnapshot>(
        stream: Firestore.instance.collection('BuyerRequestAll').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData && snapshot.data.documents.length > 0) {
            List<Request> request = snapshot.data.documents
                .map((buyer) => Request(
                      id: buyer.data['UID'],
                      requestID: buyer.documentID,
                      name: buyer.data['Name'],
                      imagePath: buyer.data['image'],
                      address: buyer.data['Address'],
                      title: buyer.data['Item'],
                      price: double.parse(buyer.data['Price']),
                      description: buyer.data['Description'],
                    ))
                .toList();

            return Scaffold(
              backgroundColor: Colors.white,
              body: ListView(
                padding: EdgeInsets.only(left: 20.0, right: 20.0),
                children: <Widget>[
                  HomeTopInfo(),
                  FoodCategory(),
                  SizedBox(
                    height: 20.0,
                  ),
                  SearchField(),
                  SizedBox(
                    height: 20.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        "Frequently Bought Foods",
                        style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          print("I' pressed");
                        },
                        child: Text(
                          "View all",
                          style: TextStyle(
                            color: Colors.orangeAccent,
                            fontWeight: FontWeight.bold,
                            fontSize: 18.0,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20.0),
                  //ScopedModelDescendant<MainModel>(
                  // builder: (BuildContext context, Widget child, MainModel model) {
                  //return
                  Column(
                    children: request.map(_buildFoodItems).toList(),
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
        bool buyerNotFound = true;
        bool sellerNotFound = true;
        bool bothNotFound = true;
        if (snapshot.data != null) {
          snapshot.data.documents.forEach((element) {
            buyerNotFound = true;
            sellerNotFound = true;
            element.data.forEach((key, value) {
              if (key == 'SellerUid') {
                if (user.uid == value) {
                  print(user.uid);
                  print(value);
                  sellerNotFound = false;
                }
              }
              if (key == 'RequestUid') {
                if (food.requestID == value) {
                  print(value);
                  print(food.id);
                  buyerNotFound = false;
                }
              }
            });
            if (!buyerNotFound) {
              if (!sellerNotFound) {
                bothNotFound = false;
              }
            }
          });
        }

        print("Printing Buyer Found");
        print(bothNotFound);
        print("Buyer Found");
        if (bothNotFound) {
          return Container(
            margin: EdgeInsets.only(bottom: 20.0),
            child: BoughtFood(
              id: food.id,
              requestID:food.requestID,
              name: food.name,
              imagePath: food.imagePath,
             address: food.address,
              title: food.title,
              price: food.price.toDouble(),
              description: food.description,
            ),
          );
        } else {
          return Container();
        }
      });
}
// }
