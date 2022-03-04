import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:litter_star/utils/layouts.dart';
import 'package:litter_star/utils/sounds.dart';
import 'package:litter_star/widgets/btn_with_bg_img.dart';
import 'dart:async';

class AlphabetLesson extends StatelessWidget {
  AlphabetLesson({Key? key}) : super(key: key);

  final String? letter = Get.parameters["letter"];

  void startLessonSounds(String letter) async {
    Sounds.playReadLetter(letter);
    Future.delayed(
        const Duration(
          seconds: 1,
        ),
        () => Sounds.playLetRead());
    Future.delayed(
        const Duration(
          seconds: 3,
        ),
        () => Sounds.playReadLetter(letter));
  }

  @override
  Widget build(BuildContext context) {
    final size = Layouts.getSize(context);
    // first read
    startLessonSounds(letter.toString());
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/images/alphabet_lesson_background.png"),
          fit: BoxFit.cover,
        ),
      ),
      padding: const EdgeInsets.all(5),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          // Header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              BtnWithBG(
                  onPressed: () => Get.back(),
                  bgName: "back_button.png",
                  text: "",
                  height: 50,
                  width: 90),
              Expanded(
                child: Container(
                  margin: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                      color: Colors.yellow,
                      borderRadius: BorderRadius.circular(20)),
                  child: Text(
                    "Chữ $letter",
                    style: const TextStyle(
                        color: Colors.white,
                        decoration: TextDecoration.none,
                        fontSize: 50),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              BtnWithBG(
                  onPressed: () => Get.back(),
                  bgName: "tick_button.png",
                  text: "",
                  height: 50,
                  width: 90),
            ],
          ),
          // Letter
          Expanded(
            child: Row(mainAxisAlignment: MainAxisAlignment.end, children: [
              Stack(
                alignment: const Alignment(-1.8, 2),
                children: [
                  Image.asset(
                    'assets/images/alphabet/a.gif',
                  ),
                  Image.asset(
                    'assets/icons/look_at.png',
                    width: size.width * 0.3,
                    height: size.height * 0.3,
                  ),
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  BtnWithBG(
                      onPressed: () => Sounds.playReadLetter(letter.toString()),
                      bgName: "listen.png",
                      text: "",
                      height: 90,
                      width: 90),
                  BtnWithBG(
                      onPressed: () {},
                      bgName: "speak.png",
                      text: "",
                      height: 90,
                      width: 90),
                ],
              )
            ]),
          ),
          // Bottom
        ],
      ),
    );
  }
}
