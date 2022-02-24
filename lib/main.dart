import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:litter_star/routers/app_screens.dart';
import 'package:flame/flame.dart';
import 'package:litter_star/utils/sounds.dart';
// import 'package:assets_audio_player/assets_audio_player.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (!kIsWeb) {
    await Flame.device.setLandscape();
    await Flame.device.fullScreen();
  }
  await Sounds.initialize();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // AssetsAudioPlayer().open(Audio("assets/audio/litter_star.mp3"),
    //     autoStart: true, showNotification: false, respectSilentMode: true);

    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Litte Star",
      theme: ThemeData(textTheme: GoogleFonts.notoSansTextTheme()),
      initialRoute: AppScreens.INITIAL,
      getPages: AppScreens.routes,
    );
  }
}
