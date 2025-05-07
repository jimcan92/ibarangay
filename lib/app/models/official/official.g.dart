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
        return OfficialType.councelor;
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
      case OfficialType.councelor:
        writer.writeByte(1);
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
