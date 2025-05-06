// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'barangay_details.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class BarangayDetailsAdapter extends TypeAdapter<BarangayDetails> {
  @override
  final int typeId = 12;

  @override
  BarangayDetails read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return BarangayDetails(
      name: fields[0] as String,
      city: fields[1] as String,
      province: fields[2] as String,
      zipCode: fields[3] as int,
      logoPath: fields[4] as String,
    );
  }

  @override
  void write(BinaryWriter writer, BarangayDetails obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.city)
      ..writeByte(2)
      ..write(obj.province)
      ..writeByte(3)
      ..write(obj.zipCode)
      ..writeByte(4)
      ..write(obj.logoPath);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BarangayDetailsAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
