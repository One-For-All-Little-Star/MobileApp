import 'package:flutter/material.dart';
// import 'package:get/get.dart';

class FairyTaleScreen extends StatelessWidget {
  const FairyTaleScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/images/fairy_tales_background.png"),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
