import 'package:hive/hive.dart';

part 'configuracoes.g.dart';

@HiveType(typeId: 1)
class Configuracoes extends HiveObject {
  @HiveField(0)
  double alturaInicial;

  @HiveField(1)
  String unidadePeso;

  @HiveField(2)
  String unidadeAltura;

  Configuracoes({
    this.alturaInicial = 1.70,
    this.unidadePeso = 'kg',
    this.unidadeAltura = 'm',
  });
}
