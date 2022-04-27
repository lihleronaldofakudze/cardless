final String tableCard = 'cards';

class ShoppingCardFields {
  static final List<String> values = [id, name, barcode];
  static final String id = '_id';
  static final String name = 'name';
  static final String barcode = 'image';
}

class ShoppingCard {
  final int id;
  final String name;
  final String barcode;

  ShoppingCard({
    required this.id,
    required this.name,
    required this.barcode,
  });

  ShoppingCard copy({
    int? id,
    String? name,
    String? image,
  }) =>
      ShoppingCard(
        id: id ?? this.id,
        name: name ?? this.name,
        barcode: image ?? this.barcode,
      );

  factory ShoppingCard.fromJson(
    Map<String, dynamic> json,
  ) =>
      ShoppingCard(
        id: json[ShoppingCardFields.id],
        name: json[ShoppingCardFields.name],
        barcode: json[ShoppingCardFields.barcode],
      );

  Map<String, dynamic> toJson() => {
        ShoppingCardFields.id: id,
        ShoppingCardFields.name: name,
        ShoppingCardFields.barcode: barcode,
      };
}
