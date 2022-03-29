// ignore_for_file: constant_identifier_names

part of 'app_screens.dart';

abstract class Routes {
  Routes._();

  static const HOME = _Paths.HOME;
  static const SPLASH = _Paths.SPLASH;
  static const ALPHABET = _Paths.ALPHABET;
  static const RHYME = _Paths.RHYME;
  static const ALPHABET_LESSON = _Paths.ALPHABET_LESSON;
  static const RHYME_LESSON = _Paths.RHYME_LESSON;
  static const FAIRY_TALE = _Paths.FAIRY_TALE;
  static const DASHBOARD = _Paths.DASHBOARD;
  static const RANKING = _Paths.RANKING;
  static const SETTING = _Paths.SETTING;
  static const WATCH_VIDEO = _Paths.WATCH_VIDEO;
  static const CHECK_PRONUNCIATION = _Paths.CHECK_PRONUNCIATION;
  static const CHECK_WRITING = _Paths.CHECK_WRITING;
  static const COMPLETE = _Paths.COMPLETE;
  static const SHOP = _Paths.SHOP;
}

abstract class _Paths {
  static const HOME = '/';
  static const SPLASH = '/splash';
  static const ALPHABET = '/alphabet';
  static const RHYME = '/rhyme';
  static const ALPHABET_LESSON = '/alphabet_lesson/:letter';
  static const RHYME_LESSON = '/rhyme/lesson';
  static const FAIRY_TALE = '/fairy_tale';
  static const DASHBOARD = '/dashboard';
  static const RANKING = '/ranking';
  static const SETTING = '/setting';
  static const WATCH_VIDEO = '/watch_video';
  static const CHECK_PRONUNCIATION = '/check_pronunciation/:param';
  static const CHECK_WRITING = '/check_writing/:param';
  static const COMPLETE = '/complete';
  static const SHOP = '/shop';
}
