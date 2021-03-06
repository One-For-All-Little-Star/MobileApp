import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:litter_star/data/alphabet_list_default.dart';
import 'package:litter_star/models/alphabet.dart';
import 'package:litter_star/models/resource.dart';
import 'package:litter_star/models/time_use.dart';
import 'package:litter_star/models/video.dart';

Future<void> migrationData() async {
  Hive.registerAdapter(AlphabetAdapter());
  Hive.registerAdapter(ResourceAdapter());
  Hive.registerAdapter(TimeUseAdapter());
  Hive.registerAdapter(VideoAdapter());

  /// Set up database
  Box box = await Hive.openBox("database");

  ///  Migration data for Resource game (gold and star)
  Resource? resource = box.get("resource");
  if (resource == null) {
    box.put("resource", Resource(gold: 0, star: 0));
  }

  ///  Migration data for the alphabet
  var alphabet = box.get("alphabet");
  if (alphabet == null) {
    box.put("alphabet", AlphabetListDefault.getAlphabetListDefault());
  }

  /// Set Current alphabet lesson default
  var currentAlphabet = box.get("currentLetter");
  if (currentAlphabet == null) {
    box.put("currentLetter", "A");
  }
  var currentPronunciation = box.get("pronunciation");
  if (currentPronunciation == null) {
    box.put("pronunciation", false);
  }
  var currentWriting = box.get("writing");
  if (currentWriting == null) {
    box.put("writing", false);
  }

  /// set default time use
  var timeUse = box.get("timeUse");
  if (timeUse == null) {
    box.put("timeUse", [
      TimeUse(day: "29/3", watchVideo: 12, learn: 6),
      TimeUse(day: "30/3", watchVideo: 12, learn: 6),
      TimeUse(day: "31/3", watchVideo: 5, learn: 15),
      TimeUse(
          day: "${DateTime.now().day}/${DateTime.now().month}",
          watchVideo: 0,
          learn: 0)
    ]);
  }

  /// set default lessons learned
  var lessonsLearnde = box.get("lessonsLearned");
  if (lessonsLearnde == null) {
    box.put("lessonsLearned", List.empty());
  }

  /// set default videos watched
  var videoWatched = box.get("videosWatched");
  if (videoWatched == null) {
    box.put("videosWatched", List.empty());
  }
}
