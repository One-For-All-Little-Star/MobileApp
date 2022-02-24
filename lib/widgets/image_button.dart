import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ImageButton extends StatelessWidget {
  const ImageButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
        child: Container(
          width: 300,
          height: 100,
          decoration: const BoxDecoration(
            color: Colors.transparent,
            image: DecorationImage(
                image: AssetImage("assets/icons/board.png"), fit: BoxFit.cover),
          ),
          child: const Center(
              child: Text(
            "Truyện\ncổ tích",
            style: TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),
          )),
        ),
        onTap: () {
          print("you clicked me");
        });
  }
}
