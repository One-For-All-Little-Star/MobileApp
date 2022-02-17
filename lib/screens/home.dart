import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../utils/get_hex_color.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // double height = MediaQuery.of(context).size.height *;
    return Scaffold(
        appBar: null,
        body: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/home_background.png"),
              fit: BoxFit.cover,
            ),
          ),
          padding: const EdgeInsets.fromLTRB(0, 0, 50, 0),
          child: Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: <Widget>[
                      Container(
                        alignment: Alignment.centerRight,
                        padding: const EdgeInsets.only(right: 30),
                        width: MediaQuery.of(context).size.width * 0.2,
                        height: MediaQuery.of(context).size.height * 0.15,
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage("assets/icons/gold.png"),
                            fit: BoxFit.cover,
                          ),
                        ),
                        child: Text("0",
                            style: GoogleFonts.bangers(
                              textStyle: TextStyle(
                                  color: HexColor("#fcc621"),
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15),
                            )),
                      ),
                      Image.asset('assets/icons/energy.png'),
                      Image.asset('assets/icons/star.png'),
                    ],
                  ),
                  IconButton(
                      tooltip: "Cài đặt",
                      onPressed: () {},
                      icon: Image.asset(
                        "assets/icons/settings.png",
                        width: 150,
                        height: 100.0,
                      ))
                ],
              )
            ],
          ),
        ));
  }
}
