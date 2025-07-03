// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'numismatic_rarity.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class NumismaticRarityAdapter extends TypeAdapter<NumismaticRarity> {
  @override
  final int typeId = 2;

  @override
  NumismaticRarity read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return NumismaticRarity.R5;
      case 1:
        return NumismaticRarity.R4;
      case 2:
        return NumismaticRarity.R3;
      case 3:
        return NumismaticRarity.R2;
      case 4:
        return NumismaticRarity.R;
      case 5:
        return NumismaticRarity.NC;
      case 6:
        return NumismaticRarity.C;
      default:
        return NumismaticRarity.R5;
    }
  }

  @override
  void write(BinaryWriter writer, NumismaticRarity obj) {
    switch (obj) {
      case NumismaticRarity.R5:
        writer.writeByte(0);
        break;
      case NumismaticRarity.R4:
        writer.writeByte(1);
        break;
      case NumismaticRarity.R3:
        writer.writeByte(2);
        break;
      case NumismaticRarity.R2:
        writer.writeByte(3);
        break;
      case NumismaticRarity.R:
        writer.writeByte(4);
        break;
      case NumismaticRarity.NC:
        writer.writeByte(5);
        break;
      case NumismaticRarity.C:
        writer.writeByte(6);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is NumismaticRarityAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
