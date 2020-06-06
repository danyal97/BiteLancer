import 'dart:async';

import 'package:foodfreelancing/src/models/fooditemslist.dart';
// import 'package:foodfreelancing/src/screens/home/food_item_list.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:foodfreelancing/src/models/user.dart';

class FoodItems {
  final String uid;
  String categoryName;
  String titleName;
  String priceName;
  String descriptionName;

  FoodItems({this.uid});
  final CollectionReference foodItems = Firestore.instance.collection("Task");
  Future addFoodItems(String foodTitle, String foodCategory,
      String foodDescription, String price) async {
    QuerySnapshot docs = await foodItems.getDocuments();
    var listdocs = _userFromFoodList(docs);
    bool documentIdFound = false;
    for (var doc in listdocs) {
      if (doc.uid == uid) {
        documentIdFound = true;
        break;
      }
    }
    if (documentIdFound) {
      return await foodItems
          .document(uid)
          .collection("FoodList")
          .document(foodTitle)
          .setData({
        'Category': foodCategory,
        'Description': foodDescription,
        'Price': price,
      });
    } else {
      return await foodItems
          .document(uid)
          .collection("FoodList")
          .document(foodTitle)
          .setData({
        'Category': foodCategory,
        'Description': foodDescription,
        'Price': price,
      });
    }
  }

  List<User> _userFromFoodList(QuerySnapshot docs) {
    return docs.documents.map((doc) => User(uid: doc.documentID)).toList();
  }

  List<FoodItemsList> _foodItemListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.documents
        .map(
          (foodTitles) => FoodItemsList(
              title: foodTitles.documentID ?? " ",
              price: foodTitles.data['Price'] ?? 0,
              category: foodTitles.data['Category'] ?? " ",
              description: foodTitles.data['Description'] ?? " "),
        )
        .toList();
  }

  Stream<List<FoodItemsList>> get foodItemslist {
    return foodItems
        .document(uid)
        .collection("FoodList")
        .snapshots()
        .map((event) => _foodItemListFromSnapshot(event));
  }

  List<FoodItemsList> get initialFoodList {
    List<FoodItemsList> r;
    StreamSubscription<QuerySnapshot> snapshot = foodItems
        .document(uid)
        .collection("FoodList")
        .snapshots()
        .listen((event) {
      r = event.documents.map((foodTitles) => FoodItemsList(
          title: foodTitles.documentID ?? " ",
          price: foodTitles.data['Price'] ?? 0,
          category: foodTitles.data['Category'] ?? " ",
          description: foodTitles.data['Description'] ?? " "));
    });
    return r;
  }

  Future<List<User>> get allDocumentIds async {
    QuerySnapshot docs = await foodItems.getDocuments();
    var listdocs = _userFromFoodList(docs);
    List<User> docids;
    for (var doc in listdocs) {
      docids.add(User(uid: doc.uid));
    }
    return docids;
  }
}
