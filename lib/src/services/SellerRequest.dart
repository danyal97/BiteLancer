import 'dart:async';

import 'package:foodfreelancing/src/models/buyer_request.dart';
// import 'package:foodfreelancing/src/screens/home/food_item_list.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:foodfreelancing/src/models/user.dart';
import 'package:random_string/random_string.dart';

class SellerRequests {
  final String uid;
  SellerRequests({
    this.uid,
  });
  final CollectionReference sellerRequest =
      Firestore.instance.collection("SellerRequest");
  Future addSellerReuest(
    final String sellerName,
    final String sellerImage,
    final String sellerChat,
    final String selleruid,
    final String buyeruid,
  ) async {
    return await sellerRequest
        .document(selleruid + randomAlphaNumeric(10))
        .setData({
      'SellerName': sellerName ?? "",
      'BuyerUid': buyeruid ?? "",
      'SellerUid': selleruid ?? "",
      'SellerImage': sellerImage ?? "",
      'SellerChat': sellerChat ?? "",
    });
  }
}
