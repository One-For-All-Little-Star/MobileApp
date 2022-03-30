import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:litter_star/utils/get_hex_color.dart';
import 'package:litter_star/utils/globals.dart';
import 'package:litter_star/utils/layouts.dart';
import 'package:litter_star/widgets/btn_with_bg_img.dart';

class ShopScreen extends StatefulWidget {
  const ShopScreen({Key? key}) : super(key: key);

  @override
  State<ShopScreen> createState() => _ShopScreenState();
}

class _ShopScreenState extends State<ShopScreen> {
  late var data;

  @override
  void initState() {
    super.initState();
    setState(() {
      data = getResourceValue();
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = Layouts.getSize(context);

    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/shop_background.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(5),
          child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// back btn
                BtnWithBG(
                    onPressed: () => Get.back(),
                    bgName: "back_button.png",
                    text: "",
                    height: 50,
                    width: size.width * 0.12),

                ///show items
                Container(
                  width: size.width * 0.68,
                  height: double.infinity,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("assets/images/shelves.png"),
                      fit: BoxFit.fill,
                    ),
                  ),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Wrap(
                          children: [
                            Stack(
                              alignment: const Alignment(0, 0.5),
                              children: [
                                Container(
                                  decoration: const BoxDecoration(
                                    image: DecorationImage(
                                      image: AssetImage(
                                          "assets/icons/shop_item.png"),
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                  height: size.height * 0.3,
                                  width: size.width * 0.1,
                                  child: Image(
                                    image: const AssetImage(
                                        "assets/icons/little_gold.png"),
                                    height: size.height * 0.2,
                                    width: size.width * 0.05,
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                        const Text(
                          "    Chào mừng bé đến với cửa hàng",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                ),

                /// show the number of gold
                Container(
                  alignment: Alignment.centerRight,
                  padding: EdgeInsets.only(
                      right: size.height * 0.035, top: size.height * 0.01),
                  width: size.width * 0.16,
                  height: size.height * 0.12,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("assets/icons/gold.png"),
                      fit: BoxFit.fill,
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
              ]),
        ),
      ),
    );
  }
}
