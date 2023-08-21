// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tarama_adapter.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TaramaAdapter extends TypeAdapter<Tarama> {
  @override
  final int typeId = 3;

  @override
  Tarama read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Tarama(
      ders: fields[0] as String,
      dersCode: fields[1] as String,
      konu: fields[2] as String,
      count: fields[3] as int,
      createdAt: fields[4] as DateTime,
      kind: fields[5] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Tarama obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.ders)
      ..writeByte(1)
      ..write(obj.dersCode)
      ..writeByte(2)
      ..write(obj.konu)
      ..writeByte(3)
      ..write(obj.count)
      ..writeByte(4)
      ..write(obj.createdAt)
      ..writeByte(5)
      ..write(obj.kind);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TaramaAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
