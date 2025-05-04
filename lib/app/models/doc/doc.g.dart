// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'doc.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class DocAdapter extends TypeAdapter<Doc> {
  @override
  final int typeId = 7;

  @override
  Doc read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Doc(
      id: fields[0] as String,
      title: fields[1] as String,
      ext: fields[2] as String,
      desc: fields[3] as String?,
      category: fields[4] as DocCategory,
      path: fields[5] as String,
      addedBy: fields[6] as String,
      addedDate: fields[7] as DateTime,
    );
  }

  @override
  void write(BinaryWriter writer, Doc obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.title)
      ..writeByte(2)
      ..write(obj.ext)
      ..writeByte(3)
      ..write(obj.desc)
      ..writeByte(4)
      ..write(obj.category)
      ..writeByte(5)
      ..write(obj.path)
      ..writeByte(6)
      ..write(obj.addedBy)
      ..writeByte(7)
      ..write(obj.addedDate);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DocAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class DocCategoryAdapter extends TypeAdapter<DocCategory> {
  @override
  final int typeId = 8;

  @override
  DocCategory read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return DocCategory.ordinance;
      case 1:
        return DocCategory.budget;
      case 2:
        return DocCategory.minutes;
      default:
        return DocCategory.ordinance;
    }
  }

  @override
  void write(BinaryWriter writer, DocCategory obj) {
    switch (obj) {
      case DocCategory.ordinance:
        writer.writeByte(0);
        break;
      case DocCategory.budget:
        writer.writeByte(1);
        break;
      case DocCategory.minutes:
        writer.writeByte(2);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DocCategoryAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
