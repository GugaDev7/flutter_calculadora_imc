// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'configuracoes.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ConfiguracoesAdapter extends TypeAdapter<Configuracoes> {
  @override
  final int typeId = 1;

  @override
  Configuracoes read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Configuracoes(
      alturaInicial: fields[0] as double,
      unidadePeso: fields[1] as String,
      unidadeAltura: fields[2] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Configuracoes obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.alturaInicial)
      ..writeByte(1)
      ..write(obj.unidadePeso)
      ..writeByte(2)
      ..write(obj.unidadeAltura);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ConfiguracoesAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
