import 'package:foodfreelancing/src/models/fooditems.dart';
// import 'package:foodfreelancing/src/screens/home/food_item_list.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  final String uid;
  DatabaseService({this.uid});
  final CollectionReference userName =
      Firestore.instance.collection("UserName");

  Future updateUsername(String name) async {
    return await userName.document(uid).setData({
      'username': name,
    });
  }

  // List<FoodItems> _foodItemListFromSnapshot(QuerySnapshot snapshot) {
  //   return snapshot.documents
  //       .map((doc) => FoodItems(
  //           name: doc.data['name'] ?? " ", price: doc.data['price'] ?? 0))
  //       .toList();
  // }

  // Stream<List<FoodItems>> get foodItems {
  //   return homeFood
  //       .snapshots()
  //       .map((event) => _foodItemListFromSnapshot(event));
  // }
}
