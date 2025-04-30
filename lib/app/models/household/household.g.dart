// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'household.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class HouseholdAdapter extends TypeAdapter<Household> {
  @override
  final int typeId = 1;

  @override
  Household read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Household(
      id: fields[0] as String?,
      addressId: fields[1] as String,
      headOfFamilyId: fields[2] as String?,
      residentIds: (fields[3] as List).cast<String>(),
    );
  }

  @override
  void write(BinaryWriter writer, Household obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.addressId)
      ..writeByte(2)
      ..write(obj.headOfFamilyId)
      ..writeByte(3)
      ..write(obj.residentIds);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HouseholdAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
