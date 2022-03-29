import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:litter_star/routers/app_screens.dart';
import 'package:litter_star/utils/globals.dart';
import 'package:litter_star/utils/layouts.dart';
import 'package:litter_star/widgets/btn_with_bg_img.dart';

class AlphabetRoadMap extends StatefulWidget {
  const AlphabetRoadMap({Key? key}) : super(key: key);

  @override
  State<AlphabetRoadMap> createState() => _AlphabetRoadMapState();
}

class _AlphabetRoadMapState extends State<AlphabetRoadMap> {
  late final List lessons;
  @override
  void initState() {
    super.initState();
    lessons = getAlphabetData();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = Layouts.getSize(context);
    final int lessonPerPage = (size.height * 0.035).floor();

    RxInt firstIndex = 0.obs;
    RxInt lastIndex = lessonPerPage.obs;

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/alphabet_background.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: Container(
            decoration: const BoxDecoration(
                image: DecorationImage(
              image: AssetImage("assets/images/panel.png"),
              fit: BoxFit.contain,
            )),
            margin: const EdgeInsets.fromLTRB(20, 10, 20, 10),
            child: Obx(
              () => Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  firstIndex.value != 0
                      ? BtnWithBG(
                          onPressed: () {
                            lastIndex.value = firstIndex.value;
                            for (var i = 0; i < lessonPerPage; i++) {
                              if (firstIndex.value == 0) {
                                break;
                              }
                              firstIndex.value--;
                            }
                          },
                          bgName: "button_left.png",
                          text: "",
                          height: 72,
                          width: 72)
                      : const SizedBox(
                          height: 72,
                          width: 72,
                        ),

                  /// Show Lesson
                  Padding(
                    padding: EdgeInsets.only(top: size.height * 0.14),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        SizedBox(
                          width: size.width * 0.6,
                          child: Wrap(
                            alignment: WrapAlignment.center,
                            children: [
                              for (var i = firstIndex.value;
                                  i < lastIndex.value;
                                  i++)
                                BtnWithBG(
                                  onPressed: () {
                                    if (!lessons[i].isLock) {
                                      Get.toNamed(
                                          "/alphabet_lesson/${lessons[i].routeName}");
                                    }
                                  },
                                  bgName: lessons[i].isLock
                                      ? "lock.png"
                                      : lessons[i].numOfstars == 0
                                          ? "none_star.png"
                                          : lessons[i].numOfstars == 1
                                              ? "one_star.png"
                                              : lessons[i].numOfstars == 2
                                                  ? "two_star.png"
                                                  : "three_star.png",
                                  text: lessons[i].isLock
                                      ? ""
                                      : lessons[i].letter,
                                  height: size.height * 0.2,
                                  width: size.height * 0.2,
                                  isCenter: false,
                                  pdTop: size.height * 0.04,
                                ),
                            ],
                          ),
                        ),
                        lastIndex.value == lessons.length - 1
                            ? const Spacer()
                            : Container(),
                        Row(
                          children: [
                            BtnWithBG(
                              onPressed: () => Get.toNamed(Routes.HOME),
                              bgName: "btn_yellow.png",
                              text: "Quay\nLại",
                              height: size.height * 0.2,
                              width: size.height * 0.2,
                              fontSize: 15,
                            ),
                            BtnWithBG(
                              onPressed: () => Get.toNamed(
                                  "/alphabet_lesson/${getCurrentLetter()}"),
                              bgName: "btn_green.png",
                              text: "Tiếp\nTục",
                              height: size.height * 0.2,
                              width: size.height * 0.2,
                              fontSize: 15,
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                  lastIndex.value != (lessons.length - 1)
                      ? BtnWithBG(
                          onPressed: () {
                            firstIndex.value = lastIndex.value;
                            for (var i = 0; i < lessonPerPage; i++) {
                              if (lastIndex.value == lessons.length - 1) {
                                break;
                              }
                              lastIndex.value++;
                            }
                          },
                          bgName: "button_right.png",
                          text: "",
                          height: 72,
                          width: 72)
                      : const SizedBox(
                          height: 72,
                          width: 72,
                        ),
                ],
              ),
            )),
      ),
    );
  }
}
