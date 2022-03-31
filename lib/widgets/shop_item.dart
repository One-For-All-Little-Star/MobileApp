import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:litter_star/models/item.dart';
import 'package:litter_star/utils/layouts.dart';

class ShopItem extends StatelessWidget {
  const ShopItem(this.item, {Key? key}) : super(key: key);
  final Item item;
  @override
  Widget build(BuildContext context) {
    final size = Layouts.getSize(context);
    var formatCurrency = NumberFormat.currency(locale: "vi_VN", symbol: "vnđ");

    return Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
      /// description

      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            item.name,
            style: TextStyle(
                fontSize: size.height * 0.05,
                fontWeight: FontWeight.bold,
                color: Colors.white),
          ),
          item.isCoin
              ? const Image(
                  image: AssetImage('assets/icons/gold_coin.png'),
                  height: 16,
                )
              : Container()
        ],
      ),

      /// item image
      Image(
        image: AssetImage("assets/icons/${item.image}"),
        height: size.height * 0.15,
        width: size.width * 0.1,
      ),

      ///price
      item.isCoin
          ? Text(
              formatCurrency.format(item.price),
              style: TextStyle(
                  fontSize: size.height * 0.04,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            )
          : Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  item.name,
                  style: TextStyle(
                      fontSize: size.height * 0.04,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
                item.isCoin
                    ? const Image(
                        image: AssetImage('assets/icons/gold_coin.png'),
                        height: 16,
                      )
                    : Container()
              ],
            ),
    ]);
  }
}
