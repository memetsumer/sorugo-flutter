// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'exam_adapter.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ExamAdapter extends TypeAdapter<Exam> {
  @override
  final int typeId = 4;

  @override
  Exam read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Exam(
      name: fields[0] as String,
      code: fields[1] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Exam obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.code);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ExamAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
