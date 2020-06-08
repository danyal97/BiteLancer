import 'package:flutter/material.dart';
import 'package:foodfreelancing/src/models/user.dart';
import 'package:foodfreelancing/src/services/SellerRequest.dart';
import 'package:provider/provider.dart';

class BoughtFood extends StatefulWidget {
  final String id;
  final String name;
  final String imagePath;
  final String category;
  final double price;
  final double discount;
  final String ratings;

  BoughtFood(
      {this.id,
      this.name,
      this.imagePath,
      this.category,
      this.price,
      this.discount,
      this.ratings});

  @override
  _BoughtFoodState createState() => _BoughtFoodState();
}

class _BoughtFoodState extends State<BoughtFood> {
  var cardText = TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold);

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    return ClipRRect(
      borderRadius: BorderRadius.all(
        Radius.circular(10.0),
      ),
      child: Stack(
        children: <Widget>[
          Container(
            height: 230.0,
            width: 340.0,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(60.0),
              boxShadow: [
                BoxShadow(
                    blurRadius: 3.0,
                    offset: Offset(0, 4.0),
                    color: Colors.black38),
              ],
              image: DecorationImage(
                image: NetworkImage(widget.imagePath),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Positioned(
            left: 0.0,
            bottom: 0.0,
            width: 340.0,
            height: 70.0,
            child: Container(
              decoration: BoxDecoration(),
            ),
          ),
          Positioned(
            left: 10.0,
            bottom: 60.0,
            right: 10.0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    //Row(
                    // children: <Widget>[
                    Row(
                      children: <Widget>[
                        Text(
                          "Name: ",
                          style: TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                            fontStyle: FontStyle.italic,
                            // backgroundColor: Colors.white
                          ),
                        ),
                        Text(
                          widget.name,
                          style: TextStyle(
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.blue,
                              fontStyle: FontStyle.italic,
                              backgroundColor: Colors.white),
                        )
                      ],
                    ),
                    Divider(
                      height: 2.0,
                    ),

                    //     RaisedButton(
                    //       elevation: 5.0,
                    //       onPressed: () => print("Button Pressed"),
                    //       padding: EdgeInsets.all(2.0),
                    //       child: new Text("Send Req"),
                    //     ),
                    //   ],
                    // ),
                    Container(
                      width: 200,
                      child: Row(
                        children: <Widget>[
                          Text(
                            "Address: ",
                            style: TextStyle(
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                              fontStyle: FontStyle.italic,
                              // backgroundColor: Colors.white
                            ),
                          ),
                          Text(
                            widget.category,
                            style: TextStyle(
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.blue,
                                fontStyle: FontStyle.italic,
                                backgroundColor: Colors.white),
                          )
                        ],
                      ),
                    ),
                    Divider(
                      height: 2.0,
                    ),
                    Container(
                      width: 200,
                      child: Row(
                        children: <Widget>[
                          Text(
                            "Description: ",
                            style: TextStyle(
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                              fontStyle: FontStyle.italic,
                              // backgroundColor: Colors.white
                            ),
                          ),
                          Text(
                            widget.ratings,
                            style: TextStyle(
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.blue,
                                fontStyle: FontStyle.italic,
                                backgroundColor: Colors.white),
                          )
                        ],
                      ),
                    ),
                    Divider(
                      height: 5.0,
                    ),
                    Container(
                      width: 200,
                      child: Row(
                        children: <Widget>[
                          Text(
                            "Price: ",
                            style: TextStyle(
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                              fontStyle: FontStyle.italic,
                              // backgroundColor: Colors.white
                            ),
                          ),
                          Text(
                            "Rs. " + widget.price.toString(),
                            style: TextStyle(
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.red,
                                fontStyle: FontStyle.italic,
                                backgroundColor: Colors.white),
                          )
                        ],
                      ),
                    ),

                    // Text(
                    //   "Price:  : " + widget.price.toString() + "",
                    //   style: TextStyle(color: Colors.white),
                    // ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    RaisedButton(
                        elevation: 10.0,
                        color: Colors.blue,
                        onPressed: () {
                          SellerRequests(uid: user.uid).addSellerReuest(
                              widget.name,
                              widget.imagePath,
                              "I want To Provide Services to you",
                              user.uid,
                              widget.id);
                        },
                        padding: EdgeInsets.all(5.0),
                        child: new Text("Send Req",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 15.0,
                              fontWeight: FontWeight.bold,
                            )),
                        shape: RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(18.0),
                          side: BorderSide(color: Colors.blue[50]),
                        )),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
