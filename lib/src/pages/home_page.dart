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
  List<Food> _foods = foods;

  @override
  void initState() {
    // widget.foodModel.fetchFoods();
    super.initState();
  }

  // QuerySnapshot docs;

  Future retrieveBuyerDocuments() async {
    return await Firestore.instance.collection("BuyerRequest").getDocuments();

    // print("Document Printing Called");
    // // print(doc.documents.length);
    // print("Document Printing Called");
    // // var documents=document.documents;
    // setState(() {
    //   loading = false;
    // });
  }

  Future retrieve() async {
    var d = await retrieveBuyerDocuments();
    print("dsdasdasdasd");
    print(d.documents.length);
  }

  bool loading = true;
  @override
  Widget build(BuildContext context) {
    if (loading) {
      retrieve();
      return Loading();
    } else {
      return StreamBuilder<QuerySnapshot>(
          // initialData: docs,
          stream: Firestore.instance.collection('BuyerRequest').snapshots(),
          builder: (context, snapshot) {
            print("Document Length");
            print(snapshot.data.documents.length);
            print("Document Length");
            if (snapshot.hasData && snapshot.data.documents.length > 0) {
              snapshot.data.documents.forEach((document) {
                print(document.data['username']);
              });
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
                      children: _foods.map(_buildFoodItems).toList(),
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
        imagePath: food.imagePath,
        category: food.category,
        discount: food.discount,
        price: food.price,
        ratings: food.ratings,
      ),
    );
  }
}
