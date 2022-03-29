import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:litter_star/models/alphabet.dart';
import 'package:litter_star/routers/app_screens.dart';
import 'package:litter_star/utils/globals.dart';
import 'package:litter_star/utils/layouts.dart';
import 'package:litter_star/utils/sounds.dart';
import 'package:litter_star/widgets/btn_with_bg_img.dart';

class AlphabetLesson extends StatefulWidget {
  const AlphabetLesson({Key? key}) : super(key: key);

  @override
  _AlphabetLesssonState createState() => _AlphabetLesssonState();
}

class _AlphabetLesssonState extends State<AlphabetLesson> {
  final Alphabet crrDataLesson = Hive.box("database")
      .get("alphabet")
      .where((e) => e.routeName == Get.parameters["letter"])
      .toList()[0];
  late final String letter;
  final String? routeName = Get.parameters["letter"];

  @override
  void initState() {
    if (hasSound.value) {
      Sounds.pauseBackgroundSound();
    }
    letter = crrDataLesson.letter;
    Sounds.playReadLetter(routeName.toString());
    // first read
    startLessonSounds(routeName.toString());
    super.initState();
  }

  @override
  void dispose() {
    if (hasSound.value) {
      Sounds.resumeBackgroundSound();
    }

    super.dispose();
  }

  void startLessonSounds(String routeName) async {
    Future.delayed(
        const Duration(
          seconds: 1,
        ),
        () => Sounds.playLetRead());
    Future.delayed(
        const Duration(
          seconds: 3,
        ),
        () => Sounds.playReadLetter(routeName));
  }

  @override
  Widget build(BuildContext context) {
    final size = Layouts.getSize(context);

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
                  onPressed: () => Get.toNamed(Routes.ALPHABET),
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
                  onPressed: () => Get.toNamed("/complete?route=$routeName"),
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
                    'assets/images/alphabet/${crrDataLesson.image}',
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      BtnWithBG(
                          onPressed: () =>
                              Sounds.playReadLetter(routeName.toString()),
                          bgName: "listen.png",
                          text: "",
                          height: 90,
                          width: 90),
                      BtnWithBG(
                          onPressed: () {
                            Get.toNamed("/check_pronunciation/$routeName");
                          },
                          bgName: "speak.png",
                          text: "",
                          height: 90,
                          width: 90),
                      BtnWithBG(
                          onPressed: () {
                            Get.toNamed("/check_writing/$routeName");
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
