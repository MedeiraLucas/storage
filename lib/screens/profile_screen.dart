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

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Perfil salvo com sucesso'),
      ),
    );

    setState(() {});
  }

  void limparPerfil() {
    box.clear();

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Perfil removido'),
      ),
    );

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    UserProfile? profile = box.get('perfil');

    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        title: const Text('Perfil do Usuário'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    const CircleAvatar(
                      radius: 40,
                      child: Icon(
                        Icons.person,
                        size: 40,
                      ),
                    ),

                    const SizedBox(height: 20),

                    TextField(
                      controller: nomeController,
                      decoration: InputDecoration(
                        labelText: 'Nome',
                        prefixIcon: const Icon(Icons.person),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),

                    const SizedBox(height: 15),

                    TextField(
                      controller: emailController,
                      decoration: InputDecoration(
                        labelText: 'Email',
                        prefixIcon: const Icon(Icons.email),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),

                    const SizedBox(height: 15),

                    TextField(
                      controller: pontuacaoController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelText: 'Pontuação',
                        prefixIcon: const Icon(Icons.star),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),

                    const SizedBox(height: 20),

                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton.icon(
                        onPressed: salvarPerfil,
                        icon: const Icon(Icons.save),
                        label: const Text('Salvar Perfil'),
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
                        onPressed: limparPerfil,
                        icon: const Icon(Icons.delete),
                        label: const Text('Limpar Perfil'),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 25),

            if (profile != null)
              Card(
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Row(
                        children: [
                          Icon(Icons.account_circle, size: 28),
                          SizedBox(width: 10),
                          Text(
                            'Dados Salvos',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),

                      const Divider(height: 30),

                      ListTile(
                        leading: const Icon(Icons.person),
                        title: Text(profile.nome),
                        subtitle: const Text('Nome'),
                      ),

                      ListTile(
                        leading: const Icon(Icons.email),
                        title: Text(profile.email),
                        subtitle: const Text('Email'),
                      ),

                      ListTile(
                        leading: const Icon(Icons.calendar_month),
                        title: Text(profile.dataCadastro),
                        subtitle: const Text('Data de Cadastro'),
                      ),

                      ListTile(
                        leading: const Icon(Icons.star),
                        title: Text(
                          profile.pontuacao.toString(),
                        ),
                        subtitle: const Text('Pontuação'),
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