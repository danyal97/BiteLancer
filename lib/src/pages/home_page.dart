// import 'dart:html';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:foodfreelancing/src/models/user.dart';
import 'package:foodfreelancing/src/scoped-model/main_model.dart';
import 'package:foodfreelancing/src/shared/loading.dart';
import 'package:foodfreelancing/src/widgets/bought_foods.dart';
import 'package:provider/provider.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:foodfreelancing/src/widgets/home_top_info.dart';
import 'package:foodfreelancing/src/widgets/food_category.dart';
import 'package:foodfreelancing/src/widgets/search_file.dart';
import '../data/food_data.dart';
// Model
import '../models/food_model.dart';

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
            List<Food> foods3 = snapshot.data.documents
                .map((buyer) => Food(
                      id: buyer.data['UID'],
                      name: buyer.data['Name'],
                      imagePath: _foods2[1].imagePath,
                      category: buyer.data['Address'],
                      discount: 20,
                      price: double.parse(buyer.data['Price']),
                      ratings: buyer.data['Description'],
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
                    children: foods3.map(_buildFoodItems).toList(),
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

Widget _buildFoodItems(Food food) {
  return StreamBuilder<QuerySnapshot>(
      stream: Firestore.instance.collection("SellerRequest").snapshots(),
      builder: (context, snapshot) {
        final user = Provider.of<User>(context);
        bool buyerFound = true;
        bool sellerFound = true;
        if (snapshot.data.documents.length != null) {
          snapshot.data.documents.forEach((element) {
            element.data.forEach((key, value) {
              if (key == 'SellerUid') {
                if (user.uid == value) {
                  print(user.uid);
                  print(value);
                  sellerFound = false;
                }
              }
              if (key == 'BuyerUid') {
                if (food.id == value) {
                  print(value);
                  print(food.id);
                  buyerFound = false;
                }
              }
            });
          });
        }

        print("Printing Buyer Found");
        print(sellerFound);
        print(buyerFound);
        print("Buyer Found");
        if ((buyerFound || sellerFound)) {
          return Container(
            margin: EdgeInsets.only(bottom: 20.0),
            child: BoughtFood(
              id: food.id,
              name: food.name,
              imagePath:
                  "https://firebasestorage.googleapis.com/v0/b/foodfreelancing.appspot.com/o/Foodpictures%2Fbasil-dinner-food-background-red_1220-1023.jpg?alt=media&token=fc91c272-587f-415d-bc34-cc670d765ebc",
              category: food.category,
              discount: food.discount,
              price: food.price.toDouble(),
              ratings: food.ratings,
            ),
          );
        } else {
          return Container();
        }
      });
}
// }
