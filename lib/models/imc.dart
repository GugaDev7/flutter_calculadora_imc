import 'package:flutter/material.dart';

class IMC {
  final double peso;
  final double altura;
  final DateTime data;
  final String nome;

  IMC({
    required this.peso,
    required this.altura,
    required this.nome,
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
