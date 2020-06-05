import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Loading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var spinKitChasingDots = SpinKitChasingDots(
      color: Colors.blueAccent,
      size: 50.0,
    );
    print("Loading Called");
    return Container(
      color: Colors.white,
      child: Center(
        child: spinKitChasingDots,
      ),
    );
  }
}
