import 'package:foodfreelancing/src/models/fooditemslist.dart';
// import 'package:foodfreelancing/src/screens/home/food_item_list.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FoodItems {
  final String uid;
  FoodItems({this.uid});
  final CollectionReference foodItems =
      Firestore.instance.collection("Food List");

  Future addFoodItems(String foodTitle, String foodCategory,
      String foodDescription, double price) async {
    // print("Update Username Called");
    return await foodItems.document(uid).setData({
      'Title': foodTitle,
      'Category': foodCategory,
      'Description': foodDescription,
      'Price': price,
    });
  }

  List<FoodItemsList> _foodItemListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.documents
        .map((doc) => FoodItemsList(
            title: doc.data['Title'] ?? " ",
            price: doc.data['price'] ?? 0,
            category: doc.data['Category'] ?? " ",
            description: doc.data['Description'] ?? " "))
        .toList();
  }

  Stream<List<FoodItemsList>> get foodItemslist {
    return foodItems
        .snapshots()
        .map((event) => _foodItemListFromSnapshot(event));
  }

  // Stream<List<FoodItemsList>> get allfoodItemslist {
  //   return Firestore.instance
  //       .collection('Food List')
  //       .snapshots()
  //       .map((event) => _foodItemListFromSnapshot(event));
  // }
}
