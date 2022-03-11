import 'package:hive_flutter/adapters.dart';
import 'package:litter_star/data/alphabet_list_default.dart';
import 'package:litter_star/models/alphabet.dart';
import 'package:litter_star/models/resource.dart';

Future<void> migrationData() async {
  Hive.registerAdapter(AlphabetAdapter());
  Hive.registerAdapter(ResourceAdapter());

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
}
