import 'package:flutter/material.dart';
import 'package:litter_star/models/item.dart';
import 'package:litter_star/utils/layouts.dart';

class ShopItem extends StatelessWidget {
  const ShopItem(this.item, {Key? key}) : super(key: key);
  final Item item;

  @override
  Widget build(BuildContext context) {
    final size = Layouts.getSize(context);

    return Container(
      child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
        /// description

        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              item.name,
              style: const TextStyle(
                  fontSize: 20,
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
        Text(
          "${item.price}${item.isCoin ? ' vnđ' : const Image(
              image: AssetImage('assets/icons/gold_coin.png'),
              height: 16,
            )}",
          style: const TextStyle(
              fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
        ),
      ]),
    );
  }
}
