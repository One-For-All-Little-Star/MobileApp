import 'package:flame_audio/flame_audio.dart';
import 'package:flutter/foundation.dart';

class Sounds {
  static Future initialize() async {
    if (!kIsWeb) {
      FlameAudio.bgm.initialize();
      await FlameAudio.audioCache.loadAll([
        'little_star.mp3',
      ]);
    }
  }

  // static void interaction() {
  //   if (kIsWeb) return;
  //   FlameAudio.play('sound_interaction_name_here', volume: 0.4);
  // }

  static stopBackgroundSound() {
    if (kIsWeb) return;
    return FlameAudio.bgm.stop();
  }

  static void playBackgroundSound() async {
    if (kIsWeb) return;
    await FlameAudio.bgm.stop();
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

  static void dispose() {
    if (kIsWeb) return;
    FlameAudio.bgm.dispose();
  }
}
