// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'resident.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ResidentAdapter extends TypeAdapter<Resident> {
  @override
  final int typeId = 0;

  @override
  Resident read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Resident(
      id: fields[0] as String?,
      firstName: fields[1] as String,
      lastName: fields[2] as String,
      middleName: fields[3] as String?,
      householdId: fields[4] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Resident obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.firstName)
      ..writeByte(2)
      ..write(obj.lastName)
      ..writeByte(3)
      ..write(obj.middleName)
      ..writeByte(4)
      ..write(obj.householdId);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ResidentAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
