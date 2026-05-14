import 'package:flutter/material.dart';
import 'profile_screen.dart';
import 'settings_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,

      appBar: AppBar(
        title: const Text('LocalVault'),
        centerTitle: true,
      ),

      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.storage,
              size: 90,
            ),

            const SizedBox(height: 20),

            const Text(
              'Armazenamento Local',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 10),

            const Text(
              'Aplicação utilizando SharedPreferences, Hive e Secure Storage.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                color: Colors.black54,
              ),
            ),

            const SizedBox(height: 40),

            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    SizedBox(
                      width: double.infinity,
                      height: 55,
                      child: ElevatedButton.icon(
                        icon: const Icon(Icons.settings),
                        label: const Text(
                          'Configurações',
                          style: TextStyle(fontSize: 18),
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  const SettingsScreen(),
                            ),
                          );
                        },
                      ),
                    ),

                    const SizedBox(height: 20),

                    SizedBox(
                      width: double.infinity,
                      height: 55,
                      child: ElevatedButton.icon(
                        icon: const Icon(Icons.person),
                        label: const Text(
                          'Perfil do Usuário',
                          style: TextStyle(fontSize: 18),
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  const ProfileScreen(),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 40),

            Container(
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: Colors.blue.shade50,
                borderRadius: BorderRadius.circular(15),
              ),
              child: const Row(
                children: [
                  Icon(Icons.info_outline),

                  SizedBox(width: 10),

                  Expanded(
                    child: Text(
                      'Os dados são armazenados localmente utilizando diferentes métodos de persistência.',
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}