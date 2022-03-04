import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:litter_star/routers/app_screens.dart';
import 'package:flame/flame.dart';
import 'package:litter_star/utils/sounds.dart';
import 'package:permission_handler/permission_handler.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (!kIsWeb) {
    await Flame.device.setLandscape();
    await Flame.device.fullScreen();
  }
  Map<Permission, PermissionStatus> statuses = await [
    Permission.bluetooth,
    Permission.microphone,
    Permission.storage,
  ].request();
  if (await Permission.microphone.isPermanentlyDenied ||
      await Permission.microphone.isDenied) {
    openAppSettings();
  }

  await Sounds.initialize();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Litte Star",
      theme: ThemeData(textTheme: GoogleFonts.notoSansTextTheme()),
      initialRoute: AppScreens.INITIAL,
      getPages: AppScreens.routes,
    );
  }
}
