// ignore_for_file: deprecated_member_use

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;
import 'package:litter_star/data/item_list_default.dart';
import 'package:litter_star/models/item.dart';
import 'package:litter_star/models/resource.dart';
import 'package:litter_star/utils/get_hex_color.dart';
import 'package:litter_star/utils/globals.dart';
import 'package:litter_star/utils/layouts.dart';
import 'package:litter_star/widgets/btn_with_bg_img.dart';
import 'package:litter_star/widgets/shop_item.dart';

class ShopScreen extends StatefulWidget {
  const ShopScreen({Key? key}) : super(key: key);

  @override
  State<ShopScreen> createState() => _ShopScreenState();
}

class _ShopScreenState extends State<ShopScreen> {
  // ignore: prefer_typing_uninitialized_variables
  late var data;

  List items = ItemListDefault.getItemListDefault();
  @override
  void initState() {
    super.initState();
    setState(() {
      data = getResourceValue();
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  Map<String, dynamic>? paymentIntentData;

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
                          spacing: 10,
                          children: [
                            for (var item in items)
                              GestureDetector(
                                child: Container(
                                  decoration: const BoxDecoration(
                                    image: DecorationImage(
                                      image: AssetImage(
                                          "assets/icons/shop_item.png"),
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                  height: size.height * 0.3,
                                  width: size.width * 0.15,
                                  child: ShopItem(item),
                                ),
                                onTap: item.isCoin
                                    ? () async {
                                        await makePayment(item);
                                      }
                                    : () {},
                              ),
                          ],
                        ),
                        Text(
                          "Chào mừng bé đến với cửa hàng",
                          style: TextStyle(
                              fontSize: size.height * 0.035,
                              fontWeight: FontWeight.bold),
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

  Future<void> makePayment(Item item) async {
    try {
      paymentIntentData = await createPaymentIntent(item.price, "VND");
      await Stripe.instance.initPaymentSheet(
          paymentSheetParameters: SetupPaymentSheetParameters(
        paymentIntentClientSecret: paymentIntentData!['client_secret'],
        applePay: true,
        googlePay: true,
        merchantCountryCode: "VN",
        merchantDisplayName: "Little Star",
      ));

      displayPaymentSheet(item);
    } catch (e) {
      print('exception' + e.toString());
    }
  }

  displayPaymentSheet(Item item) async {
    try {
      await Stripe.instance.presentPaymentSheet(
          parameters: PresentPaymentSheetParameters(
              clientSecret: paymentIntentData!['client_secret'],
              confirmPayment: true));
      setState(() {
        paymentIntentData = null;
      });

      if (item.isCoin) {
        updateGold(int.parse(item.name));
      }
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Thanh toán thành công!")));
    } on StripeException catch (e) {
      print(e.toString());

      showDialog(
        context: context,
        builder: (_) => const AlertDialog(
          content: Text("Thanh toán bị huỷ"),
        ),
      );
    }
  }

  createPaymentIntent(int amount, String currency) async {
    try {
      Map<String, dynamic> body = {
        'amount': "$amount",
        "currency": currency,
        'payment_method_types[]': 'card'
      };

      var responsive = await http.post(
          Uri.parse("https://api.stripe.com/v1/payment_intents"),
          body: body,
          headers: {
            'Authorization':
                'Bearer sk_test_51JmTaPFXyOaQjIGtnPZxJm2qYajJhrb0FMkghNK2SbDyXIRt3vVdFSGWjaHeVWGsbCYNJKsoKKOKaTLDl5joSsXE00oWMOm2YP',
            'Content-Type': 'application/x-www-form-urlencoded'
          });
      return jsonDecode(responsive.body.toString());
    } catch (e) {
      print('exception' + e.toString());
    }
  }

  updateGold(int gold) async {
    Resource tempResource = getResourceValue();
    tempResource.gold += gold;
    await Hive.box("database").put("resource", tempResource);
  }
}
