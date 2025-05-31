// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'imc.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class IMCAdapter extends TypeAdapter<IMC> {
  @override
  final int typeId = 0;

  @override
  IMC read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return IMC(
      nome: fields[0] as String,
      peso: fields[1] as double,
      altura: fields[2] as double,
      data: fields[3] as DateTime?,
    );
  }

  @override
  void write(BinaryWriter writer, IMC obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.nome)
      ..writeByte(1)
      ..write(obj.peso)
      ..writeByte(2)
      ..write(obj.altura)
      ..writeByte(3)
      ..write(obj.data);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is IMCAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
