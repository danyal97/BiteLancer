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
      String foodDescription, String price, String image) async {
    QuerySnapshot docs = await foodItems.getDocuments();
    var listdocs = _userFromFoodList(docs);
    bool documentIdFound = false;
    for (var doc in listdocs) {
      if (doc.uid == uid) {
        documentIdFound = true;
        break;
      }
    }
    // print("Image Path In Food Items");
    // print(image);
    // print("Image Path Found");
    if (documentIdFound) {
      return await foodItems
          .document(uid)
          .collection("FoodList")
          .document(foodTitle)
          .setData({
        'Category': foodCategory,
        'Description': foodDescription,
        'Price': price,
        'image': image,
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
        'image': image,
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
              description: foodTitles.data['Description'] ?? " ",
              image: foodTitles.data['image'] ?? ""),
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

  Future updateFoodPicture(String uid, String img, String foodTitle) async {
    try {
      print("Update Called");
      return await foodItems
          .document(uid)
          .collection("FoodList")
          .document(foodTitle)
          .setData({'image': img});
    } catch (e) {
      print(e.toString());
      return e.toString();
    }
  }
}
