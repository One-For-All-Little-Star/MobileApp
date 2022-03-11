library litter_star.globlas;

import 'package:get/get.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:litter_star/models/resource.dart';

Resource getResourceValue() {
  Resource snapshot = Hive.box('database').get("resource");

  /// sum all star and update db
  var snapshotAlphabet = getAlphabetData();

  // snapshotAlphabet.fold(0, (pre, crr) => {print("${pre! + crr.numOfstars}")});

  // print(star);
  return snapshot;
}

List<dynamic> getAlphabetData() {
  return Hive.box("database").get("alphabet");
}

String? getCurrentLetter() {
  return Hive.box("database").get("currentLetter");
}

bool isLoggedIn = false;
RxBool hasSound = true.obs;
