import 'dart:async';

import 'package:flame_audio/flame_audio.dart';
import 'package:flutter/foundation.dart';

class Sounds {
  static Future initialize() async {
    if (!kIsWeb) {
      FlameAudio.bgm.initialize();
      await FlameAudio.bgm.loadAll(['little_star.mp3']);
      await FlameAudio.audioCache.loadAll([
        'A.mp3',
        'complete.mp3',
        'let_read.mp3',
        'read_true.mp3',
        'read_false.mp3',
        'use_micro.mp3'
      ]);
    }
  }

  static stopBackgroundSound() {
    if (kIsWeb) return;
    return FlameAudio.bgm.stop();
  }

  static void playBackgroundSound() async {
    if (kIsWeb) return;
    await FlameAudio.bgm.stop();
    FlameAudio.bgm.initialize();
    FlameAudio.bgm.play('little_star.mp3');
  }

  static void pauseBackgroundSound() {
    if (kIsWeb) return;
    FlameAudio.bgm.pause();
  }

  static void resumeBackgroundSound() {
    if (kIsWeb) return;
    FlameAudio.bgm.resume();
  }

  static void playReadLetter(String letter) {
    if (kIsWeb) return;
    FlameAudio.audioCache.play('$letter.mp3');
  }

  static void playLetRead() {
    if (kIsWeb) return;
    FlameAudio.audioCache.play('let_read.mp3');
  }

  static void playCompleteLesson() {
    if (kIsWeb) return;
    FlameAudio.audioCache.play('complete.mp3');
  }

  static void playReadTrue() {
    if (kIsWeb) return;
    FlameAudio.audioCache.play('read_true.mp3');
  }

  static void playReadFalse() {
    if (kIsWeb) return;
    FlameAudio.audioCache.play('read_false.mp3');
  }

  static void playUseMicro() {
    if (kIsWeb) return;
    FlameAudio.audioCache.play('use_micro.mp3');
  }

  static void dispose() {
    if (kIsWeb) return;
    FlameAudio.bgm.dispose();
    FlameAudio.audioCache.clearAll();
  }
}
