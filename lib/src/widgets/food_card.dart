import 'package:flutter/material.dart';
import 'package:slimy_card/slimy_card.dart';

class FoodCard extends StatelessWidget {
  final String categoryName;
  final String imagePath;
  final int numberOfItems;
  final String title;
  final String description;
  final String price;

  FoodCard(
      {this.categoryName,
      this.imagePath,
      this.numberOfItems,
      this.description,
      this.title,
      this.price});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 20.0),
      child: Card(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
          child: Row(
            children: <Widget>[
              Image(
                image: NetworkImage(imagePath),
                height: 90.0,
                width: 90.0,
              ),
              SizedBox(
                width: 30.0,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Row(children: <Widget>[
                    Text(
                    "Title:",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16.0,
                      fontStyle: FontStyle.normal,
                      color: Colors.black,
                    ),
                  ),
                  Text(
                    "  $title",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16.0,
                      fontStyle: FontStyle.normal,
                      color: Colors.blueAccent,
                    ),
                  )
                  ],)
                  ,
                  Row(children: <Widget>[
                    Text(
                    "Catgeory :  ",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16.0,
                        fontStyle: FontStyle.italic,
                        color: Colors.black),
                  ),
                  Text(
                    "$categoryName",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16.0,
                        fontStyle: FontStyle.italic,
                        color: Colors.blueAccent),
                  ),
                  ],)
                  ,
                  Row(children: <Widget>[
                    Text(
                    "Price :  ",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.italic,
                        fontSize: 16.0),
                  ),
                  Text(
                    "Rs. $price ",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.italic,
                        fontSize: 16.0,
                         color: Colors.red),
                  ),
                  ],)
                  ,
                  
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
