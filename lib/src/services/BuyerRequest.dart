import 'dart:async';

import 'package:foodfreelancing/src/models/buyer_request.dart';
// import 'package:foodfreelancing/src/screens/home/food_item_list.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:foodfreelancing/src/models/user.dart';
import 'package:random_string/random_string.dart';

class BuyerRequests {
  final String uid;
  BuyerRequests({
    this.uid,
  });

  final CollectionReference buyerRequest =
      Firestore.instance.collection("BuyerRequest");
  final CollectionReference buyerRequestAll =
      Firestore.instance.collection("BuyerRequestAll");
  Future addBuyerReuest(
    final String buyerFoodItemRequired,
    final String buyerName,
    final String buyerPhoneNumber,
    final String buyerImage,
    final String buyerAddress,
    final String buyerPrice,
    final String buyerDescription,
  ) async {
    QuerySnapshot docs = await buyerRequest.getDocuments();
    var listdocs = _userFromBuyerList(docs);

    bool documentIdFound = false;
    for (var doc in listdocs) {
      if (doc.uid == uid) {
        documentIdFound = true;
        break;
      }
    }
    await buyerRequestAll.document(uid + randomAlphaNumeric(10)).setData({
      'Name': buyerName,
      'Address': buyerAddress ?? "",
      'image': buyerImage,
      'PhoneNumber': buyerPhoneNumber ?? "",
      'Price': buyerPrice,
      'Description': buyerDescription ?? "",
      'Item': buyerFoodItemRequired,
      'UID':uid,
    });
    if (documentIdFound) {
      return await buyerRequest
          .document(uid)
          .collection("Requests")
          .document(buyerFoodItemRequired)
          .setData({
        'Name': buyerName,
        'Address': buyerAddress ?? "",
        'image': buyerImage ?? "",
        'PhoneNumber': buyerPhoneNumber ?? "",
        'Price': buyerPrice,
        'Description': buyerDescription ?? "",
        'Item': buyerFoodItemRequired,
      });
    } else {
      return await buyerRequest
          .document(uid)
          .collection("Requests")
          .document(buyerFoodItemRequired)
          .setData({
        'Name': buyerName,
        'Address': buyerAddress ?? "",
        'image': buyerImage ?? "",
        'PhoneNumber': buyerPhoneNumber ?? "",
        'Price': buyerPrice,
        'Description': buyerDescription ?? "",
        'Item': buyerFoodItemRequired,
      });
    }
  }

  List<User> _userFromBuyerList(QuerySnapshot docs) {
    return docs.documents.map((doc) => User(uid: doc.documentID)).toList();
  }
}
