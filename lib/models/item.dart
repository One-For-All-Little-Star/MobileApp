class Item {
  Item(
      {required this.name,
      required this.description,
      required this.price,
      required this.image,
      this.isCoin = false});

  final String name;
  final String description;
  final int price;
  final String image;
  final bool isCoin;
}
