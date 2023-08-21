// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'deneme_adapter.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class DenemeAdapter extends TypeAdapter<Deneme> {
  @override
  final int typeId = 2;

  @override
  Deneme read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Deneme(
      name: fields[0] as String,
      code: fields[1] as String,
      kind: fields[2] as String,
      total: fields[3] as int,
      dersler: (fields[4] as List?)
          ?.map((dynamic e) => (e as Map).cast<String, dynamic>())
          .toList(),
    );
  }

  @override
  void write(BinaryWriter writer, Deneme obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.code)
      ..writeByte(2)
      ..write(obj.kind)
      ..writeByte(3)
      ..write(obj.total)
      ..writeByte(4)
      ..write(obj.dersler);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DenemeAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
