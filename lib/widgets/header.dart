import 'package:flutter/material.dart';
// import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:litter_star/utils/get_hex_color.dart';
import 'package:litter_star/utils/globals.dart';
import 'package:litter_star/utils/layouts.dart';
import 'package:litter_star/screens/setting.dart';

class Header extends StatefulWidget {
  const Header({Key? key}) : super(key: key);

  @override
  _Header createState() => _Header();
}

class _Header extends State<Header> {
  // ignore: prefer_typing_uninitialized_variables
  late final data;
  @override
  void initState() {
    super.initState();
    data = getResourceValue();
  }

  @override
  Widget build(BuildContext context) {
    final size = Layouts.getSize(context);

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          // ---- Number of Gold ----
          children: <Widget>[
            Container(
              alignment: Alignment.centerRight,
              padding: EdgeInsets.only(
                  right: size.height * 0.04, top: size.height * 0.01),
              width: size.width * 0.2,
              height: size.height * 0.15,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/icons/gold.png"),
                  fit: BoxFit.cover,
                ),
              ),
              child: Text("${data.gold}",
                  style: GoogleFonts.bangers(
                    textStyle: TextStyle(
                        color: HexColor("#fcc621"),
                        fontWeight: FontWeight.bold,
                        fontSize: 15),
                  )),
            ),
            // ---- Number of Star ----
            Container(
              alignment: Alignment.centerRight,
              padding: EdgeInsets.only(
                  right: size.height * 0.06, top: size.height * 0.01),
              width: size.width * 0.2,
              height: size.height * 0.15,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/icons/star.png"),
                  fit: BoxFit.cover,
                ),
              ),
              child: Text("${data.star}",
                  style: GoogleFonts.bangers(
                    textStyle: TextStyle(
                        color: HexColor("#fcc621"),
                        fontWeight: FontWeight.bold,
                        fontSize: 15),
                  )),
            ),
          ],
        ),
        InkWell(
            onTap: () => showSettingScreen(context),
            child: Image.asset(
              "assets/icons/settings.png",
              width: 155,
              height: 45,
            ))
      ],
    );
  }
}
