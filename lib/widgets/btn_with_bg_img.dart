import 'package:flutter/material.dart';

class BtnWithBG extends StatelessWidget {
  final String bgName;
  final String text;
  final double height, width, pdTop;
  final GestureTapCallback onPressed;
  final bool isCenter;

  const BtnWithBG(
      {Key? key,
      required this.onPressed,
      required this.bgName,
      required this.text,
      required this.height,
      required this.width,
      this.pdTop = 0.0,
      this.isCenter = true})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: Colors.transparent,
          image: DecorationImage(
              image: AssetImage("assets/icons/$bgName"), fit: BoxFit.contain),
        ),
        child: Padding(
          padding: EdgeInsets.only(top: pdTop),
          child: isCenter
              ? Center(
                  child: Text(
                  text,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 20),
                ))
              : Text(
                  text,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 20),
                ),
        ),
      ),
      onTap: onPressed,
    );
  }
}
