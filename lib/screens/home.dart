import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:litter_star/routers/app_screens.dart';
import 'package:litter_star/utils/layouts.dart';
import 'package:litter_star/utils/sounds.dart';
import 'package:litter_star/widgets/btn_with_bg_img.dart';
import 'package:litter_star/widgets/header.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = Layouts.getSize(context);
    Sounds.playBackgroundSound();
    return Scaffold(
        appBar: null,
        body: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/home_background.png"),
              fit: BoxFit.cover,
            ),
          ),
          padding: EdgeInsets.fromLTRB(0, 0, size.height * 0.1, 0),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              const Header(),
              // Body
              // Row 1
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  BtnWithBG(
                    onPressed: () => Get.toNamed(Routes.FAIRY_TALE),
                    bgName: "board.png",
                    text: "Truyện\ncổ tích",
                    height: size.height / 4,
                    width: size.width / 7,
                    pdTop: size.height / 20,
                  ),
                  BtnWithBG(
                    onPressed: () {
                      // TODO: Shop Screen
                    },
                    bgName: "shop.png",
                    text: "",
                    height: size.height / 5,
                    width: size.width / 5,
                  ),
                ],
              ),
              // END Row 1
              Image.asset(
                "assets/images/chicken.gif",
                height: size.height / 4,
              ),
              // Row 2
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  BtnWithBG(
                    onPressed: () {
                      // TODO: Dashboard Screen
                    },
                    bgName: "road_tree.png",
                    text: "Lịch sử",
                    height: size.height / 3,
                    width: size.width / 5,
                    pdTop: size.height / 20,
                    isCenter: false,
                  ),
                  BtnWithBG(
                    onPressed: () => Get.toNamed(Routes.ALPHABET),
                    bgName: "ABCs.png",
                    text: "",
                    height: size.height / 3,
                    width: size.width / 3,
                    isCenter: false,
                  ),
                ],
              ),
              // END Row 2

              // End
            ],
          ),
        ));
  }
}
