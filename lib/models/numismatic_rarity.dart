// ignore_for_file: constant_identifier_names
import 'package:hive/hive.dart';

part 'numismatic_rarity.g.dart';

@HiveType(typeId: 2)
enum NumismaticRarity {
  @HiveField(0)
  R5("UNICA"),
  @HiveField(1)
  R4("ESTREMAMENTE RARA"),
  @HiveField(2)
  R3("RARISSIMA"),
  @HiveField(3)
  R2("MOLTO RARA"),
  @HiveField(4)
  R("RARA"),
  @HiveField(5)
  NC("NON COMUNE"),
  @HiveField(6)
  C("COMUNE");

  final String wording;
  const NumismaticRarity(this.wording);
}
