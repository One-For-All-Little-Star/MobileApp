import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:litter_star/data/migration_data.dart';
import 'package:litter_star/routers/app_screens.dart';
import 'package:flame/flame.dart';
import 'package:litter_star/utils/globals.dart';
import 'package:litter_star/utils/sounds.dart';
import 'package:permission_handler/permission_handler.dart';

Future<void> main() async {
  ///Returns an instance of the WidgetsBinding, creating and initializing it if necessary.
  WidgetsFlutterBinding.ensureInitialized();

  /// Set orientation for app
  if (!kIsWeb) {
    await Flame.device.setLandscape();
    await Flame.device.fullScreen();
  }

  /// Require premission
  Map<Permission, PermissionStatus> statuses = await [
    Permission.bluetooth,
    Permission.microphone,
    Permission.storage,
  ].request();

  /// Check permission
  if (await Permission.microphone.isPermanentlyDenied ||
      await Permission.microphone.isDenied) {
    openAppSettings();
  }

  /// Init sounds for app
  await Sounds.initialize();

  /// Init Hive
  await Hive.initFlutter();

  /// Run App
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    if (hasSound.value) {
      Sounds.playBackgroundSound();
    }
    migrationData();
    super.initState();
  }

  @override
  void dispose() {
    Hive.close();
    super.dispose();
  }

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
