import 'package:flutter/material.dart';

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
    return ClipRRect(
      borderRadius: BorderRadius.all(
        Radius.circular(10.0),
      ),
      child: Stack(
        children: <Widget>[
          Container(
            height: 230.0,
            width: 340.0,
            child: Image.asset(
              widget.imagePath,
              fit: BoxFit.cover,
            ),
          ),
          Positioned(
            left: 0.0,
            bottom: 0.0,
            width: 340.0,
            height: 70.0,
            child: Container(
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                      colors: [])),
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
                    Text(
                      "Name: " + widget.name + "",
                      style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.w600,
                          color: Colors.accents[5]),
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
                      child: Text(
                        "Address: " + widget.category + "",
                        style: TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.w500,
                            color: Colors.indigo),
                        maxLines: 13,
                      ),
                    ),
                    Divider(
                      height: 2.0,
                    ),
                    Container(
                      width: 200,
                      child: Text(
                        "Description: " + widget.ratings + "",
                        style: TextStyle(
                            fontSize: 13.0,
                            fontWeight: FontWeight.w800,
                            color: Colors.brown[600]),
                        maxLines: 13,
                      ),
                    ),
                    Divider(
                      height: 5.0,
                    ),
                    Container(
                      width: 200,
                      child: Text(
                        "Price: Rs " + widget.price.toString() + "",
                        style: TextStyle(
                            fontSize: 13.0,
                            fontWeight: FontWeight.w900,
                            color: Colors.deepPurple),
                        maxLines: 13,
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
                        elevation: 5.0,
                        color: Colors.yellow,
                        onPressed: () => print("Button Pressed"),
                        padding: EdgeInsets.all(2.0),
                        child: new Text("Send Req"),
                        shape: RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(18.0),
                          side: BorderSide(color: Colors.yellow[50]),
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
