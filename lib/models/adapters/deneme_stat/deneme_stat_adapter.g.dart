// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'deneme_stat_adapter.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class DenemeStatAdapter extends TypeAdapter<DenemeStat> {
  @override
  final int typeId = 6;

  @override
  DenemeStat read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return DenemeStat(
      dersName: fields[0] as String,
      dersCode: fields[1] as String,
      ayt: fields[2] as bool,
      dogru: fields[3] as int,
      yanlis: fields[4] as int,
      createdAt: fields[6] as DateTime,
      sure: fields[5] as int?,
    );
  }

  @override
  void write(BinaryWriter writer, DenemeStat obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.dersName)
      ..writeByte(1)
      ..write(obj.dersCode)
      ..writeByte(2)
      ..write(obj.ayt)
      ..writeByte(3)
      ..write(obj.dogru)
      ..writeByte(4)
      ..write(obj.yanlis)
      ..writeByte(5)
      ..write(obj.sure)
      ..writeByte(6)
      ..write(obj.createdAt);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DenemeStatAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
