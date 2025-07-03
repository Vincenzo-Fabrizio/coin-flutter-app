// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'option_conservation.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class OptionConservationAdapter extends TypeAdapter<OptionConservation> {
  @override
  final int typeId = 1;

  @override
  OptionConservation read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return OptionConservation.FDC;
      case 1:
        return OptionConservation.qFDC;
      case 2:
        return OptionConservation.SPL;
      case 3:
        return OptionConservation.qSPL;
      case 4:
        return OptionConservation.BB;
      case 5:
        return OptionConservation.qBB;
      case 6:
        return OptionConservation.MB;
      case 7:
        return OptionConservation.B;
      case 8:
        return OptionConservation.D;
      case 9:
        return OptionConservation.ILLEGIBILE;
      default:
        return OptionConservation.FDC;
    }
  }

  @override
  void write(BinaryWriter writer, OptionConservation obj) {
    switch (obj) {
      case OptionConservation.FDC:
        writer.writeByte(0);
        break;
      case OptionConservation.qFDC:
        writer.writeByte(1);
        break;
      case OptionConservation.SPL:
        writer.writeByte(2);
        break;
      case OptionConservation.qSPL:
        writer.writeByte(3);
        break;
      case OptionConservation.BB:
        writer.writeByte(4);
        break;
      case OptionConservation.qBB:
        writer.writeByte(5);
        break;
      case OptionConservation.MB:
        writer.writeByte(6);
        break;
      case OptionConservation.B:
        writer.writeByte(7);
        break;
      case OptionConservation.D:
        writer.writeByte(8);
        break;
      case OptionConservation.ILLEGIBILE:
        writer.writeByte(9);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is OptionConservationAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
