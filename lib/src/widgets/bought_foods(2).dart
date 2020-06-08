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
    return Center(
      // borderRadius: BorderRadius.all(
      //   Radius.circular(10.0),
      // ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Stack(
          children: <Widget>[
            Container(
              height: 150,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(24),
                gradient: LinearGradient(
                    colors: [Colors.black, Colors.blueAccent],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight),
                boxShadow: [
                  BoxShadow(
                    color: Colors.blueGrey,
                    blurRadius: 12,
                    offset: Offset(0, 6),
                  ),
                ],
              ),
            ),
            CustomPaint(
                //painter: CustomCardShapePainter() ;
                ),
            // Positioned(
            //   left: 0.0,
            //   bottom: 0.0,
            //   width: 340.0,
            //   height: 80.0,
            //   child: Container(
            //     decoration: BoxDecoration(
            //         gradient: LinearGradient(
            //             begin: Alignment.bottomCenter,
            //             end: Alignment.topCenter,
            //             colors: [])),
            //   ),
            // ),

            Positioned.fill(
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: ClipOval(
                      child: Image.asset(
                        'assets/images/avatar.png',
                        fit: BoxFit.cover,
                        height: 80,
                        width: 40,
                      ),
                    ),
                    flex: 2,
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Expanded(
                    flex: 4,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          "items[index].name",
                          style: TextStyle(
                              color: Colors.white,
                              fontFamily: 'Avenir',
                              fontWeight: FontWeight.w700),
                        ),
                        Text(
                          "items[index].category",
                          style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'Avenir',
                          ),
                        ),
                        Text(
                          "items[index].category",
                          style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'Avenir',
                          ),
                        ),
                        SizedBox(height: 16),
                        Row(
                          children: <Widget>[
                            Icon(
                              Icons.location_on,
                              color: Colors.white,
                              size: 16,
                            ),
                            SizedBox(
                              width: 8,
                            ),
                            Flexible(
                              child: Text(
                                "items[index].location",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: 'Avenir',
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Text(
                          "Rs. 90",
                          style: TextStyle(
                            color: Colors.orangeAccent,
                            fontWeight: FontWeight.bold,
                            fontSize: 18.0,
                          ),
                        ),

                        SizedBox(
                          height: 20.0,
                        ),
                        RaisedButton(
                            elevation: 10.0,
                            color: Colors.blue,
                            onPressed: () => print("Button Pressed"),
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
                        // RatingBar(rating: items[index].rating),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            //   Positioned(
            //     left: 10.0,
            //     bottom: 60.0,
            //     right: 10.0,
            //     child: Row(
            //       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            //       children: <Widget>[
            //         Column(
            //           crossAxisAlignment: CrossAxisAlignment.start,
            //           children: <Widget>[
            //             //Row(
            //             // children: <Widget>[
            //             Row(
            //               children: <Widget>[
            //                 Text(
            //                   "Name: ",
            //                   style: TextStyle(
            //                     fontSize: 20.0,
            //                     fontWeight: FontWeight.bold,
            //                     color: Colors.black,
            //                     fontStyle: FontStyle.italic,
            //                     // backgroundColor: Colors.white
            //                   ),
            //                 ),
            //                 Text(
            //                   widget.name,
            //                   style: TextStyle(
            //                       fontSize: 20.0,
            //                       fontWeight: FontWeight.bold,
            //                       color: Colors.blue,
            //                       fontStyle: FontStyle.italic,
            //                       backgroundColor: Colors.white),
            //                 )
            //               ],
            //             ),
            //             Divider(
            //               height: 2.0,
            //             ),

            //             //     RaisedButton(
            //             //       elevation: 5.0,
            //             //       onPressed: () => print("Button Pressed"),
            //             //       padding: EdgeInsets.all(2.0),
            //             //       child: new Text("Send Req"),
            //             //     ),
            //             //   ],
            //             // ),
            //             Container(
            //               width: 200,
            //               child: Row(
            //                 children: <Widget>[
            //                   Text(
            //                     "Address: ",
            //                     style: TextStyle(
            //                       fontSize: 20.0,
            //                       fontWeight: FontWeight.bold,
            //                       color: Colors.black,
            //                       fontStyle: FontStyle.italic,
            //                       // backgroundColor: Colors.white
            //                     ),
            //                   ),
            //                   Text(
            //                     widget.category,
            //                     style: TextStyle(
            //                         fontSize: 20.0,
            //                         fontWeight: FontWeight.bold,
            //                         color: Colors.blue,
            //                         fontStyle: FontStyle.italic,
            //                         backgroundColor: Colors.white),
            //                   )
            //                 ],
            //               ),
            //             ),
            //             Divider(
            //               height: 2.0,
            //             ),
            //             Container(
            //               width: 200,
            //               child: Row(
            //                 children: <Widget>[
            //                   Text(
            //                     "Description: ",
            //                     style: TextStyle(
            //                       fontSize: 20.0,
            //                       fontWeight: FontWeight.bold,
            //                       color: Colors.black,
            //                       fontStyle: FontStyle.italic,
            //                       // backgroundColor: Colors.white
            //                     ),
            //                   ),
            //                   Text(
            //                     widget.ratings,
            //                     style: TextStyle(
            //                         fontSize: 20.0,
            //                         fontWeight: FontWeight.bold,
            //                         color: Colors.blue,
            //                         fontStyle: FontStyle.italic,
            //                         backgroundColor: Colors.white),
            //                   )
            //                 ],
            //               ),
            //             ),
            //             Divider(
            //               height: 5.0,
            //             ),
            //             Container(
            //               width: 200,
            //               child: Row(
            //                 children: <Widget>[
            //                   Text(
            //                     "Price: ",
            //                     style: TextStyle(
            //                       fontSize: 20.0,
            //                       fontWeight: FontWeight.bold,
            //                       color: Colors.black,
            //                       fontStyle: FontStyle.italic,
            //                       // backgroundColor: Colors.white
            //                     ),
            //                   ),
            //                   Text(
            //                     "Rs. " + widget.price.toString(),
            //                     style: TextStyle(
            //                         fontSize: 20.0,
            //                         fontWeight: FontWeight.bold,
            //                         color: Colors.red,
            //                         fontStyle: FontStyle.italic,
            //                         backgroundColor: Colors.white),
            //                   )
            //                 ],
            //               ),
            //             ),

            //             // Text(
            //             //   "Price:  : " + widget.price.toString() + "",
            //             //   style: TextStyle(color: Colors.white),
            //             // ),
            //           ],
            //         ),
            //         Column(
            //           crossAxisAlignment: CrossAxisAlignment.end,
            //           children: <Widget>[
            //             RaisedButton(
            //                 elevation: 10.0,
            //                 color: Colors.blue,
            //                 onPressed: () => print("Button Pressed"),
            //                 padding: EdgeInsets.all(5.0),
            //                 child: new Text("Send Req",
            //                     style: TextStyle(
            //                       color: Colors.white,
            //                       fontSize: 15.0,
            //                       fontWeight: FontWeight.bold,
            //                     )),
            //                 shape: RoundedRectangleBorder(
            //                   borderRadius: new BorderRadius.circular(18.0),
            //                   side: BorderSide(color: Colors.blue[50]),
            //                 )),
            //           ],
            //         ),
            //       ],
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}

// class CustomCardShapePainter extends CustomPainter{
//   @override
//   void
// }
