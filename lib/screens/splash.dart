import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:litter_star/utils/layouts.dart';
import 'package:percent_indicator/percent_indicator.dart';
import '../utils/get_hex_color.dart';

// import 'home.dart';

class IndicatorController extends GetxController {
  currentProgressColor(currentPercent) {
    if (currentPercent <= 32) {
      return HexColor("#08db99");
    }
    if (currentPercent <= 63) {
      return HexColor("#0085f8");
    } else {
      return HexColor("#fe8000");
    }
  }
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final indicatorController = Get.put(IndicatorController());
  @override
  Widget build(BuildContext context) {
    final size = Layouts.getSize(context);
    return Stack(
      children: <Widget>[
        Image.asset(
          "assets/images/load_background.png",
          height: size.height,
          width: size.width,
          fit: BoxFit.cover,
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          bottomNavigationBar: Padding(
              padding: const EdgeInsets.all(15.0),
              child: TweenAnimationBuilder(
                tween: Tween(begin: 1.0, end: 100.0),
                duration: const Duration(seconds: 4),
                builder: (context, value, _) => LinearPercentIndicator(
                  width: size.width - 50,
                  animation: true,
                  lineHeight: 20.0,
                  animationDuration: 4000,
                  percent: 1.0,
                  center: Text("${double.parse(value.toString()).round()}%"),
                  linearStrokeCap: LinearStrokeCap.roundAll,
                  progressColor: indicatorController
                      .currentProgressColor(double.parse(value.toString())),
                  // onAnimationEnd: () => Navigator.pushReplacement(
                  //     context,
                  //     MaterialPageRoute(
                  //         builder: (context) => const HomeScreen())),
                  onAnimationEnd: () => Get.toNamed("/"),
                ),
              )),
        )
      ],
    );
  }
}
