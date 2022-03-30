import 'package:litter_star/models/item.dart';

class ItemListDefault {
  static List<Item> getItemListDefault() {
    return [
      Item(
          name: "200",
          description: "Cộng thêm 200 vàng",
          price: 15000, // must > 0.5$
          image: "little_gold.png",
          isCoin: true),
      Item(
          name: "400",
          description: "Cộng thêm 400 vàng",
          price: 22000,
          image: "medium_gold.png",
          isCoin: true),
      Item(
          name: "600",
          description: "Cộng thêm 600 vàng",
          price: 26000,
          image: "big_gold.png",
          isCoin: true),
      Item(
          name: "1000",
          description: "Cộng thêm 1000 vàng",
          price: 32000,
          image: "huge_gold.png",
          isCoin: true),
    ];
  }
}
