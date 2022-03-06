import 'package:get/get.dart';
import 'package:litter_star/screens/alphabet_lesson.dart';
import 'package:litter_star/screens/alphabet_road_map.dart';
import 'package:litter_star/screens/fairy_tale.dart';
import 'package:litter_star/screens/home.dart';
import 'package:litter_star/screens/splash.dart';
import 'package:litter_star/widgets/video_player_screen.dart';

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
        binding: FairyTaleBinding(),
        transition: Transition.cupertinoDialog),
    GetPage(
        name: _Paths.ALPHABET_LESSON,
        page: () => AlphabetLesson(),
        transition: Transition.fadeIn),
    GetPage(
        name: _Paths.WATCH_VIDEO,
        page: () => VideoPlayerScreen(),
        transition: Transition.native),
  ];
}
