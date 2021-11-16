import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  final String btnText;

  Button(this.btnText);
  @override
  Widget build(BuildContext context) {
    return Container(
        height: 50.0,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25),
          color: Colors.blueAccent,
        ),
        child: Center(
          child: Text(
            btnText,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.white,
              fontSize: 18,
            ),
          ),
        ));
  }
}
