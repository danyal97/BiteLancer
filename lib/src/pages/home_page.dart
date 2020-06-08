// import 'dart:html';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:foodfreelancing/src/scoped-model/main_model.dart';
import 'package:foodfreelancing/src/shared/loading.dart';
import 'package:foodfreelancing/src/widgets/bought_foods.dart';
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
    // if (loading) {
    //   // retrieve3();
    //   return Loading();
    // } else {
    return StreamBuilder<QuerySnapshot>(
        stream: Firestore.instance.collection('BuyerRequestAll').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData && snapshot.data.documents.length > 0) {
            List<Food> foods3 = snapshot.data.documents
                .map((buyer) => Food(
                      id: buyer.documentID,
                      name: buyer.data['Name'],
                      imagePath: _foods2[1].imagePath,
                      category: buyer.data['Address'],
                      discount: 20,
                      price: double.parse(buyer.data['Price']),
                      ratings: buyer.data['Description'],

                      // title: foodTitles.documentID ?? " ",
                      // price: foodTitles.data['Price'] ?? 0,
                      // category: foodTitles.data['Category'] ?? " ",
                      // description: foodTitles.data['Description'] ?? " ",
                      // image: foodTitles.data['image'] ?? ""),
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
}
// }
