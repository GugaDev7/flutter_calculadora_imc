// Importa os pacotes necessários para teste
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_calculadora_imc/models/pessoa.dart';

void main() {
  // Grupo de testes da classe Pessoa
  group('Testes da classe Pessoa', () {
    // Teste para verificar se o cálculo do IMC está correto
    test('Deve calcular o IMC corretamente', () {
      // Cria uma pessoa com valores conhecidos
      final pessoa = Pessoa(
        nome: 'João',
        peso: 70.0, // 70 kg
        altura: 1.75, // 1.75 m
      );

      // 70 / (1.75 * 1.75) = 22.86
      expect(pessoa.calcularIMC(), closeTo(22.86, 0.01));
    });

    // Teste para verificar se a classificação está correta
    test('Deve classificar o IMC corretamente', () {
      // Cria uma pessoa com IMC na faixa "Saudável"
      final pessoa = Pessoa(
        nome: 'Maria',
        peso: 60.0, // 60 kg
        altura: 1.65, // 1.65 m
      );

      // 60 / (1.65 * 1.65) = 22.04
      expect(pessoa.calcularIMC(), closeTo(22.04, 0.01));
      expect(pessoa.getClassificacaoIMC(), 'Saudável');
    });

    // Teste para verificar se o erro é lançado quando altura é zero
    test('Deve lançar exceção para altura zero', () {
      final pessoa = Pessoa(
        nome: 'Pedro',
        peso: 70.0,
        altura: 0.0, // Altura inválida
      );

      // Deve lançar uma exceção quando tentar calcular
      expect(() => pessoa.calcularIMC(), throwsException);
    });

    // Teste para verificar se o erro é lançado quando peso é zero
    test('Deve lançar exceção para peso zero', () {
      final pessoa = Pessoa(
        nome: 'Ana',
        peso: 0.0, // Peso inválido
        altura: 1.70,
      );

      // Deve lançar uma exceção quando tentar calcular
      expect(() => pessoa.calcularIMC(), throwsException);
    });

    // Teste para verificar outras classificações de IMC
    test('Deve classificar corretamente diferentes faixas de IMC', () {
      // Teste para Obesidade Grau I
      final pessoaObesa = Pessoa(
        nome: 'Carlos',
        peso: 100.0, // 100 kg
        altura: 1.80, // 1.80 m
      );
      // 100 / (1.80 * 1.80) = 30.86
      expect(pessoaObesa.getClassificacaoIMC(), 'Obesidade Grau I');

      // Teste para Magreza leve
      final pessoaMagra = Pessoa(
        nome: 'Julia',
        peso: 50.0, // 50 kg
        altura: 1.70, // 1.70 m
      );
      // 50 / (1.70 * 1.70) = 17.30
      expect(pessoaMagra.getClassificacaoIMC(), 'Magreza leve');
    });
  });
}
