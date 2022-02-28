import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:litter_star/routers/app_screens.dart';
import 'package:litter_star/widgets/btn_with_bg_img.dart';

class AlphabetRoadMap extends StatelessWidget {
  const AlphabetRoadMap({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/images/alphabet_background.png"),
          fit: BoxFit.cover,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Container(
            decoration: const BoxDecoration(
                image: DecorationImage(
              image: AssetImage("assets/images/panel.png"),
              fit: BoxFit.contain,
            )),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.max,
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
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Row(
                        children: [
                          BtnWithBG(
                            onPressed: () => Get.toNamed("/alphabet_lesson/A"),
                            bgName: "one_star.png",
                            text: "A",
                            height: 80,
                            width: 80,
                            isCenter: false,
                            pdTop: 20,
                          ),
                          BtnWithBG(
                              onPressed: () {},
                              bgName: "lock.png",
                              text: "",
                              height: 80,
                              width: 80),
                          BtnWithBG(
                              onPressed: () {},
                              bgName: "lock.png",
                              text: "",
                              height: 80,
                              width: 80),
                          BtnWithBG(
                              onPressed: () {},
                              bgName: "lock.png",
                              text: "",
                              height: 80,
                              width: 80),
                        ],
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        BtnWithBG(
                            onPressed: () => Get.back(),
                            bgName: "btn_yellow.png",
                            text: "Quay\nLại",
                            height: 80,
                            width: 80),
                        BtnWithBG(
                            onPressed: () => Get.toNamed("/alphabet_lesson/A"),
                            bgName: "btn_green.png",
                            text: "Tiếp\nTục",
                            height: 80,
                            width: 80),
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
      ),
    );
  }
}

// BtnWithBG(
//                 onPressed: () {
//                   print("Clicked");
//                 },
//                 bgName: "button_left.png",
//                 text: "",
//                 height: 20,
//                 width: 20),
//             BtnWithBG(
//                 onPressed: () {
//                   print("Clicked");
//                 },
//                 bgName: "button_right.png",
//                 text: "",
//                 height: 20,
//                 width: 20),
