import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:percent_indicator/percent_indicator.dart';
import '../utils/get_hex_color.dart';

import 'home.dart';

class IndicatorController extends GetxController {
  Rx<double> percent = 1.0.obs;
  currentProgressColor() {
    if (percent <= 0.32) {
      return HexColor("#08db99");
    }
    if (percent <= 0.63) {
      return HexColor("#0085f8");
    } else {
      return HexColor("#fe8000");
    }
  }

  void implement() {
    percent += 0.01;
    update();
  }
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(
        const Duration(seconds: 3),
        () => Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => const HomeScreen())));
  }

  final indicatorController = Get.put(IndicatorController());

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Image.asset(
          "assets/images/load_background.png",
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          fit: BoxFit.cover,
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0.0,
          ),
          bottomNavigationBar: Padding(
            padding: const EdgeInsets.all(15.0),
            child: LinearPercentIndicator(
              width: MediaQuery.of(context).size.width - 50,
              animation: true,
              lineHeight: 20.0,
              animationDuration: 2500,
              percent: indicatorController.percent.toDouble(),
              center: Text(
                  "${(indicatorController.percent.toDouble() * 100).toInt()}%"),
              linearStrokeCap: LinearStrokeCap.roundAll,
              progressColor: indicatorController.currentProgressColor(),
            ),
          ),
        )
      ],
    );
  }
}
