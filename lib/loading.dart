import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Loading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.pink[200],
      child: Center(
          child: Column(
        children: [
          SizedBox(
            height: 10,
          ),
          SpinKitDualRing(
            color: Colors.white,
            size: 100,
          ),
          SizedBox(
            height: 5,
          ),
          Text(
            'Your gift has been sent!! Please wait...',
            style: TextStyle(color: Colors.white, fontSize: 16),
          )
        ],
      )),
    );
  }
}
