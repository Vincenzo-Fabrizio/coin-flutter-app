// ignore_for_file: constant_identifier_names
import 'package:hive/hive.dart';

part 'option_conservation.g.dart';

@HiveType(typeId: 1)
enum OptionConservation {
  @HiveField(0)
  FDC("FIOR DI CONIO"),
  @HiveField(1)
  qFDC("QUASI FIOR DI CONIO"),
  @HiveField(2)
  SPL("SPLENDIDO"),
  @HiveField(3)
  qSPL("QUASI SPLENDIDO"),
  @HiveField(4)
  BB("BELLISSIMO"),
  @HiveField(5)
  qBB("QUASI BELLISSIMO"),
  @HiveField(6)
  MB("MOLTO BELLO"),
  @HiveField(7)
  B("BELLO"),
  @HiveField(8)
  D("DISCRETO"),
  @HiveField(9)
  ILLEGIBILE("ILLEGIBILE");

  final String wording;
  const OptionConservation(this.wording);
}
