import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../models/configuracoes.dart';

class ConfiguracoesPage extends StatefulWidget {
  const ConfiguracoesPage({super.key});

  @override
  State<ConfiguracoesPage> createState() => _ConfiguracoesPageState();
}

class _ConfiguracoesPageState extends State<ConfiguracoesPage> {
  final _formKey = GlobalKey<FormState>();
  final _alturaController = TextEditingController();
  late Box<Configuracoes> _configBox;
  late Configuracoes _config;

  @override
  void initState() {
    super.initState();
    _configBox = Hive.box<Configuracoes>('configuracoes');
    _config = _configBox.get('config') ?? Configuracoes();
    _alturaController.text = _config.alturaInicial.toString();
  }

  void _salvarConfiguracoes() {
    if (_formKey.currentState!.validate()) {
      _config.alturaInicial = double.parse(_alturaController.text);
      _configBox.put('config', _config);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Configurações salvas com sucesso!'),
          backgroundColor: Colors.green,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Configurações'),
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Icon(
                Icons.settings,
                size: 100,
                color: Colors.deepPurpleAccent,
              ),
              const SizedBox(height: 32),
              TextFormField(
                controller: _alturaController,
                decoration: const InputDecoration(
                  labelText: 'Altura Inicial Padrão (m)',
                  prefixIcon: Icon(Icons.height),
                  hintText: 'Exemplo: 1.75',
                ),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, digite a altura inicial';
                  }
                  final altura = double.tryParse(value);
                  if (altura == null || altura <= 0) {
                    return 'Digite uma altura válida';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 32),
              ElevatedButton.icon(
                onPressed: _salvarConfiguracoes,
                icon: const Icon(Icons.save),
                label: const Text(
                  'Salvar Configurações',
                  style: TextStyle(fontSize: 18),
                ),
              ),
              const SizedBox(height: 32),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Informações:',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        '• Unidade de Peso: ${_config.unidadePeso}',
                        style: const TextStyle(fontSize: 16),
                      ),
                      Text(
                        '• Unidade de Altura: ${_config.unidadeAltura}',
                        style: const TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _alturaController.dispose();
    super.dispose();
  }
}
