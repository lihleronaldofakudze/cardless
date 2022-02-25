final String tableCard = 'cards';

class ShoppingCardFields {
  static final List<String> values = [id, name, image];
  static final String id = '_id';
  static final String name = 'name';
  static final String image = 'image';
}

class ShoppingCard {
  final int? id;
  final String name;
  final String image;

  ShoppingCard({this.id, required this.name, required this.image});

  ShoppingCard copy({int? id, String? name, String? image}) => ShoppingCard(
      id: id ?? this.id, name: name ?? this.name, image: image ?? this.image);

  factory ShoppingCard.fromJson(Map<String, dynamic> json) => ShoppingCard(
      id: json[ShoppingCardFields.id],
      name: json[ShoppingCardFields.name],
      image: json[ShoppingCardFields.image]);

  Map<String, dynamic> toJson() => {
        ShoppingCardFields.id: id,
        ShoppingCardFields.name: name,
        ShoppingCardFields.image: image,
      };
}
