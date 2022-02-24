import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:litter_star/utils/globals.dart';

Future<void> showSettingScreen(context) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        backgroundColor: Color.fromARGB(0, 255, 255, 255).withOpacity(0.8),
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
                const Text("Bật tắt âm lượng"),
                FlutterSwitch(
                    value: hasSound,
                    showOnOff: true,
                    onToggle: (val) {
                      hasSound = val;
                    })
              ],
            )
          ],
        ),
      );
    },
  );
}
