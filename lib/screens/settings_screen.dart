import 'package:flutter/material.dart';
import '../services/settings_service.dart';
import '../services/storage_service.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  final SettingsService service = SettingsService();
  final StorageService storage = StorageService();

  bool temaEscuro = false;
  bool notificacao = true;
  String idioma = 'Português';

  final tokenController = TextEditingController();
  String tokenSalvo = '';

  @override
  void initState() {
    super.initState();
    carregarDados();
  }

  void carregarDados() async {
    temaEscuro = await service.carregarTema();
    notificacao = await service.carregarNotificacao();
    idioma = await service.carregarIdioma();

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        title: const Text('Configurações'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            Card(
              elevation: 3,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              child: Column(
                children: [
                  SwitchListTile(
                    title: const Text(
                      'Modo Escuro',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    secondary: const Icon(Icons.dark_mode),
                    value: temaEscuro,
                    onChanged: (value) async {
                      setState(() {
                        temaEscuro = value;
                      });

                      await service.salvarTema(value);
                    },
                  ),
                  const Divider(),

                  ListTile(
                    leading: const Icon(Icons.language),
                    title: const Text(
                      'Idioma',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    trailing: DropdownButton<String>(
                      value: idioma,
                      underline: Container(),
                      items: const [
                        DropdownMenuItem(
                          value: 'Português',
                          child: Text('Português'),
                        ),
                        DropdownMenuItem(
                          value: 'Inglês',
                          child: Text('Inglês'),
                        ),
                      ],
                      onChanged: (value) async {
                        setState(() {
                          idioma = value!;
                        });

                        await service.salvarIdioma(value!);
                      },
                    ),
                  ),

                  const Divider(),

                  SwitchListTile(
                    title: const Text(
                      'Notificações',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    secondary: const Icon(Icons.notifications),
                    value: notificacao,
                    onChanged: (value) async {
                      setState(() {
                        notificacao = value;
                      });

                      await service.salvarNotificacao(value);
                    },
                  ),
                ],
              ),
            ),

            const SizedBox(height: 25),

            Card(
              elevation: 3,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    const Row(
                      children: [
                        Icon(Icons.security),
                        SizedBox(width: 10),
                        Text(
                          'Armazenamento Seguro',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 20),

                    TextField(
                      controller: tokenController,
                      decoration: InputDecoration(
                        labelText: 'Token',
                        prefixIcon: const Icon(Icons.key),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),

                    const SizedBox(height: 15),

                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton.icon(
                        onPressed: () async {
                          await storage.salvarToken(
                            tokenController.text,
                          );

                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Token salvo'),
                            ),
                          );
                        },
                        icon: const Icon(Icons.save),
                        label: const Text('Salvar Token'),
                      ),
                    ),

                    const SizedBox(height: 10),

                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton.icon(
                        onPressed: () async {
                          String? token =
                              await storage.recuperarToken();

                          setState(() {
                            tokenSalvo = token ?? '';
                          });
                        },
                        icon: const Icon(Icons.visibility),
                        label: const Text('Recuperar Token'),
                      ),
                    ),

                    const SizedBox(height: 10),

                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red,
                          foregroundColor: Colors.white,
                        ),
                        onPressed: () async {
                          await storage.deletarToken();

                          setState(() {
                            tokenSalvo = '';
                          });
                        },
                        icon: const Icon(Icons.delete),
                        label: const Text('Deletar Token'),
                      ),
                    ),

                    const SizedBox(height: 20),

                    if (tokenSalvo.isNotEmpty)
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.green.shade100,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(
                          'Token salvo:\n$tokenSalvo',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}