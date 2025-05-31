// Classe que representa uma pessoa com suas características
class Pessoa {
  // Nome da pessoa
  final String nome;

  // Peso em quilogramas (kg)
  final double peso;

  // Altura em metros (m)
  final double altura;

  // Construtor que exige todos os dados da pessoa
  Pessoa({required this.nome, required this.peso, required this.altura});

  // Função que calcula o IMC
  // Fórmula: peso / (altura * altura)
  double calcularIMC() {
    // Verifica se os valores são válidos
    if (altura <= 0 || peso <= 0) {
      throw Exception('Altura e peso devem ser maiores que zero');
    }
    // Faz o cálculo e retorna o resultado
    return peso / (altura * altura);
  }

  // Função que retorna a classificação do IMC de acordo com a tabela da OMS
  String getClassificacaoIMC() {
    // Calcula o IMC primeiro
    double imc = calcularIMC();

    // Verifica em qual faixa o IMC se encontra
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
}
