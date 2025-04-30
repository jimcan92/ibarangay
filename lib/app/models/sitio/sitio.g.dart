// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sitio.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SitioAdapter extends TypeAdapter<Sitio> {
  @override
  final int typeId = 4;

  @override
  Sitio read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Sitio(
      id: fields[0] as String?,
      name: fields[1] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Sitio obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SitioAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
