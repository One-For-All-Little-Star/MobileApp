import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:litter_star/models/alphabet.dart';
import 'package:litter_star/utils/globals.dart';
import 'package:litter_star/utils/layouts.dart';
import 'package:litter_star/utils/sounds.dart';
import 'package:litter_star/widgets/btn_with_bg_img.dart';
import 'dart:async';

class AlphabetLesson extends StatefulWidget {
  const AlphabetLesson({Key? key}) : super(key: key);

  @override
  _AlphabetLesssonState createState() => _AlphabetLesssonState();
}

class _AlphabetLesssonState extends State<AlphabetLesson> {
  final String? letter = Get.parameters["letter"];
  final allDataLesson = Hive.box("database").get("alphabet");
  late final Alphabet crrDataLesson;

  @override
  void initState() {
    if (hasSound.value) {
      Sounds.pauseBackgroundSound();
    }

    crrDataLesson = allDataLesson
        .where((e) => e.letter == Get.parameters["letter"])
        .toList()[0];
    print(crrDataLesson.image);
    // if (dataLesson.numOfstars == 0) {
    //   dataLesson.numOfstars
    // }
    Sounds.playReadLetter(letter.toString());
    super.initState();
  }

  @override
  void dispose() {
    if (hasSound.value) {
      Sounds.resumeBackgroundSound();
    }
    super.dispose();
  }

  void startLessonSounds(String letter) async {
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
                  onPressed: () => Get.toNamed("/complete"),
                  bgName: "tick_button.png",
                  text: "",
                  height: 50,
                  width: 90),
            ],
          ),
          // Letter
          Expanded(
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    children: [
                      const Spacer(),
                      Image.asset(
                        'assets/icons/look_at.png',
                        width: size.width * 0.2,
                        height: size.height * 0.3,
                      ),
                    ],
                  ),
                  Image.asset(
                    'assets/images/alphabet/a.gif',
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      BtnWithBG(
                          onPressed: () =>
                              Sounds.playReadLetter(letter.toString()),
                          bgName: "listen.png",
                          text: "",
                          height: 90,
                          width: 90),
                      BtnWithBG(
                          onPressed: () {
                            Get.toNamed("/check_pronunciation/$letter");
                          },
                          bgName: "speak.png",
                          text: "",
                          height: 90,
                          width: 90),
                      BtnWithBG(
                          onPressed: () {
                            Get.toNamed("/check_writing/$letter");
                          },
                          bgName: "write.png",
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
