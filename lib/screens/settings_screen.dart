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
      appBar: AppBar(
        title: const Text('Configurações'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            SwitchListTile(
              title: const Text('Modo Escuro'),
              value: temaEscuro,
              onChanged: (value) async {
                setState(() {
                  temaEscuro = value;
                });

                await service.salvarTema(value);
              },
            ),
            DropdownButton<String>(
              value: idioma,
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
            SwitchListTile(
              title: const Text('Notificações'),
              value: notificacao,
              onChanged: (value) async {
                setState(() {
                  notificacao = value;
                });

                await service.salvarNotificacao(value);
              },
            ),
            const SizedBox(height: 20),
            TextField(
              controller: tokenController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Token',
              ),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () async {
                await storage.salvarToken(tokenController.text);
              },
              child: const Text('Salvar Token'),
            ),
            ElevatedButton(
              onPressed: () async {
                String? token = await storage.recuperarToken();

                setState(() {
                  tokenSalvo = token ?? '';
                });
              },
              child: const Text('Recuperar Token'),
            ),
            ElevatedButton(
              onPressed: () async {
                await storage.deletarToken();

                setState(() {
                  tokenSalvo = '';
                });
              },
              child: const Text('Deletar Token'),
            ),
            Text(tokenSalvo),
          ],
        ),
      ),
    );
  }
}
