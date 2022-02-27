import 'package:get/get.dart';
import 'package:litter_star/screens/alphabet_road_map.dart';
import 'package:litter_star/screens/fairy_tale.dart';
import 'package:litter_star/screens/home.dart';
import 'package:litter_star/screens/splash.dart';

part 'app_routes.dart';

class AppScreens {
  AppScreens._();

  // ignore: constant_identifier_names
  static const INITIAL = Routes.SPLASH;

  static final routes = [
    GetPage(
      name: _Paths.SPLASH,
      page: () => const SplashScreen(),
    ),
    GetPage(
        name: _Paths.HOME,
        page: () => const HomeScreen(),
        transition: Transition.topLevel),
    GetPage(
        name: _Paths.ALPHABET,
        page: () => const AlphabetRoadMap(),
        transition: Transition.circularReveal),
    GetPage(
        name: _Paths.FAIRY_TALE,
        page: () => const FairyTaleScreen(),
        transition: Transition.cupertinoDialog),
  ];
}
