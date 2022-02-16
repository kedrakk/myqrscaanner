// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'main.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class QrHistoryAdapter extends TypeAdapter<QrHistory> {
  @override
  final int typeId = 1;

  @override
  QrHistory read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return QrHistory()
      ..id = fields[0] as int?
      ..name = fields[1] as String?
      ..processingDate = fields[2] as String?;
  }

  @override
  void write(BinaryWriter writer, QrHistory obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.processingDate);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is QrHistoryAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
