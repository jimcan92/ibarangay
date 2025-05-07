// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'official.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class OfficialAdapter extends TypeAdapter<Official> {
  @override
  final int typeId = 14;

  @override
  Official read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Official(
      id: fields[0] as String,
      type: fields[1] as OfficialType,
      committeeOn: fields[2] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, Official obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.type)
      ..writeByte(2)
      ..write(obj.committeeOn);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is OfficialAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class OfficialTypeAdapter extends TypeAdapter<OfficialType> {
  @override
  final int typeId = 15;

  @override
  OfficialType read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return OfficialType.captain;
      case 1:
        return OfficialType.skChairman;
      case 2:
        return OfficialType.secretary;
      case 3:
        return OfficialType.treasurer;
      case 4:
        return OfficialType.firstCouncilor;
      case 5:
        return OfficialType.seconCouncilor;
      case 6:
        return OfficialType.thirdCouncilor;
      case 7:
        return OfficialType.fourthCouncilor;
      case 8:
        return OfficialType.fifthCouncilor;
      case 9:
        return OfficialType.sixthCouncilor;
      case 10:
        return OfficialType.seventhCouncilor;
      default:
        return OfficialType.captain;
    }
  }

  @override
  void write(BinaryWriter writer, OfficialType obj) {
    switch (obj) {
      case OfficialType.captain:
        writer.writeByte(0);
        break;
      case OfficialType.skChairman:
        writer.writeByte(1);
        break;
      case OfficialType.secretary:
        writer.writeByte(2);
        break;
      case OfficialType.treasurer:
        writer.writeByte(3);
        break;
      case OfficialType.firstCouncilor:
        writer.writeByte(4);
        break;
      case OfficialType.seconCouncilor:
        writer.writeByte(5);
        break;
      case OfficialType.thirdCouncilor:
        writer.writeByte(6);
        break;
      case OfficialType.fourthCouncilor:
        writer.writeByte(7);
        break;
      case OfficialType.fifthCouncilor:
        writer.writeByte(8);
        break;
      case OfficialType.sixthCouncilor:
        writer.writeByte(9);
        break;
      case OfficialType.seventhCouncilor:
        writer.writeByte(10);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is OfficialTypeAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
