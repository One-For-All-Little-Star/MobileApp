library litter_star.globlas;

import 'package:get/get.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:litter_star/models/resource.dart';

Resource getResourceValue() {
  Resource snapshot = Hive.box('database').get("resource");

  /// sum all star and update db
  List<dynamic> snapshotAlphabet = getAlphabetData();
  var temp = 0;

  /// update star
  for (var i = 0; i < snapshotAlphabet.length; i++) {
    temp = (temp + snapshotAlphabet[i].numOfstars) as int;
  }
  snapshot.star = temp;
  temp = 0;

  Hive.box('database').put("resource", snapshot);

  return snapshot;
}

bool isCheckPronunciation() {
  bool pronun = Hive.box('database').get("pronunciation");
  return pronun;
}

bool isCheckWriting() {
  bool writing = Hive.box('database').get("writing");
  return writing;
}

List<dynamic> getAlphabetData() {
  return Hive.box("database").get("alphabet");
}

String? getCurrentLetter() {
  return Hive.box("database").get("currentLetter");
}

List<dynamic> getVideosWatched() {
  return Hive.box("database").get("videosWatched");
}

List<dynamic> getTimeData() {
  return Hive.box("database").get("timeUse");
}

void updateTimeData(List<dynamic> newTimeData) {
  Hive.box("database").put("timeUse", newTimeData);
}

RxBool hasSound = true.obs;
