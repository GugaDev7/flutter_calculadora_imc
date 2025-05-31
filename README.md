# Flutter Calculadora de IMC

Este é um aplicativo Flutter para calcular o Índice de Massa Corporal (IMC) de uma pessoa.

## Funcionalidades

- Cálculo do IMC baseado no peso e altura
- Classificação do IMC de acordo com a tabela padrão
- Interface amigável e intuitiva
- Validação de dados de entrada
- Tratamento de exceções

## Como usar

1. Clone o repositório
2. Execute `flutter pub get` para instalar as dependências
3. Execute `flutter run` para iniciar o aplicativo

## Estrutura do projeto

- `lib/models/pessoa.dart`: Classe que representa uma pessoa e contém a lógica de cálculo do IMC
- `lib/main.dart`: Interface do usuário e lógica da aplicação
- `test/pessoa_test.dart`: Testes unitários

## Tabela de Classificação do IMC

- Menor que 16: Magreza grave
- 16 a 17: Magreza moderada
- 17 a 18.5: Magreza leve
- 18.5 a 25: Saudável
- 25 a 30: Sobrepeso
- 30 a 35: Obesidade Grau I
- 35 a 40: Obesidade Grau II
- Maior que 40: Obesidade Grau III

## Testes

Para executar os testes unitários:

```bash
flutter test
```
## 📧 Contato

**Autor:** Gustavo Rodrigues

**Email:** gustavo.rodriguesrj@outlook.com

**LinkedIn:** [Meu Perfil](https://www.linkedin.com/in/gustavo-rodrigues-167264361?utm_source=share&utm_campaign=share_via&utm_content=profile&utm_medium=android_app)

---

Desenvolvido com ❤️ usando Flutter.
