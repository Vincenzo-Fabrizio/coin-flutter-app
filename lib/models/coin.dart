import 'package:hive/hive.dart';
import 'option_conservation.dart';
import 'numismatic_rarity.dart';

part 'coin.g.dart';

@HiveType(typeId: 0)
class Coin {
  @HiveField(0)
  final String id;
  @HiveField(1)
  final String name;
  @HiveField(2)
  final int year;
  @HiveField(3)
  final String material;
  @HiveField(4)
  final double weight;
  @HiveField(5)
  final double diameter;
  @HiveField(6)
  final double height;
  @HiveField(7)
  final double price;
  @HiveField(8)
  final OptionConservation conservationObverse;
  @HiveField(9)
  final OptionConservation conservationReverse;
  @HiveField(10)
  final NumismaticRarity degree;

  Coin({
    required this.id,
    required this.name,
    required this.year,
    required this.material,
    required this.weight,
    required this.diameter,
    required this.height,
    required this.price,
    required this.conservationObverse,
    required this.conservationReverse,
    required this.degree,
  });

  factory Coin.fromJson(Map<String, dynamic> json) => Coin(
    id: json['id'] as String,
    name: json['name'] as String,
    year: json['year'] as int,
    material: json['material'] as String,
    weight: (json['weight'] as num).toDouble(),
    diameter: (json['diameter'] as num).toDouble(),
    height: (json['height'] as num).toDouble(),
    price: (json['price'] as num).toDouble(),
    conservationObverse: OptionConservation.values.firstWhere(
      (e) => e.name == json['conservationObverse'],
    ),
    conservationReverse: OptionConservation.values.firstWhere(
      (e) => e.name == json['conservationReverse'],
    ),
    degree: NumismaticRarity.values.firstWhere((e) => e.name == json['degree']),
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'year': year,
    'material': material,
    'weight': weight,
    'diameter': diameter,
    'height': height,
    'price': price,
    'conservationObverse': conservationObverse.name,
    'conservationReverse': conservationReverse.name,
    'degree': degree.name,
  };
}
