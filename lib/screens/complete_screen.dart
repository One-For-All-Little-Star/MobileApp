import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:litter_star/models/alphabet.dart';
import 'package:litter_star/models/resource.dart';
import 'package:litter_star/routers/app_screens.dart';
import 'package:litter_star/utils/globals.dart';
import 'package:litter_star/utils/layouts.dart';
import 'package:litter_star/widgets/btn_with_bg_img.dart';

class CompleteScreen extends StatefulWidget {
  const CompleteScreen({Key? key}) : super(key: key);

  @override
  State<CompleteScreen> createState() => _CompleteScreenState();
}

class _CompleteScreenState extends State<CompleteScreen> {
  final List<dynamic> allDataLesson = Hive.box("database").get("alphabet");
  late Alphabet crrDataLesson;
  late final int crrIndexLesson;
  int totalGold = 0; // the number of gold when complete a lesson
  int totalStar = 1; // the number of star when complete a lesson
  Resource tempResource =
      getResourceValue(); // temp varriable to save and update the number gold and star in db
  @override
  void initState() {
    super.initState();

    /// define stage
    crrDataLesson = allDataLesson
        .where((e) => e.routeName == Get.parameters["route"])
        .toList()[0];

    crrIndexLesson =
        allDataLesson.indexWhere((e) => e.routeName == crrDataLesson.routeName);
    setState(() {
      ///calculate star and gold
      switch (crrDataLesson.numOfstars) {
        case 0:
          crrDataLesson.numOfstars = 1;
          totalGold += 50;
          if (isCheckPronunciation()) {
            crrDataLesson.numOfstars += 1;
            totalGold += 50;
          }
          if (isCheckWriting()) {
            crrDataLesson.numOfstars += 1;
            totalGold += 50;
          }
          break;
        case 1:
          if (isCheckPronunciation()) {
            crrDataLesson.numOfstars += 1;
            totalGold += 50;
          }
          if (isCheckWriting()) {
            crrDataLesson.numOfstars += 1;
            totalGold += 50;
          }
          break;
        case 2:
          if (isCheckPronunciation() && isCheckWriting()) {
            crrDataLesson.numOfstars += 1;
            totalGold += 100;
          }
          break;
        default:
      }

      if (isCheckPronunciation()) {
        totalStar++;
      }
      if (isCheckWriting()) {
        totalStar++;
      }
    });

    ///update gold
    tempResource.gold += totalGold;
    Hive.box("database").put("resource", tempResource);

    /// update current letter

    if (crrIndexLesson < allDataLesson.length - 1 &&
        allDataLesson[crrIndexLesson + 1].isLock &&
        totalStar > 1) {
      if (allDataLesson[crrIndexLesson + 1].isLock) {
        allDataLesson[crrIndexLesson + 1].isLock = false;
      }
      Hive.box("database").put(
          "currentLetter", "${allDataLesson[crrIndexLesson + 1].routeName}");
    }

    /// update alphabet database
    allDataLesson[crrIndexLesson] = crrDataLesson;
    Hive.box("database").put("alphabet", allDataLesson);

    //reset
    Hive.box('database').put("pronunciation", false);
    Hive.box('database').put("writing", false);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = Layouts.getSize(context);
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/complete_background.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Column(
            children: [
              SizedBox(
                width: size.width * 0.55,
                height: size.height * 0.8,
                child: Container(
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("assets/images/panel_reward.png"),
                      fit: BoxFit.fill,
                    ),
                  ),
                  child: Column(
                    children: [
                      SizedBox(
                        height: size.height * 0.15,
                      ),
                      Image.asset(
                        "assets/icons/get_${totalStar == 1 ? 'one' : totalStar == 2 ? 'two' : 'three'}.png",
                        width: size.width * 0.25,
                      ),
                      const Text(
                        "Ph???n th?????ng",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 25,
                            fontWeight: FontWeight.w700,
                            decoration: TextDecoration.none),
                      ),
                      Container(
                        width: size.width * 0.2,
                        height: 50,
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage("assets/icons/reward_gold.png"),
                            fit: BoxFit.fill,
                          ),
                        ),
                        child: Center(
                          child: Text("$totalGold",
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  decoration: TextDecoration.none)),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          BtnWithBG(
                            onPressed: () => Get.back(),
                            bgName: "long_btn_yellow.png",
                            text: "L??m l???i",
                            height: 50,
                            width: 90,
                            fontSize: 18,
                          ),
                          BtnWithBG(
                            onPressed: () => Get.toNamed(
                                "/alphabet_lesson/${getCurrentLetter()}"),
                            bgName: "long_btn_green.png",
                            text: "Ti???p t???c",
                            height: 50,
                            width: 90,
                            fontSize: 18,
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
              BtnWithBG(
                onPressed: () => Get.offAndToNamed(Routes.ALPHABET),
                bgName: "long_btn_yellow.png",
                text: "Quay l???i",
                height: 60,
                width: 100,
                fontSize: 20,
              )
            ],
          ),
        ),
      ),
    );
  }
}
