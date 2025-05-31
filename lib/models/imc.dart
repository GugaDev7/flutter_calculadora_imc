import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

part 'imc.g.dart';

@HiveType(typeId: 0)
class IMC extends HiveObject {
  @HiveField(0)
  final String nome;

  @HiveField(1)
  final double peso;

  @HiveField(2)
  final double altura;

  @HiveField(3)
  final DateTime data;

  IMC({
    required this.nome,
    required this.peso,
    required this.altura,
    DateTime? data,
  }) : data = data ?? DateTime.now();

  double calcular() {
    if (altura <= 0 || peso <= 0) {
      throw Exception('Altura e peso devem ser maiores que zero');
    }
    return peso / (altura * altura);
  }

  String getClassificacao() {
    double imc = calcular();
    if (imc < 16) {
      return 'Magreza grave';
    } else if (imc < 17) {
      return 'Magreza moderada';
    } else if (imc < 18.5) {
      return 'Magreza leve';
    } else if (imc < 25) {
      return 'Saudável';
    } else if (imc < 30) {
      return 'Sobrepeso';
    } else if (imc < 35) {
      return 'Obesidade Grau I';
    } else if (imc < 40) {
      return 'Obesidade Grau II';
    } else {
      return 'Obesidade Grau III';
    }
  }

  Color getCorClassificacao() {
    double imc = calcular();
    if (imc < 18.5) {
      return Colors.orange;
    } else if (imc < 25) {
      return Colors.green;
    } else if (imc < 30) {
      return Colors.yellow.shade700;
    } else {
      return Colors.red;
    }
  }
}
