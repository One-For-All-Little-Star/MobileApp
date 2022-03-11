import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:litter_star/routers/app_screens.dart';
import 'package:litter_star/utils/layouts.dart';
import 'package:litter_star/widgets/btn_with_bg_img.dart';

class CompleteScreen extends StatelessWidget {
  const CompleteScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = Layouts.getSize(context);
    return Container(
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
              child: Expanded(
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
                        "assets/icons/get_three.png",
                        width: size.width * 0.25,
                      ),
                      const Text(
                        "Phần thưởng",
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
                        child: const Center(
                          child: Text("200",
                              style: TextStyle(
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
                            text: "Làm lại",
                            height: 50,
                            width: 90,
                            fontSize: 18,
                          ),
                          BtnWithBG(
                            onPressed: () => Get.toNamed(Routes.ALPHABET),
                            bgName: "long_btn_green.png",
                            text: "Tiếp tục",
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
            ),
            BtnWithBG(
              onPressed: () => Get.toNamed(Routes.ALPHABET),
              bgName: "long_btn_yellow.png",
              text: "Quay lại",
              height: 60,
              width: 100,
              fontSize: 20,
            )
          ],
        ),
      ),
    );
  }
}
