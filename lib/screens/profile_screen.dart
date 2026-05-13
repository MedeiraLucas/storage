import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import '../models/user_profile.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final nomeController = TextEditingController();
  final emailController = TextEditingController();
  final pontuacaoController = TextEditingController();

  late Box<UserProfile> box;

  @override
  void initState() {
    super.initState();
    box = Hive.box<UserProfile>('profileBox');
  }

  void salvarPerfil() {
    UserProfile profile = UserProfile(
      nome: nomeController.text,
      email: emailController.text,
      dataCadastro: DateTime.now().toString(),
      pontuacao: int.parse(pontuacaoController.text),
    );

    box.put('perfil', profile);

    setState(() {});
  }

  void limparPerfil() {
    box.clear();

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    UserProfile? profile = box.get('perfil');

    return Scaffold(
      appBar: AppBar(
        title: const Text('Perfil'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            TextField(
              controller: nomeController,
              decoration: const InputDecoration(
                labelText: 'Nome',
              ),
            ),
            TextField(
              controller: emailController,
              decoration: const InputDecoration(
                labelText: 'Email',
              ),
            ),
            TextField(
              controller: pontuacaoController,
              decoration: const InputDecoration(
                labelText: 'Pontuação',
              ),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: salvarPerfil,
              child: const Text('Salvar Perfil'),
            ),
            ElevatedButton(
              onPressed: limparPerfil,
              child: const Text('Limpar Perfil'),
            ),
            const SizedBox(height: 20),
            if (profile != null)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Nome: ${profile.nome}'),
                  Text('Email: ${profile.email}'),
                  Text('Cadastro: ${profile.dataCadastro}'),
                  Text('Pontuação: ${profile.pontuacao}'),
                ],
              ),
          ],
        ),
      ),
    );
  }
}
