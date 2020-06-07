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
import 'package:provider/provider.dart';
import 'package:foodfreelancing/src/models/user.dart';
import 'package:foodfreelancing/src/models/buyer_request.dart';
class BuyerHomePage extends StatefulWidget {
  // final FoodModel foodModel;

  // HomePage(this.foodModel);
  @override
  _BuyerHomePageState createState() => _BuyerHomePageState();
}

class _BuyerHomePageState extends State< BuyerHomePage> {
   bool loading = true;
  List<Food> _foods;
  List<Food> _foods2 = foods;

  @override
  void initState() {
    // widget.foodModel.fetchFoods();
    super.initState();
  }

  QuerySnapshot docs;

  // Future retrieveBuyerDocuments() async {
  //  return await Firestore.instance.collection("BuyerRequest").getDocuments();
  //   // print("Document Printing Called");
  //   // // print(doc.documents.length);
  //   // print("Document Printing Called");
  //   // // var documents=document.documents;
  //   //
  // }

  Future retrieve() async {
    QuerySnapshot querySnapshot = await Firestore.instance.collection("BuyerRequestAll").getDocuments();
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
          stream: Firestore.instance.collection('BuyerRequest').document(user.uid)
            .collection('Requests')
            .snapshots(),
          builder: (context, snapshot) {
           if (snapshot.hasData && snapshot.data.documents.length > 0) {
             List<Food> requests = snapshot.data.documents
                .map((buyer) => Food(
                      id: buyer.documentID,
                      name: buyer.data['Name'],
                      imagePath: _foods2[1].imagePath,
                      category: buyer.data['Address'],
                      discount: 20,
                      price: double.parse(buyer.data['Price']),
                      ratings: buyer.data['Description'],

                     
                    ))
                .toList();
            print(requests.length);
              // snapshot.data.documents.forEach((document) {
              //   print(document.data['Name']);
              // });
              return Scaffold(
                backgroundColor: Colors.white,
                body: ListView(
                  padding: EdgeInsets.only(left: 20.0, right: 20.0),
                  children: <Widget>[
                    HomeTopInfo(),
                    SizedBox(
                      height: 20.0,
                    ),
                    // SearchField(),
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
                      
                      children:
                       requests.map(_buildFoodItems).toList(),
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
      price: food.price.toDouble(),
      ratings: food.ratings,
    ),
  );
}