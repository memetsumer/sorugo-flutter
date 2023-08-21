// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ders_adapter.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class DersAdapter extends TypeAdapter<Ders> {
  @override
  final int typeId = 1;

  @override
  Ders read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Ders(
      name: fields[0] as String,
      code: fields[1] as String,
      konular: (fields[2] as List)
          .map((dynamic e) => (e as Map).cast<String, String>())
          .toList(),
      ayt: fields[3] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, Ders obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.code)
      ..writeByte(2)
      ..write(obj.konular)
      ..writeByte(3)
      ..write(obj.ayt);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DersAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
