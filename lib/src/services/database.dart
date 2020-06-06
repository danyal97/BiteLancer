// import 'package:foodfreelancing/src/models/fooditems.dart';
// import 'package:foodfreelancing/src/screens/home/food_item_list.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
class DatabaseService {
  final String uid;
  DatabaseService({this.uid});
  final CollectionReference sellerCollection = Firestore.instance.collection("Seller");
  final CollectionReference buyerCollection = Firestore.instance.collection("Buyer");

  Future addSeller(String name) async {
    print("Update Username Called");
    return await sellerCollection.document(uid).setData({
      'username': name,
      'rating':5,
      'phoneNo':null,
      'Address':null,
      'verified':false,
      'img':'https://firebasestorage.googleapis.com/v0/b/foodfreelancing.appspot.com/o/profilepictures%2Favatar.png?alt=media&token=6d1b2f61-f681-46f8-8292-c68c9b797c85',
    });
  }
  Future addBuyer(String name) async {
      print("Update Username Called");
      return await buyerCollection.document(uid).setData({
        'username': name,
        'rating':5,
        'phoneNo':null,
        'Address':null,
        'verified':false,
        'img':'https://firebasestorage.googleapis.com/v0/b/foodfreelancing.appspot.com/o/profilepictures%2Favatar.png?alt=media&token=6d1b2f61-f681-46f8-8292-c68c9b797c85',
      });
    }

  Future getSellerInfo(String uid) async {
    try {
      String type = await getType(uid);
      if(type == "Buyer" ){
          print("Buyer Called");
        return await DatabaseService(uid:uid).buyerCollection.document(uid)
              .get()
              .then((DocumentSnapshot ds) {
                print(ds.data['username']);
                return ds.data;
            // use ds as a snapshot
          });
      }
      else{
        return await DatabaseService(uid:uid).sellerCollection.document(uid)
              .get()
              .then((DocumentSnapshot ds) {
                print(ds.data['username']);
                return ds.data;
            // use ds as a snapshot
          });
      }
      // final snapShot = await DatabaseService(uid:uid).sellerCollection.document(uid).get();
      // if (snapShot == null || !snapShot.exists) {
      //   // Document with id == docId doesn't exist.
      //    print("Buyer Called");
      //    return await DatabaseService(uid:uid).buyerCollection.document(uid)
      //         .get()
      //         .then((DocumentSnapshot ds) {
      //           print(ds.data['username']);
      //           return ds.data;
      //       // use ds as a snapshot
      //     });
      // }
      // else{
      //    print("Seller Called");
      //    return  snapShot.data;
      // }
      
    } catch (e) {
      print(e.toString());
      return e.toString();
    }
  }

  Future<String> getType(String uid) async{
      try {
      final snapShot = await DatabaseService(uid:uid).sellerCollection.document(uid).get();
      if (snapShot == null || !snapShot.exists) {

        return "Buyer";
      }
      else{
         return "Seller";
      }
      
    } catch (e) {
      print(e.toString());
      return e.toString();
    }
  }
Future updateProfilePicture(String uid,String img) async {
      try {
        
        print("Update Called");
      String type = await getType(uid);
      if(type == "Buyer" ){
          print("Buyer Called");
          return await DatabaseService(uid:uid).buyerCollection.document(uid).updateData(
          {
            "img":img
          }
          );
      }
      else{
        return await DatabaseService(uid:uid).sellerCollection.document(uid).updateData(
          {
            "img":img
          }
          );
      }
    } catch (e) {
      print(e.toString());
      return e.toString();
    }
        
}

Future updateProfile(String phone,String address) async {
      try {
         print("Update Profile Called");
         print(phone);
          print(address);
        FirebaseUser user = await FirebaseAuth.instance.currentUser();
      String type = await getType(user.uid);
      if(type == "Buyer" ){
          print("Buyer Called");
          return await DatabaseService(uid:user.uid).buyerCollection.document(user.uid).updateData(
          {
            'phoneNo':phone,
            'Address':address,
            'verified':true,
          }
          );
      }
      else{
         print("Seller Called");
        return await DatabaseService(uid:user.uid).sellerCollection.document(user.uid).updateData(
          {
            'phoneNo':phone,
        'Address':address,
        'verified':true,
          }
          );
      }
    } catch (e) {
      print(e.toString());
      return e.toString();
    }
        
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
