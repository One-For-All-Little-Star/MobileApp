import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:litter_star/routers/app_screens.dart';
import 'package:litter_star/utils/layouts.dart';
import 'package:litter_star/widgets/header.dart';

import '../utils/get_hex_color.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = Layouts.getSize(context);

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
            children: <Widget>[
              const Header(),
              // Body
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                      child: Container(
                        width: 110,
                        height: 100,
                        decoration: const BoxDecoration(
                          color: Colors.transparent,
                          image: DecorationImage(
                              image: AssetImage("assets/icons/board.png"),
                              fit: BoxFit.cover),
                        ),
                        child: const Center(
                            child: Text(
                          "Truyện\ncổ tích",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 20),
                        )),
                      ),
                      onTap: () {
                        print("you clicked me");
                      }),
                  GestureDetector(
                      child: Container(
                          width: 100,
                          height: 100,
                          decoration: const BoxDecoration(
                            color: Colors.transparent,
                            image: DecorationImage(
                                image: AssetImage("assets/icons/shop.png"),
                                fit: BoxFit.contain),
                          ),
                          child: const Center(
                              child: Text(
                            "Cửa\nhàng",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 20),
                          ))),
                      onTap: () {
                        print("you clicked me");
                      }),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                      child: Container(
                        width: 150,
                        height: 150,
                        decoration: const BoxDecoration(
                          color: Colors.transparent,
                          image: DecorationImage(
                              image: AssetImage("assets/icons/road_tree.png"),
                              fit: BoxFit.contain),
                        ),
                        child: const Padding(
                            padding: EdgeInsets.fromLTRB(40, 25, 0, 0),
                            child: Text(
                              "Lịch sử",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20),
                            )),
                      ),
                      onTap: () {
                        print("you clicked me");
                      }),
                  GestureDetector(
                      child: Container(
                          width: 200,
                          height: 150,
                          decoration: const BoxDecoration(
                            color: Colors.transparent,
                            image: DecorationImage(
                                image: AssetImage("assets/icons/mailbox.png"),
                                fit: BoxFit.contain),
                          ),
                          child: const Padding(
                              padding: EdgeInsets.fromLTRB(100, 30, 0, 0),
                              child: Text(
                                "ABC",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20),
                              ))),
                      onTap: () => Get.toNamed(Routes.ALPHABET)),
                ],
              ),
              // End
            ],
          ),
        ));
  }
}
