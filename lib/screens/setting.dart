import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:get/get.dart';
import 'package:litter_star/utils/globals.dart';
import 'package:litter_star/utils/sounds.dart';

dynamic showSettingScreen(context) {
  return showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return SettingScreen();
    },
  );
}

class SettingScreen extends StatelessWidget {
  final soundStatus = hasSound;

  SettingScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => AlertDialog(
        backgroundColor:
            const Color.fromARGB(0, 255, 255, 255).withOpacity(0.8),
        alignment: Alignment.center,
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: <Widget>[
                BackButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                const Expanded(
                  child: Text(
                    'Cài đặt',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("Bật/Tắt nhạc nền"),
                FlutterSwitch(
                    value: soundStatus.value,
                    showOnOff: true,
                    onToggle: (val) {
                      soundStatus.value = val;
                      hasSound.value = val;
                      if (hasSound.value) {
                        Sounds.resumeBackgroundSound();
                      } else {
                        Sounds.pauseBackgroundSound();
                      }
                    })
              ],
            )
          ],
        ),
      ),
    );
  }
}
