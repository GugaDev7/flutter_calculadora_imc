import 'package:flutter/material.dart';
import 'package:flutter_calculadora_imc/models/imc.dart';
import 'package:flutter_calculadora_imc/models/configuracoes.dart';
import 'package:flutter_calculadora_imc/pages/configuracoes_page.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:path_provider/path_provider.dart' as path_provider;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Inicializa o Hive
  if (kIsWeb) {
    await Hive.initFlutter();
  } else {
    final appDocumentDir = await path_provider
        .getApplicationDocumentsDirectory();
    await Hive.initFlutter(appDocumentDir.path);
  }

  // Registra os adaptadores
  Hive.registerAdapter(IMCAdapter());
  Hive.registerAdapter(ConfiguracoesAdapter());

  // Abre as boxes
  await Hive.openBox<IMC>('historico_imc');
  await Hive.openBox<Configuracoes>('configuracoes');

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Calculadora IMC',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
        useMaterial3: true,
        inputDecorationTheme: const InputDecorationTheme(
          contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _formKey = GlobalKey<FormState>();
  final _nomeController = TextEditingController();
  final _pesoController = TextEditingController();
  final _alturaController = TextEditingController();
  late Box<IMC> _historicoBox;
  late Box<Configuracoes> _configBox;

  @override
  void initState() {
    super.initState();
    _historicoBox = Hive.box<IMC>('historico_imc');
    _configBox = Hive.box<Configuracoes>('configuracoes');

    // Carrega a altura inicial das configurações
    final config = _configBox.get('config') ?? Configuracoes();
    _alturaController.text = config.alturaInicial.toString();
  }

  void _calcularIMC() {
    if (_formKey.currentState!.validate()) {
      try {
        final imc = IMC(
          nome: _nomeController.text,
          peso: double.parse(_pesoController.text),
          altura: double.parse(_alturaController.text),
        );

        // Salva no Hive
        _historicoBox.add(imc);

        // Limpa os campos
        _pesoController.clear();
        _alturaController.text =
            _configBox.get('config')?.alturaInicial.toString() ?? '';

        setState(() {}); // Atualiza a lista
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Erro ao calcular IMC: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Calculadora de IMC'),
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const ConfiguracoesPage(),
                ),
              ).then((_) {
                // Atualiza a altura ao voltar das configurações
                final config = _configBox.get('config');
                if (config != null) {
                  setState(() {
                    _alturaController.text = config.alturaInicial.toString();
                  });
                }
              });
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            flex: 2,
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20.0),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    const Icon(
                      Icons.calculate,
                      size: 100,
                      color: Colors.deepPurpleAccent,
                    ),
                    const SizedBox(height: 32),
                    TextFormField(
                      controller: _nomeController,
                      decoration: const InputDecoration(
                        labelText: 'Nome',
                        prefixIcon: Icon(Icons.person),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Por favor, digite seu nome';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _pesoController,
                      decoration: const InputDecoration(
                        labelText: 'Peso (kg)',
                        prefixIcon: Icon(Icons.monitor_weight),
                        hintText: 'Exemplo: 70.5',
                      ),
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Por favor, digite seu peso';
                        }
                        if (double.tryParse(value) == null) {
                          return 'Digite um número válido';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _alturaController,
                      decoration: const InputDecoration(
                        labelText: 'Altura (m)',
                        prefixIcon: Icon(Icons.height),
                        hintText: 'Exemplo: 1.75',
                      ),
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Por favor, digite sua altura';
                        }
                        if (double.tryParse(value) == null) {
                          return 'Digite um número válido';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 32),
                    ElevatedButton.icon(
                      onPressed: _calcularIMC,
                      icon: const Icon(Icons.calculate),
                      label: const Text(
                        'Calcular IMC',
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          ValueListenableBuilder(
            valueListenable: _historicoBox.listenable(),
            builder: (context, Box<IMC> box, _) {
              if (box.isEmpty) {
                return const SizedBox.shrink();
              }

              return Expanded(
                flex: 3,
                child: Column(
                  children: [
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        'Histórico de IMC',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Expanded(
                      child: ListView.builder(
                        itemCount: box.length,
                        padding: const EdgeInsets.all(8),
                        itemBuilder: (context, index) {
                          final imc = box.getAt(box.length - 1 - index)!;
                          final resultado = imc.calcular();
                          final classificacao = imc.getClassificacao();
                          final cor = imc.getCorClassificacao();

                          return Card(
                            elevation: 4,
                            margin: const EdgeInsets.symmetric(vertical: 8),
                            child: ListTile(
                              title: Text(
                                imc.nome,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('IMC: ${resultado.toStringAsFixed(2)}'),
                                  Text(
                                    classificacao,
                                    style: TextStyle(
                                      color: cor,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    'Data: ${DateFormat('dd/MM/yyyy HH:mm').format(imc.data)}',
                                    style: TextStyle(
                                      color: Colors.grey[600],
                                      fontSize: 12,
                                    ),
                                  ),
                                ],
                              ),
                              trailing: IconButton(
                                icon: const Icon(Icons.delete),
                                onPressed: () {
                                  box.deleteAt(box.length - 1 - index);
                                },
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _nomeController.dispose();
    _pesoController.dispose();
    _alturaController.dispose();
    super.dispose();
  }
}
