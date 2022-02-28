import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:litter_star/utils/layouts.dart';
import 'package:litter_star/widgets/btn_with_bg_img.dart';

class AlphabetLesson extends StatelessWidget {
  AlphabetLesson({Key? key}) : super(key: key);

  final String? letter = Get.parameters["letter"];
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
          Row(
            children: [
              BtnWithBG(
                  onPressed: () => Get.back(),
                  bgName: "back_button.png",
                  text: "",
                  height: 50,
                  width: 90),
            ],
          ),
          Image.asset(
            'assets/images/alphabet/a2.gif',
            height: size.height - 50,
          )
        ],
      ),
    );
  }
}
