import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:litter_star/json/alphabet_list.dart';
import 'package:litter_star/utils/layouts.dart';
import 'package:litter_star/widgets/btn_with_bg_img.dart';

class AlphabetRoadMap extends StatelessWidget {
  const AlphabetRoadMap({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final lessons = AlphabetList.getAlphabetList();
    final size = Layouts.getSize(context);
    final int lessonPerPage = (size.height * 0.03).floor();
    return Container(
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
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              BtnWithBG(
                  onPressed: () {
                    print("Clicked back page");
                  },
                  bgName: "button_left.png",
                  text: "",
                  height: 72,
                  width: 72),
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  SizedBox(
                    width: size.width * 0.55,
                    child: Wrap(
                      alignment: WrapAlignment.center,
                      children: [
                        for (var i = 0; i < lessonPerPage; i++)
                          BtnWithBG(
                            onPressed: () => {
                              if (!lessons[i].isLock)
                                {
                                  Get.toNamed(
                                      "/alphabet_lesson/${lessons[i].letter}")
                                }
                              else
                                {
                                  Get.snackbar("Màn chơi này hiện đang khoá",
                                      "Bạn phải hoàn thành màn chơi trước để mở khoá màn chơi này!",
                                      snackPosition: SnackPosition.BOTTOM,
                                      colorText: Colors.white,
                                      backgroundColor: Colors.black54)
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
                            text: lessons[i].isLock ? "" : lessons[i].letter,
                            height: size.height * 0.2,
                            width: size.height * 0.2,
                            isCenter: false,
                            pdTop: size.height * 0.04,
                          ),
                      ],
                    ),
                  ),
                  Row(
                    children: [
                      BtnWithBG(
                        onPressed: () => Get.back(),
                        bgName: "btn_yellow.png",
                        text: "Quay\nLại",
                        height: size.height * 0.2,
                        width: size.height * 0.2,
                        fontSize: 15,
                      ),
                      BtnWithBG(
                        onPressed: () => Get.toNamed("/alphabet_lesson/A"),
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
              BtnWithBG(
                  onPressed: () {
                    print("Clicked forward page");
                  },
                  bgName: "button_right.png",
                  text: "",
                  height: 72,
                  width: 72),
            ],
          )),
    );
  }
}
