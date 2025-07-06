// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'coin.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CoinAdapter extends TypeAdapter<Coin> {
  @override
  final int typeId = 0;

  @override
  Coin read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Coin(
      id: fields[0] as String,
      name: fields[1] as String,
      year: fields[2] as int,
      material: fields[3] as String,
      weight: fields[4] as double,
      diameter: fields[5] as double,
      height: fields[6] as double,
      price: fields[7] as double,
      conservationObverse: fields[8] as OptionConservation,
      conservationReverse: fields[9] as OptionConservation,
      degree: fields[10] as NumismaticRarity,
    );
  }

  @override
  void write(BinaryWriter writer, Coin obj) {
    writer
      ..writeByte(11)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.year)
      ..writeByte(3)
      ..write(obj.material)
      ..writeByte(4)
      ..write(obj.weight)
      ..writeByte(5)
      ..write(obj.diameter)
      ..writeByte(6)
      ..write(obj.height)
      ..writeByte(7)
      ..write(obj.price)
      ..writeByte(8)
      ..write(obj.conservationObverse)
      ..writeByte(9)
      ..write(obj.conservationReverse)
      ..writeByte(10)
      ..write(obj.degree);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CoinAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
