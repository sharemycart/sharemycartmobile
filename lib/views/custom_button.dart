import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  CustomButton({ @required this.text, @required this.width, @required this.onPressed });
  final String text;
  final double width;
  final GestureTapCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      child: RawMaterialButton(
        fillColor: Colors.deepOrange,
        splashColor: Colors.orange,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Text(
            text,
            style: TextStyle(
              color: Colors.white,
              fontSize: 20
            ),
          ),
        ),
        onPressed: onPressed,
        shape: const StadiumBorder()
      ),
    );
  }
}